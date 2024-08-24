#!/bin/bash

#System Information Menu 

#Create a menu wuth 7 options 
#loop menu until a choice has been made. 
#IP Address: Prints private and public IP addressss
#Current User: Prints current user on the computer
#Memory Info: Prints out memory size and size type and displays total memory used and unused
#top 5 memory processes: prints out all the top 5 memory processes  (pmem, pid, cmd)
#top 5 cup processes: Same as above
#Network connectivity: receieve user input and checks something about the network 

#Created a while loop to keep showing user the menu until a choice is made
 
while true;
do 

#Used echo  -e  to create menu. -e allows for the new line effect to take place with out using echo for every line
	echo -e "System Information: \n 
	     1.IP Address 
	     2.Current User 
             3.CPU Information
             4.Memory Information
	     5.Top Memory Processes  
   	     6.Top CPU Processes 
             7.Network Connectivity
	     8.Exit"  
	#Read menuChoice takes user input
	read menuChoice
	case $menuChoice in 
	   1) echo "Public IP: $(wget -qO- ifconfig.me)  Private IP: $(hostname -I)";;
	   2) echo "$(whoami)";;
 	   3) echo "This computer has $(getconf _NPROCESSORS_ONLN) CPU";;
	   4) echo "Unused Memory: $(cat /proc/meminfo | grep 'MemFree'| awk '{print $2, $3}') "
	      echo "Available Memory: $(cat /proc/meminfo | grep 'MemAvailable' | awk '{print $2, $3}') ";;
	   5) echo "$(ps aux --sort -%mem | head -5)";;
	   6) echo "$(ps aux --sort -%cpu | head -5)";;
	   7) echo "Please enter a web address or IP address"
	      read userInput 
              packetLoss=$(ping -c 3 -q "$userInput" | grep "packet loss" | awk '{print $6}')
	      connectionSpeed=$(ping -c 3 -q "$userInput" | grep "time" | awk '{print $10}')
	      echo "$userInput has $packetLoss data packet loss and connected in $connectionSpeed";;
	   8) echo "GoodBye ✌"; break;;
	   *) echo "Invalid option. Please choose 1-8";;
	esac
done
