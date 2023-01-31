#! /bin/bash

#testing ground:
#clear -x
#exit

clear -x
printf "Welcome to the cat game!\n\n"
echo "   |\---/|"
echo "   | ,_, |"
echo "    \_v_/-..----."
echo " ___/ '   ' ,''+ \  "
echo "(__...'   __\    |\.___.';"
echo "  (_,...'(_,.'__)/'.....+"
echo ""
read -s -p "Press enter to start the game."
clear -x

#initialize variables
GAME_RUNNING=true
GAME_START_TIME=$(date +%s)
USER_CHOICE=100
CURRENT_LOCATION=$USER_CHOICE
INVALID_SELECTION=false
SCRATCHES=0
PURR_REACTIONS=("The cat likes it. (^・ω・^ )" "it really likes it! (^･ｪ･^)" "it still really likes it (=^･ｪ･^=)" "it starts to purr (=ｘェｘ=)" "it lies down, exposing its big fluffy belly ヾ(=ﾟ･ﾟ=)ﾉ" "you scratch its belly, and it doesn't approve. It promptly scratches your hand! Ow. ଲ(ⓛωⓛ)ଲ" "you make sure to stay away from its belly this time. The cat likes it. You scratch its head. It likes it. [^._.^]ﾉ彡" "It reminds you of when you were small. All you wanted was a little cat, just like this one. You hope that this cat belongs to a child, just like you once were." "You really should be going now, to make your appointment")
#create log file if it doesn't exist
if [ -e "log.csv" ]
then
    :
else
    touch log.csv
    printf "start_unix_time,choice_unix_time,current_location,user_choice,n_scratches\n" > log.csv
fi

function make_your_choice() {
    #sleep 0.5
    printf " \n\nWhat do you do?\n$1\n"
    #save users current location in the game to allow for logging as below
    CURRENT_LOCATION=$USER_CHOICE
    CURRENT_TIME=$(date +%s)
    read -p "Selection: " USER_CHOICE
    #logging
    printf "$GAME_START_TIME,$CURRENT_TIME,$CURRENT_LOCATION,$USER_CHOICE,$SCRATCHES\n" >> log.csv
    clear -x
}

