# Fibaro-Unifi - Check if devices is connected

This script taking advatadge of the API for Unifi Controller to perform a check for connected devices and to update presence status to Fibaro Home Center.
All checks will be performed before communication with Fibaro Home Center and only changes will be reported so it will create minimum load on the system.

## Installation

* **Create Predefined variables for each device you want to monitor with "home" and "away" as values 
 in Fibaro Variables panel.**

* **Setup the scrpit**
```
loginUnifi="\"XXXXX\"" 
#Login username to Unifi, replace XXXXX with your credentials

passUnifi="\"XXXXX\"" 
#Login password to Unifi, replace XXXXX with your credentials

urlUnifi="https://192.168.X.XXX:8443/" 
#IP to Unifi

loginFibaro="name%40email.com " 
#Fibaro admin username, FibaroID must beused, @ must be formatted as %40 in email username

passFibaro="XXXXX" 
#Login password to Fibaro, replace XXXXX with your credentials

urlFibaro="192.168.X.XXX" 
#IP to Fibaro Home Center

globalVarFibaro=("globalvariableX" "globalvariableY" "globalvariableZ")
#The names of your Predefined variable in created in Fibaro Home Center, 
separated with spaces

macClients=("XX:XX:XX:XX:XX:XX" "YY:YY:YY:YY:YY:YY" "ZZ:ZZ:ZZ:ZZ:ZZ:ZZ") 
#The mac adresses for the devices to monitor, same number of entities and 
same order as in globalVarFibaro above, separated with spaces.
```
* **Automation**
For automation, put this to be executed every X minute.
