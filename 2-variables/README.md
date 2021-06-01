# Variables (Part 1)

A symbolic name for a chunk of memory to which we can assign values, read and manipulate its contents.

Note that there must be no spaces around the "=" sign. VAR=value works; VAR = value doesn't work. In the first case, the
shell sees the "=" symbol and treats the command as a variable assignment. In the second case, the shell assumes that
VAR must be the name of the command and tries to execute it.

_var1.sh_

```
#!/bin/sh
MY_MESSAGE="Hello World"
echo $MY_MESSAGE
```

This assigns the string "Hello World" to the variable `MY_MESSAGE` and then echoes out the value of the variable. Note
that we need quotes around the string Hello World. Whereas we could get away with echo Hello World because echo will
take any number of parameters. A variable can hold only one value, so a string with spaces must be quotes so that the
shell knows to treat it all as one.

The shell does not care about types of variables. They may store strings, integers, real numbers - anything you like.

_var2.sh_

```
x="hello"
expr $x + 1
```

On execution, you will get the error `expr: non-numeric argument`. This is because the external program `expr` only
expects numbers.

We can interactively set variables using the `read` command. The following script asks your for your name and then
greets you personally.

_var3.sh_

```
#!/bin/sh
echo What is your name?
read MY_NAME
echo "Hello $MY_NAME - hope you're well."
```

This is using the shell's built-in command `read` which reads a line from standard input into the variable supplied.
Note that even if you give your full name and don't use double quotes around the `echo` command, it still outputs
correctly. With the `MY_MESSAGE` variable earlier we had to put double quotes around it to set it. What happens is that
`read` command automatically places quotes around its input, so that spaces are treated correctly.

## Scope of variables

If you try to read an undeclared variable, the result is the empty string. You get no warnings or errors which can cause
subtle bugs.

_myvar2.sh_

```
#!/bin/sh
echo "MYVAR is: $MYVAR"
MYVAR="hi there"
echo "MYVAR is: $MYVAR"
```

Now run the script.

```
$ ./var4.sh
MYVAR is:
MYVAR is: hi there
```

Which is expected. The value of `MYVAR` hasn't been set to any value and so it's blank.

Now run.

```
$ MYVAR=hello
$ ./var4.sh
MYVAR is:
MYVAR is: hi there
```

When you call _var4.sh_ from your interactive shell, a new shell is spawned to run the script. This is partly because of
the `#!/bin/sh` at the start of the line.

We need to export the variable for it to be inherited by another program including a shell script.

```
$ export MYVAR
$ ./var4.sh
MYVAR is: hello
MYVAR is: hi there
```

Now look at line 3 of the script. This is changing the value of `MYVAR`. But there is no way that this will be passed
back to your interactive shell. Try reading the value of `MYVAR`.

```
$ echo $MYVAR
hello
```

Once the shell script exists, its environment is destroyed. But `MYVAR` keeps its value of `hello` within your
interactive shell. In order to receive environment changes back from the script, we must source the script. This
effectively runs the script within our own interactive shell, instead of spawing anohter shell to run it.

We can source a script via the "." (dot) command.

```
$ MYVAR=hello
$ echo $MYVAR
hello
$ . ./var4.sh`
MYVAR is: hello
MYVAR is: hi there
$ echo $MYVAR
hi there
```

The change has now made it out into our shell again! This is how your `.profile` or `.bash_profile` file works.

_var5.sh_

```
#!/bin/sh
echo "What is your name?"
read USER_NAME
echo "Hello $USER_NAME"
echo "I will create you a file called ${USER_NAME}_file"
touch "${USER_NAME}_file"
```

The shell in the above code knows that you're referring to the variable `USER_NAME` and that we want it to be suffixed
with `_file`.
