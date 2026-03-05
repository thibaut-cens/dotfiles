# Determine the location of the shims directory
if ($null -eq $ASDF_DATA_DIR -or $ASDF_DATA_DIR -eq '') {
  $_asdf_shims = "${env:HOME}/.asdf/shims"
}
else {
  $_asdf_shims = "$ASDF_DATA_DIR/shims"
}

# Then add it to path
$env:PATH = "${_asdf_shims}:${env:PATH}"
