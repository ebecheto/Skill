#!/bin/bash
# copy paste from http://www.linuxjournal.com/content/using-named-pipes-fifos-bash
# while debugging load : $> ~/Skill/ipcPipeCAT.sh | tee &
pipe=/tmp/ipcPipe2CAT_$USER

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then mkfifo $pipe; fi
ret=""
while true; do
    if read line <$pipe; then
        if [[ "$line" == 'quit' ]]; then break; fi
	ret+=$line
	if [[ "$ret" == *'EOF' ]]; then echo ${ret%EOF}; ret="" ;fi
#        echo "GOT:$line$()__$ret"
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

