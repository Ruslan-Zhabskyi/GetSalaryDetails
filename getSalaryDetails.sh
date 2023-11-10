#!/bin/bash
# AUTHOR: RUSLAN ZHABSKYI
# DESCRIPTION: This script returns the name of the employee and their associated salary

echo Hello, $USER!
echo -e "\vYou can request an employee's salary details by entering their name."
echo -e "\t\vYou can stop this program from running at any time by passing Q"
echo
sleep 1

exitAnswer="Y"

# While loop in case the user would want to check more employees
while [ $exitAnswer == "Y" ] || [ $exitAnswer == "y" ] || [ $exitAnswer == "YES" ] || [ $exitAnswer == "yes" ] || [ $exitAnswer == "Yes" ]; do

    echo "Would you like to see the list of employees first? (Y/N)"
    read answer

    # Check if the user wants to exit
    if [ $answer == "Q" ] || [ $answer == "q" ]; then
        break
    fi

    # While loop to check if the user entered a correct option
    while [ $answer != "Y" ] && [ $answer != "y" ] && [ $answer != "YES" ] && [ $answer != "yes" ] && [ $answer != "N" ] && [ $answer != "n" ] && [ $answer != "NO" ] && [ $answer != "no" ]; do
        echo "Please type Yes or No"
        read answer
    done

    # Check if the user wants to exit
    if [ $answer == "Q" ] || [ $answer == "q" ]; then
        break
    fi

    employeeName=""


    # Based on the user answer: provide a list of employees or ask to enter an employee name
    case $answer in
        [yY] | [yY][Ee][Ss] )
            echo -e "\vPlease see the employee list below:"
            sort -k2 ./employee.txt | awk 'BEGIN {printf "%-10s %-20s %-10s\n", "ID", "Name", "Dept" }
                 {printf "%-10s %-20s %-10s\n", "______", "______", "______"}
                 {printf "%-10s %-20s %-10s\n", $1, $2, $3}'
            ;;
        [nN] | [nN][Oo] )
            echo "Please enter employee name:"
            read employeeName
            ;;
        *)
            echo "Invalid input. Please type Yes or No"
            ;;
    esac

    # Check if the user wants to exit
    if [ "$employeeName" == "Q" ] || [ "$employeeName" == "q" ]; then
        break
    fi

    # Check if the user already entered a name in the previous step
    if [ -z  $employeeName ]; then
        echo -e "\vPlease enter an employee name:"
        read employeeName
    fi

     # Check if the user wants to exit
    if [ "$employeeName" == "Q" ] || [ "$employeeName" == "q" ]; then
        break
    fi

    # Check if the user entered a name and it exists. Then print the details.
    found=$(awk '{print $2}' ./employee.txt | grep -i $employeeName)
    if [ $? -eq 0 ]; then
        echo -e "\vThanks, please see requested details below:"
        sleep 1
        echo
        grep -i $employeeName ./employee.txt | awk '{print "    The wages recorded for " $2 ", whose employee ID is " $1 ", are: " $5}'
    else
      echo "Name not found. Please try again"
    fi
    sleep 1
    echo -e "\vWould you like to enter another name? (Y/N)"
    read exitAnswer

    # Check if the user wants to exit
    if [ $exitAnswer == "Q" ] || [ $exitAnswer == "q" ]; then
        break
    fi
done

echo -e "\vThank you. Bye"
