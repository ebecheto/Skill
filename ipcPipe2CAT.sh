#!/bin/bash
# copy paste from http://www.linuxjournal.com/content/using-named-pipes-fifos-bash
# while debugging load : $> ~/Skill/ipcPipe2CAT.sh | tee &
# from load("emacs_ipcPipe.il")
# ipcBeginProcess(strcat(getShellEnvVar("SKILLDIR") "/ipcPipe2CAT.sh") "" 'socketHandler)
# TODO : add $1 argument to the script to create a pipe related to the PID of the virtuoso session
# pipe=/tmp/ipcPipe2CAT_$USER_$PID

pipe=/tmp/ipcPipe2CAT_$USER

rm -f ~/.emacs2icfb.il
trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then mkfifo $pipe; fi
ret=""
while true; do
    if read line <$pipe; then
        if [[ "$line" == 'quit' ]]; then break; fi
	ret+=$line
	if [[ "$ret" == *'EOF' ]]; then echo ${ret%EOF}; ret="" ;fi
#        echo "GOT:$line$()__$ret" #<== do not uncomment this one! otherwise : twice eval!
    fi
done

echo "Reader exiting"

## writer side :
# #!/bin/bash
# pipe=/tmp/testpipe
# if [[ ! -p $pipe ]]; then
#     echo "Reader not running"
#     exit 1
# fi
# if [[ "$1" ]]; then
#     echo "$1" >$pipe
# else
#     echo "Hello from $$" >$pipe
# fi

