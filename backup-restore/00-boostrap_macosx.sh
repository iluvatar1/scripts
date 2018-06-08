# This script recreates a given config and packages onto a macosx system
source util_functions.sh 

# install packages
blue_color
echo "Installing base essential packages with homebrew "
reset_color
bash ./packages_macosx.sh
separator

# Configure system
blue_color
echo "Configuring the system ... "
reset_color
bash ./config_macosx.sh
separator

blue_color
echo "Done."
echo "If you wish, install extra packages running the script packages_macosx-extra.sh "
reset_color
separator