valid_choices () {
    #Tests to ensure the USER_CHOICE corresponds with a valid array position of ACCEPTED VALUES, handling errors if it doesn't.
    #TODO bug as scratches keep increasing if wrong choice is made in 110
ACCEPTED_VALUES=($1)

#magic to test whether the USER_CHOICE supports arithmetics.
INTEGER_TEST=`echo $((($USER_CHOICE*2)/2))`

if [ "$USER_CHOICE" == "$INTEGER_TEST" ]
    then
        if [[ $USER_CHOICE -gt ${#ACCEPTED_VALUES[@]} || $USER_CHOICE -le 0 ]]
            then
                read -s -p "You have entered an unknown command. Press Enter to go back."
                USER_CHOICE=$CURRENT_LOCATION
            else
                USER_CHOICE=${ACCEPTED_VALUES[USER_CHOICE-1]}
        fi
    else 
        if [ "$USER_CHOICE" == "quit" ]
            then
                :
            else
                read -s -p "You have entered an unknown command. Press Enter to go back."
                USER_CHOICE=$CURRENT_LOCATION
        fi
fi
clear -x
}

while $GAME_RUNNING
do 
    case "$USER_CHOICE" in
        100)
            printf "You're walking in a quiet street, it is light outside, and you are enjoying the weather. You need to hurry up, as you need to make your appointment."
            make_your_choice "1: walk in a relaxed pace\n2: hurry up."
            valid_choices "101 102"
            ;;
        101)
            printf "You walk in a relaxed pace."
            for (( i=1; i<$(( $RANDOM % 10 )) + 5; i++ ))
            do
                sleep 0.5
                printf "."
            done
            sleep 0.5
            make_your_choice "1: continue"
            valid_choices "103"
            ;;
        102)
            printf "You hurry up. Damn you're fast!"
            make_your_choice "1: continue"
            valid_choices "103"
            ;;
        103)
            printf "After a while, you see a cat on the road. It looks like a cute cat. (^._.^)ﾉ"
            make_your_choice "1: pet the cat\n2: walk near the cat\n3: hurry up!"
            valid_choices "110 120 900"
            ;;
        110)
            printf "You pet the cat. ${PURR_REACTIONS[SCRATCHES]}"
            ((SCRATCHES++))
            make_your_choice "1: Keep petting the cat\n2: Say goodbye to the kitty and walk on by."
            valid_choices "110 120"
            ;;
        120)
            if [ "$SCRATCHES" -eq "0" ]
                then
                    IS_ALREADY_PETTED="Go over and pet the cat"
                else
                    IS_ALREADY_PETTED="Go back and pet the cat some more"
            fi
            printf "You hear the cat meowing, but you really need to hurry up. But the cat just looks so cute!"
            make_your_choice "1: $IS_ALREADY_PETTED\n2: Say goodbye to the kitty and walk on by."
            valid_choices "110 130"
            if [ "$USER_CHOICE" -eq "130" ] && [ "$SCRATCHES" -eq "0" ]
            then
                USER_CHOICE=900
            elif [ "$USER_CHOICE" -eq "130" ] && [ "$SCRATCHES" -lt "5" ]
            then
                USER_CHOICE=910
            elif [ "$USER_CHOICE" -eq "130" ]
            then
                USER_CHOICE=920
            else
                :
            fi
            ;;
        900)
            printf "you hurry up, and make it on to the bus. You look out of the window, and see the cat. The cat is sad, and you feel bad."
            make_your_choice "1: Play again\n2: see your game score"
            valid_choices "100 990"
            ;;
        910)
            printf "you hurry up. You get on your bus, and think of the cat. You hope the cat is happy and appreciates your scritches. You wonder what would happen if you petted it some more."
            make_your_choice "1: Play again\n2: see your game score"
            valid_choices "100 990"
            ;;
        920)
            printf "you hurry up. You don't make the bus, and send a message letting your friend know you're gonna be late. He texts back that it's okay. The cat apparently followed you, and you play with him until your bus arrives."
            make_your_choice "1: Play again\n2: see your game score"
            valid_choices "100 990"
            ;;
        template)
            printf ""
            make_your_choice ""
            ;;
        990)
            clear -x
            printf "Here are your stats!\n\n"
            sleep 2
            printf "You played for $(($CURRENT_TIME - $GAME_START_TIME)) seconds! This gives you the title of:\n"
            if [ $(($CURRENT_TIME - $GAME_START_TIME)) -gt 30 ]
            then 
                echo "Meticulous thinker: You take time to consider the best choice, before making it!"
            else 
                echo "Fast executer: You optimize, getting from A to B as effectively as possible!"
            fi
            sleep 2
            printf "\nYou petted the cat $SCRATCHES times! This gives you the title of: \n"
            if [ $SCRATCHES -eq 0 ]
            then 
                echo "Cat hater: I'm sure you have other redeeming qualities."
            elif [ $SCRATCHES -le 5 ]
            then 
                echo "Cat cuddler: You appreciate giving cats reasonable amounts of scratches."
            elif [ $SCRATCHES -le 6 ]
            then 
                echo "Cat cuddler: You appreciate giving cats scratches, but remember to respect their boundaries."
            elif [ $SCRATCHES -lt 10 ]
            then 
                echo "Cat cuddle connoiseur: You know how to win back the trust of cats - even if they scratch!"
            else
                echo "Crazy cat person: We know cats are awesome, but chill out bro!"
            fi 
            sleep 2
            echo ""
            read -s -p "Press enter to quit the game."
            clear -x
            GAME_RUNNING=false
            ;;
        *)
            printf "you chose $USER_CHOICE, which should not be possible! Please send me a message/create github issue with what your choice was, and include info from log.csv <3" 
            read -s -p "Press Enter to go back."
            USER_CHOICE=$CURRENT_LOCATION
            ;;
    esac
done

echo "  ,-.       _,---._ __  / \ "
echo " /  )    .-'       './ /   \ "
echo "(  (   ,'            '/    /|"
echo " \  '-'             \'\   / |"
echo "  '.              ,  \ \ /  |"
echo "   /'.          ,'-'----Y   |"
echo "  (   *        ;  Bye!  |   '"
echo "  |  ,-.    ,-' Thank u |  /"
echo "  |  | (   | 4 playing! | /"
echo "  )  |  \  '.___________|/"
echo "  '--'   '--'"

exit
