#! /bin/bash

clear -x
printf "Welcome to the cat game!\n\n"
echo "   |\---/|"
echo "   | ,_, |"
echo "    \_v_/-..----."
echo " ___/ '   ' ,''+ \  sk"
echo "(__...'   __\    |\.___.';"
echo "  (_,...'(_,.'__)/'.....+"
echo " "
read -s -p "Press enter to start the game."
clear -x

#initialize variables
GAME_RUNNING=true
PARAGRAPH_NUMBER=100
INVALID_SELECTION=false
SCRATCHES=0
PURR_REACTION="It likes it"

function make_your_choice() {
    #sleep 0.5
    printf " \n\nWhat do you do?\n$1\n"
    read -p "Selection: " PARAGRAPH_NUMBER
    #do some choice checking here to ensure the inputs match expected ones. 
    clear -x
}

while $GAME_RUNNING
do 

case "$PARAGRAPH_NUMBER" in
    100)
        printf "You're walking in a quiet street, it is light outside, and you are enjoying the weather. You need to hurry up, as you need to make your appointment."
        make_your_choice "101: hurry up\n102: walk in a relaxed pace."
        if [ "$PARAGRAPH_NUMBER" == "101" ]
            then
                ANSWER="hurry up"
            else
                ANSWER="walk in a relaxed pace"
        fi
        PARAGRAPH_NUMBER=101 #illusion of choice muahaha.
        ;;
    101)
        printf "You $ANSWER. After a while, you see a cat on the road. It's a cute cat. You walk closer to the cat."
        make_your_choice "110: pet the cat\n120: walk near the cat\n999: hurry up!"
        ;;
    110)
        printf "You pet the cat. $PURR_REACTION!"
        make_your_choice "110: Keep petting the cat\n120: Say goodbye to the kitty and walk on by."
        if [ "$PARAGRAPH_NUMBER" -eq "110" ]
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
                echo "$SCRATCHES"
        fi
        ;;
    template)
        printf ""
        make_your_choice ""
        ;;
    
    quit)
        GAME_RUNNING=false
        ;;
    *)
        printf "you chose $PARAGRAPH_NUMBER, which is not a valid number." 
        read -p "Please write a correct selection, or write quit to quit the game: " PARAGRAPH_NUMBER
        ;;
esac

printf "\n"

     
done
echo "thank you for playing!"
