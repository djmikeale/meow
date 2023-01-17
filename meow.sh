#! /bin/bash

printf "welcome to the cat game!\n"
read -s -p "Press enter to continue"

GAME_RUNNING=true
PARAGRAPH_NUMBER=100
while $GAME_RUNNING
do 

case "$PARAGRAPH_NUMBER" in
    100)
        printf "you're walking in a quiet street, it is light outside, and you are enjoying the weather. You need to hurry up, as you need to make your appointment.\n\nWhat do you do?\n101: hurry up\n102: walk in a relaxed pace."
        printf "\n"
        read -p "selection: " PARAGRAPH_NUMBER
        if [ "$PARAGRAPH_NUMBER" == "101" ]
            then
                ANSWER="hurry up"
            else
                ANSWER="walk in a relaxed pace"
        fi
        PARAGRAPH_NUMBER=101 #illusion of choice muahaha
        ;;
    101)
        printf "You $ANSWER. After a while, you see a cat on the road. It's a cute cat. You walk closer to the cat.\n"
        printf "\n"
        read -p "selection: " PARAGRAPH_NUMBER
        ;;
    quit)
        GAME_RUNNING=false
        ;;
    *)
        read -p "you chose $PARAGRAPH_NUMBER, which is not a valid number. Please try again, or write quit to quit the game" PARAGRAPH_NUMBER
        ;;
esac

printf "\n"

     
done
echo "thank you for playing!"
