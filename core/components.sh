COLS="$(tput cols)"
LINE1=""

for ((i = 0; i < $COLS; i++)); do
    LINE1+="-"
done
