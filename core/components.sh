# File: core/components.sh
# Author: Tiago Lucas Flach
COLS="$(tput cols 2>/dev/null || echo 80)"
LINE1=""

for ((i = 0; i < $COLS; i++)); do
    LINE1+="-"
done
