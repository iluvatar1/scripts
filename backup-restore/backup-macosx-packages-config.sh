echo "Creating list of brew packages ..."
brew leaves > BCK-brew_packages.txt
echo "Done."

echo "Creating list of brew cask packages ..."
brew cask list > BCK-brewcask_packages.txt
echo "Done."

# echo "Backing up general configurations with mackup ..."
# mackup backup
# echo "Done."
echo "It is assumed that you have backed up the dotfiles repo ..."

echo "Creating list of conda packages ..."
conda list | awk '{print $1}' > BCK-conda_packages.txt
echo "Done."

echo "Creating list of pip packages ..."
pip list > BCK-pip_packages.txt
echo "Done."

echo "Creating list of gem packages ..."
gem list > BCK-gem_packages.txt
echo "Done."

echo "Backing up crontab config ..."
crontab -l > BCK-crontab.txt
echo "Done."

echo "DO NOT FORGET TO EDIT AND RUN THE backup_directories.sh script."
echo "DO NOT FORGET TO CHECK THE CPAN MODULES FROM instmodsh AND THE RESTORE SCRIPT"
echo "DO NOT FORGET TO COPY YOUR ~/Library/Application Support/Plex Media Server/"
