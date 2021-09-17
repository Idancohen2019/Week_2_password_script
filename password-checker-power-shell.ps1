#date 15/09/2021
#author "Idan Cohen"
#purpose "sela devops course"
# password checker with Power Shell
# call with ./bash-password <option> <password>


# $second_arg=$args[1]

#password from the user 
[string]$password = $args[0]

function password_check {
    Clear-Host #clear-host remove text from current display, same as "clear" in Bash

    #Returns to the user that the number of letters is less than 10
    if ($password.length -le 9) {
        write-host -ForegroundColor red "Error - You need to enter 10 cherchters to your password."
    }
    else {
        Write-Host -ForegroundColor Green "Your password passed the length test. "
    }
    #password input testing
    if ((($password -cmatch '[a-z]') -and ($password -cmatch '[A-Z]') -and ($password -match '\d'))) {

        Write-Host -ForegroundColor Green "Great password, well done. "
    }
    elseif (!(($password -cmatch '[a-z]') -and ($password -cmatch '[A-Z]') -and ($password -match '\d'))) {
        write-host -ForegroundColor red "Error: Password need to contain at least 1 upper-case, lower-case, and digits "
    }
}
password_check