# Case

The `case` statement saves going through a while set of `if .. then .. else` statements.

_talk.sh_

```
#!/bin/sh

echo "Please talk to me ..."
while :
do
  read INPUT_STRING
  case $INPUT_STRING in
      hello)	echo "Hello yourself!" 		;;
      bye)	echo "See you again!"
      		break
		;;
      *)	echo "Sorry, I don't understand";;
  esac
done
echo
echo "That's all folks!"
```

Try running it and check how it works.

```
$ ./talk.sh
Please talk to me ...
hello
Hello yourself!
What do you think of politics?
Sorry, I don't understand
bye
See you again!

That's all folks!
```

Note that if we wanted to exit the script completely then we would use the command `exit` insted of `break`. The third
command `*)` is the default catch-all condition. It is not required, but is often useful for debugging purposes.

The whoe case statement is ended with `esac` (case backwards`).
