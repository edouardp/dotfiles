# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
        STAT=`parse_git_dirty`
        echo " ${BRANCH}${STAT}"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${ahead}" == "0" ]; then
        bits=" ${bits}"
    fi
    if [ "${renamed}" == "0" ] || [ "${newfile}" == "0" ] || [ "${deleted}" == "0" ] || [ "${dirty}" == "0" ]; then
        bits=" ${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits=" ${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

function initial_colour() {
    RETVAL=$?
    if [[ $RETVAL -ne 0 ]]; then
        echo -e "\033[38;5;196m";
    else
        echo -e "\033[38;5;15m";
    fi
    (exit $RETVAL)  # Set $? via hideous hack
}


function initial_char() {
    RETVAL=$? 
    if [[ $RETVAL -ne 0 ]]; then
        echo "";
    else
        if [ -f /etc/os-release ]
        then
            if grep -iq ubuntu /etc/os-release; then echo ""; fi
            if grep -iq raspbian /etc/os-release; then echo ""; fi
        else
            echo ""
        fi
        #echo $OSCHAR
        #echo "";
        #echo "";
        #echo "";
    fi
}



export PS1="\[\$(initial_colour)\]\`initial_char\` \[\e[38;5;99m\]\h \[\e[38;5;45m\]\w\[\e[38;5;226m\]\`parse_git_branch\` \[\e[38;5;15m\] "

