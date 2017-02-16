loginUnifi="\"XXXXX\"" #Login username to Unifi, replace XXXXX
passUnifi="\"XXXXX\"" #Login password to Unifi, replace XXXXX
urlUnifi="https://192.168.X.XXX:8443/" #IP to Unifi
loginFibaro="name%40email.com" #Fibaro admin username, FibaroID must be used, @ must be formatted as %40 in email username
passFibaro="XXXXX" #Login password to Fibaro, replace XXXXX
urlFibaro="192.168.X.XXX" #IP to Fibaro Home Center
globalVarFibaro=("globalvariable1" "globalvariable2" "globalvariable3") #The names of your Global Variable in Fibaro separated with spaces
macClients=("XX:XX:XX:XX:XX:XX" "YY:YY:YY:YY:YY:YY" "ZZ:ZZ:ZZ:ZZ:ZZ:ZZ") #The mac adresses for the devices to monitor, same number of entities and same order as in globalVarFibaro above

###Do not edit below this line###
homeTest="\"value\":\"home\""
awayTest="\"value\":\"away\""
apiFibaro="/api/globalVariables"
apiUrlFibaro=http://$loginFibaro:$passFibaro@$urlFibaro$apiFibaro/

curl "{$urlUnifi}api/login" --data-binary '{"username":'$loginUnifi',"password":'$passUnifi',"strict":true}' --compressed --insecure -c cookies.txt;
connectedClients=$(curl --insecure -b cookies.txt -c cookies.txt "{$urlUnifi}api/s/default/stat/sta")

for ((i=0; i<${#globalVarFibaro[*]}; i++)); do 
		if [[ $connectedClients =~ ${macClients[$i]} ]]; 
			then
					historyData=$(<outputdata$i.txt)
					
				if [[ $historyData =~ $homeTest ]];
					then
						echo "${globalVarFibaro[$i]} already home"
					else
						tempData=$(curl -v -s -X PUT -d '{"value": "home", "invokeScenes":true}' "$apiUrlFibaro"${globalVarFibaro[$i]})
						echo "\"${globalVarFibaro[$i]}\":$tempData"> outputdata$i.txt;
				fi
			else
					historyData=$(</mnt/c/Bash/outputdata$i.txt)
				if [[ $historyData =~ $awayTest ]];
					then
						echo "${globalVarFibaro[$i]} already away"
					else
						tempData=$(curl -v -s -X PUT -d '{"value": "away", "invokeScenes":true}' "$apiUrlFibaro"${globalVarFibaro[$i]})
						echo "\"${globalVarFibaro[$i]}\":$tempData"> outputdata$i.txt;
				fi
		fi
done
