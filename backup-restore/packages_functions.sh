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

    CONDA_ESSENTIAL=(
	ipython
	jupyter
	jupyter-notebook
	matplotlib
	scipy
	numpy
	pip
	)
    echo "Installing essential conda packages with anaconda conda from ..."
    for pkg in ${CONDA_ESSENTIAL[@]}; do 
	${HOME}/miniconda3/bin/conda install -y ${pkg} 
    done
    echo "Done."

    echo "Linking anaconda files to $HOME/local ..."
    if [ ! -d "$HOME/local" ]; then
	mkdir $HOME/local
    fi
    for fname in activate anaconda conda deactivate ipython ipython3 jupyter jupyter-notebook pip pip3 python python3; do
	ln -sf ${HOME}/miniconda3/bin/$fname ${HOME}/local/bin
    done
    echo "Done anaconda and python stuff."
    separator
}

function anaconda_python_extra() {
    CONDAFILE=BCK-conda_packages.txt
    echo "Installing conda packages with anaconda conda from $CONDAFILE ..."
    rm -f conda-extra.txt
    while read line; do
	echo $line | awk '{print $1}' | xargs ${HOME}/miniconda3/bin/conda install -y  >> conda-extra.txt ;
    done < $CONDAFILE
    echo "Done."
 
    PIPFILE=BCK-pip_packages.txt
    rm -f pip-extra.txt
    echo "Installing pip packages with anaconda pip from $PIPFILE ..."
    while read line; do
	echo $line | awk '{print $1}' | xargs ${HOME}/miniconda3/bin/pip install --upgrade >> pip-extra.txt ;
    done < $PIPFILE
    echo "Done."
    separator
}
