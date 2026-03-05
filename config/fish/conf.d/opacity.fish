function opaque_run
    # Set background opacity to 1 (100%)
    # Note: Requires 'allow_remote_control yes' in kitty.conf
    kitty @ set-background-opacity 1.0

    # Run the command passed as arguments
    $argv

    # Reset opacity to your kitty.conf default after the app closes
    kitty @ set-background-opacity default
end

# abbr -a hyprdynamicmonitors 'opaque_run hyprdynamicmonitors'
