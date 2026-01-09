import shutil
import os
import re
import click
from pathlib import Path
from loguru import logger
import csv

config_root_name = "config"

def backupisePath(path : Path) -> Path:
    return path.with_suffix("backup")

def treatRow(config_root : Path, row : dict[str, str]):
    src_str = row["Path"]
    logger.info(f"Treat csv entry: {src_str}")
    source = config_root.joinpath(src_str).absolute()
    
    target = row.get("Target", None)
    if (target is None or target == ""):
        target = Path(os.getenv("XDG_CONFIG_HOME")).joinpath(source.relative_to(config_root)).resolve()
        logger.debug(f"Target field is undefined, infering target to: {target}")
    else:
        target = Path(target).absolute()
        
    action = row["Action"]
    m = re.match("^L$", action)
    if (m): handleLink(source, target)
    m=  None
    
    m = re.match("^C(-(.+))?$", action)
    if (m): handleCopy(source, target, m.group(2))
    m = None
    
def handleLink(source : Path, target : Path):
    if target.is_symlink():
        if target.resolve().absolute() == source.absolute():
            logger.success("PASS")
            return
        logger.warning("Unlink existing symlink")
        target.unlink()

    if target.exists():
        logger.warning(f"Target file exists")
        bckp = backupisePath(target)
        logger.warning(f"Move existing to {bckp.name}")
        target.rename(bckp)
        
    target.symlink_to(source, target_is_directory=source.is_dir())
    logger.success("DONE")
        
def handleCopy(source : Path, target : Path, mode : str = "Soft") :
    logger.info(f"Copy with mode '{mode}'")
    if mode == "Hard":
        if target.is_symlink(): target.unlink()
        elif target.exists():
            bckp = backupisePath(target)
            logger.warning(f"{mode} mode enabled, moving to {bckp.name}")
            target.rename(bckp)

    if mode == "Soft" :
        if target.is_symlink() or target.exists():
            logger.success("PASS")
            return

    source.copy(target)
    logger.success("OK")
        
@click.command()
@click.argument("csv_file", type=click.Path(exists=True, file_okay=True,dir_okay=False, path_type=Path))
@click.option("-v", "--verbose", is_flag=True)
@click.option("-c", "--config_root", type=click.Path(exists=True, file_okay=False, dir_okay=True, path_type=Path), default=Path(__file__).parent.joinpath("config"))
def main(csv_file : Path, verbose : bool, config_root : Path):
    logger.info(f"Run import with csv file: {csv}")
    with csv_file.open() as file:
        reader = csv.DictReader(file)
        for row in reader :
            treatRow(config_root, row)

if __name__ == "__main__":
    main()