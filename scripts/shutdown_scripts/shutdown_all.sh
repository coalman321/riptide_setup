ssh ros@jetson '~/osu-uwrt/riptide_setup/scripts/shutdown_scripts/shutdown_on_jetson.sh'
ssh ros@baycat "sudo shutdown -h now"
ssh ros@venus "sudo shutdown -h now"
