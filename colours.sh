#!/bin/bash
COL_NORM=$(tput setaf 7)
COL_RED="$(tput setaf 1)"
COL_GREEN="$(tput setaf 2)"
echo "It's$COL_RED red ${COL_NORM}and ${COL_GREEN}green ${COL_NORM} - have you seen?"
echo "${COL_NORM}Hello World!" 



    # tput_colors - Demonstrate color combinations.

    for fg_color in {0..7}; do
        set_foreground=$(tput setaf $fg_color)
        for bg_color in {0..7}; do
            set_background=$(tput setab $bg_color)
            echo -n $set_background$set_foreground
            printf ' F:%s B:%s ' $fg_color $bg_color
        done
        echo $(tput sgr0)
    done

    # tput_characters - Test various character attributes

    clear

    echo "tput character test"
    echo "==================="
    echo

    tput bold;  echo "This text has the bold attribute.";     tput sgr0

    tput smul;  echo "This text is underlined (smul).";       tput rmul

    # Most terminal emulators do not support blinking text (though xterm
    # does) because blinking text is considered to be in bad taste ;-)
    tput blink; echo "This text is blinking (blink).";        tput sgr0

    tput rev;   echo "This text has the reverse attribute";   tput sgr0

    # Standout mode is reverse on many terminals, bold on others. 
    tput smso;  echo "This text is in standout mode (smso)."; tput rmso

    tput sgr0
    echo
