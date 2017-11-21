PACKAGES=${PACKAGES:-1}
CONFIG=${CONFIG:-1}

if [ "0" != "$PACKAGES" ]; then
    echo "Installing PACKAGES ..."
    sleep 2
    # Homebrew taps
    TAPS=(
	homebrew/science
	caskroom/cask
	caskroom/fonts
	caskroom/versions
    )

    # Main processing
    # Install command line tools
    echo "Installing command line tools ... "
    xcode-select --install
    echo "Done."

    echo "Configuring homebrew ..."
    # Check for Homebrew,
    # Install if we don't have it
    if ! hash brew ; then
	echo "Installing homebrew..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
	echo "brew already installed."
    fi
    echo "Updating homebrew ..."
    brew update -v
    echo "Done"
    for tap in ${TAPS[@]}; do
	echo "Tapping : $tap"
	brew tap $tap
    done
    #echo "to update setuptools & pip run: pip install --upgrade setuptools pip install --upgrade pip"
    echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
    echo "Done."

    echo "Installing brew packages ..."
    FNAME=BCK-brew_packages.txt
    while read line; do
	echo $line | awk '{print $1}' | xargs brew install ;
    done < $FNAME
    brew linkapps
    echo "Done."

    echo "Installing brew cask packages (this might take a lot of time) ..."
    FNAME=BCK-brewcask_packages.txt
    #brew install caskroom/cask/brew-cask
    while read line; do
	echo $line | awk '{print $1}' | xargs brew cask install --appdir=/Applications ;
    done < $FNAME
    echo "Done."

    ############## ANACONDA ###############
    if ! hash conda ; then
	PKG=https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
	cd ~/Downloads
	wget -c "${PKG}"
	bash "${PKG}" -b 
    fi
    echo "Installing conda packages with anaconda conda ..."
    PIPFILE=BCK-conda_packages.txt
    while read line; do
	echo $line | awk '{print $1}' | xargs ${HOME}/miniconda3/bin/conda install -y  ;
    done < $PIPFILE
    echo "Done."
    echo "Linking anaconda files ..."
    for fname in activate anaconda conda deactivate ipython ipython3 jupyter jupyter-notebook pip pip3 python python3; do
	ln -sf ${HOME}/miniconda3/bin/$fname ${HOME}/local/bin
    done
    echo "Installing pip packages with anaconda pip ..."
    PIPFILE=BCK-pip_packages.txt
    while read line; do
	echo $line | awk '{print $1}' | xargs ${HOME}/miniconda3/bin/pip install --upgrade ;
    done < $PIPFILE
    echo "Done anaconda and python stuff."


    echo "Installing gem packages ..."
    GEMFILE=BCK-gem_packages.txt
    while read line; do
	echo $line | awk '{print $1}' | xargs sudo gem update  ;
    done < $GEMFILE
    echo "Done."

    PERL_MODULES=(
	Capture::Tiny
	Clipboard
	Crypt::Rijndael
	File::KeePass
	Mac::Pasteboard
	Sort::Naturally
	Term::ReadLine::Gnu
	Term::ShellUI
    )
    echo "Installing cpan-perl modules ..."
    for MOD in ${PERL_MODULES[@]}; do
	sudo cpan ${MOD}
    done
    echo "DO NOT FORGET TO REINSTALL kpcli AND UPDATE THE ALIAS"
    echo "Done."

    echo "Install manually the following apps: iserial reader, Pasco Capstone, Pocket, beam, blackboard collaborate, pocket, popcorn time : https://popcorntime.sh/, privoxy, tracker, scidavis, utorrent, Serial Seeker "

    echo "DONE PACKAGES."
fi

########### configuration ############
if [ "0" != "$CONFIG" ]; then
    if [ -d "$HOME/dotfiles" ]; then
	echo "Cloning dotfiles repo ..."
	cd 
	git clone https://github.com/iluvatar1/dotfiles.git 
	echo "Done."
    fi
    
    echo "Using stow to link dot files ..."
    cd ~/dotfiles
    if ! hash stow ; then
	brew cask install stow
    fi
    stow common
    echo "Done."

    echo "Restoring applications configurations with mackup"
    echo "Dropbox must be functioning to have the mackup repo ready ..."
    mackup restore
    echo "Done."

    echo "TODO: DO NOT FORGET TO restore crontab from BCK-crontab.txt"
    echo "TODO: DO NOT FORGET TO COPY YOUR .gnupg CONFIG DIRECTORY FROM THE TRUSTED LOCATION"
    echo "TODO: DO NOT FORGET TO COPY YOUR .ssh CONFIG DIRECTORY FROM THE TRUSTED LOCATION"

    echo "TODO: Add, to logins items: Quicksilver, flux, Dash, Appcleaner, Spectacle, Emacs Daemon"
    echo "TODO: Configure sshguard and maybe fail2ban"
    echo "Running sshguard ..."
    sudo pfctl -f /etc/pf.conf
    sudo brew services restart sshguard

    echo "DONE CONFIG."
fi
