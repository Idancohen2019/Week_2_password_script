#!/bin/bash
#date 07/09/2021
#author "Idan Cohen"
#purpose "sela devops course"
# password checker
# call with ./bash-password <option> <password>

declare WARNING='\033[1;94m\e[31m';
declare SUCCESS='\033[1;94m\e[32m';
declare CLEAR='\e[0m';

#MAIN GETTING THE OPTION
function main(){
  check $@

  if [ $m ]
  then
    echo "'m' has been chosen."
  fi

}


#CHECKING THE USER OPTION
function check(){ 
  local OPTION opt i
  while getopts ':fa:' opt; do
    case "${opt}" in
      a) pass ;;
      f) readfromfile $@  ;;
      \?) echo "This is not an option, please select -a or -f option" ;;
    esac
  done
  # shift $(($OPTION -1))

  if [ "$OPTARG" = "" ];
    then
        pass $@ #getting and call the argument to the function.
  fi
}



function readfromfile(){
#checking if there is any input from the user after the -f option
  if [ "$2" = "" ];
    then
        echo -e $WARNING"\n Error: please add the password file after the -f option\a"$CLEAR
  elif [[ $2 != *.txt ]];then
    echo -e $WARNING"\n Error: this is not a text file path, please try again\a"$CLEAR
  elif [[ $2 == *.txt ]];then
      #FILE CONDITIONS
      FILE=$2
      if [ -s $FILE ];then
          echo "there is input in $FILE"
          OPTARG="$(cat $2)"
          pass $OPTARG
      else
          echo "there is no input in $FILE"
            exit 1;
      fi
  fi

}



#PASSWORD CHECKER
function pass(){

  PASS_USER=$OPTARG
  echo $PASS_USER
  #GETTING PASSWORD INPUT FROM THE USER
  # PASS_USER=$1
  declare WARNING='\033[1;94m\e[31m';
  declare SUCCESS='\033[1;94m\e[32m';
  declare CLEAR='\e[0m';
  excode=0 #exit number

  #ANTHER OPTION FOR USER INPUT
  # clear;read -s -p"Password: " PASS_USER;clear;echo "You enter $PASS_USER"

  #FILE CONDITIONS
  # FILE="test.txt"
  # if [ -e $FILE ];then
  #     echo "$FILE is a file"
  # else
  #     echo "$FILE is not a file"
  # fi

  if [ "$OPTARG" = "" ];
    then
      PASS_USER=$1;
  fi

  #CHECKING PASSWORD LENGTH
  if [ ${#PASS_USER} -lt 10 ]; then
          echo -e $WARNING"\n Error: $PASS_USER you need to enter 10 cherchters at your password.\a"$CLEAR
              (( excode++ ))
                  exit $excode #1
  else
      echo -e $SUCCESS"\n The password is in the correct length"$CLEAR
  fi


  #CHECKING PASSWORD INPUT AND EXIT CODE.
  echo $PASS_USER | grep "[a-z]" | grep "[A-Z]" | grep "[0-9]"
  if [[ $? -ne 0 ]];then
      echo -e $WARNING"\n Error: Password need to contain at least 1 upper-case, lower-case, and digits.\a"$CLEAR
          (( excode++ ))
              exit $excode #1
  fi

  #SENDING THAT THE CHECK WAS PASS AND CLEAR THE TEXT COLOR
  echo -e $SUCCESS"\n The password passed the test."$CLEAR
  exit $excode; #0



}

main $@