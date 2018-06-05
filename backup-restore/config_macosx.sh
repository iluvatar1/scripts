source config_functions_macosx.sh

macosx_defaults
link_dotfiles
restore_mackup
restore_crontab BCK-crontab.txt
setup_login_items
setup_sshguard

red_color
echo "TODO: DO NOT FORGET TO COPY YOUR .gnupg CONFIG DIRECTORY FROM THE TRUSTED LOCATION"
echo "TODO: DO NOT FORGET TO COPY YOUR .ssh CONFIG DIRECTORY FROM THE TRUSTED LOCATION"
reset_color

