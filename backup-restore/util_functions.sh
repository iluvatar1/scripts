# This is a helper file that defines many functions to be used
# in other scripts

# from : https://github.com/ghaiklor/iterm-fish-fisherman-osx/blob/master/install.sh
RESET_COLOR="\033[0m"
RED_COLOR="\033[0;31m"
GREEN_COLOR="\033[0;32m"
BLUE_COLOR="\033[0;34m"
function reset_color() {
    echo -e "${RESET_COLOR}\c"
}
function red_color() {
    echo -e "${RED_COLOR}\c"
}
function green_color() {
    echo -e "${GREEN_COLOR}\c"
}
function blue_color() {
    echo -e "${BLUE_COLOR}\c"
}
function separator() {
    green_color
    echo "#=============================STEP FINISHED=============================#"
    reset_color
}




