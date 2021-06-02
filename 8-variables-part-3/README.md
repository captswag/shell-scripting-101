# Variables (part 3)

As we mentioned in [Variables (part 1)](../2-variables-part-1/README.md), curly brackets around a variable avoid
confusion.

```
foo=sun
echo $fooshine	 # $fooshine is undefined
echo ${foo}shine # displays the word "sunshine"
```

## Using default values

Consider the following code snippet which prompts the user for input, but accepts defaults.

_name.sh_

```
#!/bin/sh
echo "What is your name [ `whoami` ] "
read MYNAME
if [ -z "$MYNAME" ]; then
  MYNAME=`whoami`
fi
echo "Your name is: $MYNAME"
```

This following script runs like this if you accept the default by pressing "RETURN".

```
$ ./name.sh
What is your name [ captswag ]
Your name is: captswag
```

or with user input

```
$ ./name.sh
What is your name [ captswag ] foo
Your name is: foo
```

This could be done better using a shell variable feature. By using the curly braces and the special ":-" usage, you can
specify a default value to use if the variable is unset.

```
echo "What is your name [ `whoami` ] "
read MYNAME
echo "Your name is: ${MYNAME:-`whoami`}"
```

We're using the output of the whoami comamnd, which prints your login name (UID). The more canonical example is to use
fixed test like this.

```
echo "Your name is: ${MYNAME:-John Doe}"
```

## Using and setting default values

There is another syntax ":=" which sets the variable to the default if it is undefined.

```
echo "Your name is: ${MYNAME:=John Doe}"
```

This technique means that any subsequent access to `$MYNAME` variable will always get a value, either entered by the
user or "John Doe" otherwise.
