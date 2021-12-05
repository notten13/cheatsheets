#!/bin/bash
# Shebang

# Define variable
VARIABLE=1234

# Use $ to use a variable
echo $VARIABLE
# Double-quotes work
echo "The value of VARIABLE is: $VARIABLE"
# But single-quotes don't
echo 'The value of VARIABLE is $VARIABLE'

# String replacement
echo ${VARIABLE/12/99}

# String length
echo ${#VARIABLE}

# Substring: start at character 1, take 2 chars
echo ${VARIABLE:1:2}
# Take the last 3 characters
echo ${VARIABLE: -3}

# Arrays
array=(one two three four five six)
echo ${array[0]}
echo ${array[1]}
# Print all elements
echo ${array[@]}
# Print length
echo ${#array[@]}
# Print 2 elements from element 3
echo ${array[@]:3:2}

# Brace expansion
echo {1..10}
echo {a..z}

# Built-in variables
echo "I'm in $PWD"
echo "Last program's return value: $?"
echo "Script's PID: $$"
echo "Number of arguments passed to script: $#"
echo "All arguments passed to script: $@"
echo "Script's arguments separated into different variables: $1, $2, $3..."
echo "My user name is $USER"

# Reading from input
# echo "What's your name?"
# read Name # Note that we didn't need to declare a new variable
# echo Hello, $Name!

# if [ "$Name" = $USER ]
# then
#   echo "Your name is your username"
# else 
#   echo "Your name isn't your username"
# fi

# Redirections
echo "hello" > /dev/null 2> /dev/null
echo "hello" > /dev/null 2>&1
# Append
echo "hello" >> /dev/null

# Case
# echo "Enter country"
# read COUNTRY
# case "$COUNTRY" in
#   ("France") echo "You are French";;
#   ("UK") echo "You are British";;
#   (*) echo "You are from another country";;
# esac;

# For loops
for var in {1..10}
do
  echo $var
done

# Or write it the "traditional for loop" way:
for ((a=1; a <= 3; a++))
do
    echo $a
done

# Use commands
for file in $(ls)
do
  echo $file
done

# The `trap` command allows you to execute a command whenever your script
# receives a signal. Here, `trap` will execute `rm` if it receives any of the
# three listed signals.
TMP_FILE="test.tmp"
touch $TMP_FILE
trap "rm $TMP_FILE; exit" SIGINT
while [ true ]
do
  echo "Sleeping..."
  sleep 5
done