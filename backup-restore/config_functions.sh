source util_functions.sh

function clone_dotfiles () {
    OLDPWD=$(pwd -P)
    if [ ! -d "$HOME/dotfiles" ]; then
	echo "Cloning dotfiles repo ..."
	cd 
	git clone https://github.com/iluvatar1/dotfiles.git 
	echo "Done."
    else
	cd $HOME/dotfiles
	git pull
    fi
    cd $OLDPWD
}

function link_dotfiles () {
    blue_color
    echo "Linking dotfiles ..."
    reset_color
    OLDPWD=$(pwd -P)
    clone_dotfiles
    echo "Using stow to link dot files ..."
    cd ~/dotfiles
    if ! hash stow ; then
	color_red
	echo "Cannot use stow to link dotfiles"
    else
	stow common
	echo "Done."    
    fi
    cd "$OLDPWD"
}

# TODO: configure tmux plugins
