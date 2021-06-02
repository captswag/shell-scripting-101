# Loops

We have `for` and `while` loops in the Bourne shell.

## For loops

`for` loops iterate through a set of values until the list is exhausted.

_for.sh_

```
#!/bin/sh
for i in hello 1 * 2 goodbye
do
  echo "Looping ... i is set to $i"
done
```

Output of the above goes like this.

```
Looping ... i is set to hello
Looping ... i is set to 1
Looping ... i is set to (name of the first file in the current directory)
   ... etc ...
Looping ... i is set to (name of the last file in the current directory)
Looping ... i is set to 2
Looping ... i is set to goodbye
```

So as you can see here `for` simply loops through whatever input it is given until it runs out of input.

## While loops

`while` loops can be much more fun.

_while1.sh_

```
#!/bin/sh
INPUT_STRING=hello
while [ "$INPUT_STRING" != "bye" ]
do
  echo "Please type something in (bye to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```

The colon (:) always evaluates to true. While this can be necessary sometimes, it is often preferable to use a real exit
condition.

_while2.sh_

```
#/bin/sh
while :
do
  echo "Please type something in (^C to quit)"
  read INPUT_STRING
  echo "You typed: $INPUT_STRING"
done
```

Another useful trick is `while read` loop. This example also uses the `case` statement. It reads from the file
_myfile.txt_ and for each line, tells you what language it thinks is being used.

_while3.sh_

```
#!/bin/sh
while read input_text
do
  case $input_text in
      hello)		echo English	;;
      howdy)		echo American   ;;
      gday)		echo Australian ;;
      bonjour)		echo French	;;
      "guten tag")	echo German	;;
      *)		echo Unknown Language: $input_text ;;
  esac
done < myfile.txt
