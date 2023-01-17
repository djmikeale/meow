#! /bin/bash


clear -x
printf "Welcome to the cat game!\n\n"
echo "   |\---/|"
echo "   | ,_, |"
echo "    \_v_/-..----."
echo " ___/ '   ' ,''+ \  "
echo "(__...'   __\    |\.___.';"
echo "  (_,...'(_,.'__)/'.....+"
echo " "
read -s -p "Press enter to start the game."
clear -x

#initialize variables
GAME_RUNNING=true
USER_CHOICE=100
INVALID_SELECTION=false
SCRATCHES=0
PURR_REACTION="It likes it"

function make_your_choice() {
    #sleep 0.5
    printf " \n\nWhat do you do?\n$1\n"
    read -p "Selection: " USER_CHOICE
    #do some choice checking here to ensure the inputs match expected ones. 
    clear -x
}

while $GAME_RUNNING
do 

case "$USER_CHOICE" in
    100)
        printf "You're walking in a quiet street, it is light outside, and you are enjoying the weather. You need to hurry up, as you need to make your appointment."
        make_your_choice "101: hurry up\n102: walk in a relaxed pace."
        if [ "$USER_CHOICE" == "101" ]
            then
                ANSWER="hurry up"
            else
                ANSWER="walk in a relaxed pace"
        fi
        USER_CHOICE=101 #illusion of choice muahaha.
        ;;
    101)
        printf "You $ANSWER. After a while, you see a cat on the road. It looks like a cute cat."
        make_your_choice "110: pet the cat\n120: walk near the cat\n999: hurry up!"
        ;;
    110)
        printf "You pet the cat. $PURR_REACTION!"
        make_your_choice "110: Keep petting the cat\n120: Say goodbye to the kitty and walk on by."
        if [ "$USER_CHOICE" -eq "110" ]
            then
                ((SCRATCHES++))
                case $SCRATCHES in
                    1)
                        PURR_REACTION="it really likes it"
                        ;;
                    2) 
                        PURR_REACTION="it still really likes it" 
                        ;;
                    3) 
                        PURR_REACTION="it starts to purr" 
                        ;;
                    4) 
                        PURR_REACTION="it lies down, exposing its big fluffy belly" 
                        ;;
                    5) 
                        PURR_REACTION="you scratch its belly, and it doesn't approve. It promptly scratches your hand! Ow" 
                        ;;
                    6) 
                        PURR_REACTION="you make sure to stay away from its belly this time. The cat likes it. You scratch its head. It likes it." 
                        ;;
                    7) 
                        PURR_REACTION="It reminds you of when you were small. All you wanted was a little cat, just like this one. You hope that this cat belongs to a child, just like you once were." 
                        ;;
                    *)
                        PURR_REACTION="You really should be going now, to make your appointment" 
                        ;;
                esac
            else 
                :
        fi
        ;;
    120)
        if [ "$SCRATCHES" -eq "0" ]
            then
                IS_ALREADY_PETTED="Go over and pet the cat"
            else
                IS_ALREADY_PETTED="Go back and pet the cat some more"
        fi
        printf "You hear the cat meowing, but you really need to hurry up. But the cat just looks so cute!"
        make_your_choice "110: $IS_ALREADY_PETTED\n130: Say goodbye to the kitty and walk on by."
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
        make_your_choice "101: Play again\nquit: quit game"
        ;;
    910)
        printf "you hurry up. You get on your bus, and think of the cat. You hope the cat is happy and appreciates your scritches. You wonder what would happen if you petted it some more."
        make_your_choice "101: Play again\nquit: quit game"
        ;;
    920)
        printf "you hurry up. You don't make the bus, and send a message letting your friend know you're gonna be late. He texts back that it's okay. The cat apparently followed you, and you play with him until your bus arrives."
        make_your_choice "101: Play again\nquit: quit game"
        ;;
    template)
        printf ""
        make_your_choice ""
        ;;
    quit)
        GAME_RUNNING=false
        ;;
    *)
        printf "you chose $USER_CHOICE, which is not a valid number." 
        read -p "Please write a correct selection, or write quit to quit the game: " USER_CHOICE
        ;;
esac

printf "\n"

     
done
echo "thank you for playing!"
