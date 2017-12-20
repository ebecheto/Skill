#!/bin/bash
# copy paste from http://www.linuxjournal.com/content/using-named-pipes-fifos-bash
pipe=/tmp/ipcPipe2CAD_$USER

trap "rm -f $pipe" EXIT

if [[ ! -p $pipe ]]; then    mkfifo $pipe  ; fi

while true; do
    if read line <$pipe; then
        if [[ "$line" == 'quit' ]]; then
            break
        fi
        echo $line
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

