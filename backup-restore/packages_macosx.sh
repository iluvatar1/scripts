source packages_functions_macosx.sh

blue_color
echo "Installing PACKAGES ..."
sleep 2
reset_color

# Main processing
xcode_command_line_tools
homebrew
anaconda_python
# Extra packages
red_color
echo "Install manually the following apps: iserial reader, Pasco Capstone, Pocket, beam, blackboard collaborate, popcorn time : https://popcorntime.sh/, tracker, scidavis, utorrent, Serial Seeker "
reset_color

homebrew_extra_pkgs &
homebrew_cask_extra_pkgs &
gem_pkgs
perl_pkgs

echo "DONE PACKAGES."
separator

