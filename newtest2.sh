#!/bin/bash

# get size of the terminal
cols=$(tput cols)
rows=$(tput lines)

# Initialize empty array
declare -A arr

# calculate the maximum radius and center
r=$(( ( rows < cols ? rows : cols ) / 2 ))
x_center=$((cols / 2))
y_center=$((rows / 2))

# adjust ratio
ratio=2

# sin function using bc
sin() {
  local val=$(echo "scale=10;s($1*3.14159/180)" | bc -l)
  printf "%.0f" "$(echo "$val * 1000" | bc -l)"
}

# cos function using bc
cos() {
  local val=$(echo "scale=10;c($1*3.14159/180)" | bc -l)
  printf "%.0f" "$(echo "$val * 1000" | bc -l)"
}

# draw spiral
for ((theta=0; theta < 720; ++theta)); do
  # calculate polar coordinates
  r=$((theta / 10))
  x=$((x_center + (ratio*r*$(cos $theta)) / 1000))
  y=$((y_center + r*$(sin $theta) / 1000))

  # check if the position is valid
  if (( x >= 0 && x < cols && y >= 0 && y < rows )); then
      arr[$x,$y]='*'
  fi
done

# print spiral
for ((i=0;i<rows;++i)); do
  for ((j=0;j<cols;++j)); do
    if [[ -n "${arr[$j,$i]}" ]]; then
        printf "*"
    else
        printf " "
    fi
  done
  echo
done

