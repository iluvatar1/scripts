# Speciific functions only for osx

source util_functions.sh 
source packages_functions.sh

function xcode_command_line_tools() {
    # Install command line tools
    if ! [ $(xcode-select -p) ]; then
	blue_color
	echo "Installing command line tools ... "
        xcode-select --install
	echo "Done."
    fi
    reset_color
    separator
}

function homebrew_setup_services () {
    for a in /usr/local/opt/*/*.plist; do
	ln -sfv $a  ~/Library/LaunchAgents/
	launchctl load ~/Library/LaunchAgents/$(basename $a)
    done
}

function homebrew() {
    blue_color
    echo "Installing and configuring homebrew"
    reset_color
    HOMEBREW_PREFIX="/usr/local"
    if [ -d "$HOMEBREW_PREFIX" ]; then
	if ! [ -r "$HOMEBREW_PREFIX" ]; then
	    sudo chown -R "$LOGNAME:admin" /usr/local
	fi
    else
	sudo mkdir "$HOMEBREW_PREFIX"
	sudo chflags norestricted "$HOMEBREW_PREFIX"
	sudo chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
    fi
    
    # Homebrew taps
    TAPS=(
	homebrew/science
	homebrew/services
	caskroom/cask
	caskroom/fonts
	caskroom/versions
    )
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
    blue_color
    echo "Don’t forget to add $(brew --prefix coreutils)/libexec/gnubin to \$PATH."
    reset_color
    echo "Done."

    echo "Installing git"
    brew install git
    brew doctor

    BREW_ESSENTIAL_PKGS=(
	emacs
	git
	fail2ban
	mackup
	make
	ntfs-3g
	parallel
	stow
	tmux
	bash-completion
	ssh-copy-id
    )
    echo "Installing essential brew packages ..."
    for pkgname in ${BREW_ESSENTIAL_PKGS[@]}; do
	brew install $pkgname ;
    done
    brew linkapps
    homebrew_setup_services
    
    BREW_CASK_ESSENTIAL_PKGS=(
	authoxy
	dropbox
	flux
	iterm2
	firefox
	google-chrome
	keepassxc
	latexit
	quicksilver
	spectacle
	vlc
	xquartz
    )
    echo "Installing essential brew cask packages ..."
    for pkgname in ${BREW_CASK_ESSENTIAL_PKGS[@]}; do
	brew cask install --appdir=/Applications  $pkgname ;
    done
    
    reset_color
    separator
}

function homebrew_extra_pkgs () {
    FNAME=BCK-brew_packages.txt
    blue_color
    echo "Installing (in the background) homebrew EXTRA packages from $FNAME (this might take a lot of time) ..."
    reset_color
    rm -f homebre_status.txt
    while read line; do
	echo $line | awk '{print $1}' | xargs brew install >> homebrew_status.txt;
    done < $FNAME
    brew linkapps
    homebrew_setup_services
    echo "Done brew packages."
    separator
}

function homebrew_cask_extra_pkgs () {
    FNAME=BCK-brewcask_packages.txt
    rm -f homebrecask_status.txt
    blue_color
    echo "Installing  (in the background) brew cask EXTRA packages from $FNAME (this might take a lot of time) ..."
    reset_color
    #brew install caskroom/cask/brew-cask
    while read line; do
	echo $line | awk '{print $1}' | xargs brew cask install --appdir=/Applications >> homebrewcask_status.txt;
    done < $FNAME
    echo "Done brew cask packages."
    separator
}

function gem_pkgs {
    echo "Installing gem packages ..."
    GEMFILE=BCK-gem_packages.txt
    while read line; do
	echo $line | awk '{print $1}' | xargs sudo gem update  ;
    done < $GEMFILE
    echo "Done."
    separator
}

function perl_pkgs () {
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
    separator
}
