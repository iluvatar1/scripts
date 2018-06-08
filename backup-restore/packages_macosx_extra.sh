source packages_functions_macosx.sh

blue_color
echo "Installing EXTRA PACKAGES ... this might take a lot of time ... "
sleep 2
reset_color

# Main processing
anaconda_python_extra &
homebrew_extra_pkgs &
homebrew_cask_extra_pkgs &
gem_pkgs
perl_pkgs

echo "DONE EXTRA PACKAGES."
separator

