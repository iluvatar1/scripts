source util_functions.sh

# Utilities
function anaconda_python() {
    blue_color
    echo "Installing miniconda and setting up python trhough anaconda and pip ..."
    reset_color
    ############## ANACONDA ###############
    if ! hash conda ; then
	PKG=https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
	cd ~/Downloads
	wget -c "${PKG}"
	bash "${PKG}" -b 
    fi
    CONDAFILE=BCK-conda_packages.txt
    echo "Installing conda packages with anaconda conda from $CONDAFILE ..."
    while read line; do
	echo $line | awk '{print $1}' | xargs ${HOME}/miniconda3/bin/conda install -y  ;
    done < $CONDAFILE
    echo "Done."
    echo "Linking anaconda files to $HOME/local ..."
    if [ ! -d "$HOME/local" ]; then
	mkdir $HOME/local
    fi
    for fname in activate anaconda conda deactivate ipython ipython3 jupyter jupyter-notebook pip pip3 python python3; do
	ln -sf ${HOME}/miniconda3/bin/$fname ${HOME}/local/bin
    done
    PIPFILE=BCK-pip_packages.txt
    echo "Installing pip packages with anaconda pip from $PIPFILE ..."
    while read line; do
	echo $line | awk '{print $1}' | xargs ${HOME}/miniconda3/bin/pip install --upgrade ;
    done < $PIPFILE
    echo "Done anaconda and python stuff."
    separator
}
