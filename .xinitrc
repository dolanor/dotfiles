# Set MS keyboard to azerty layout
setxkbmap -device `xinput -list | grep "Microsoft Wired" | cut -d"=" -f2 | cut -c 1-2` -layout fr


