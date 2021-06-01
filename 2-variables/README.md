# Variables

## Part 1

A symbolic name for a chunk of memory to which we can assign values, read and manipulate its contents.

Not that there must be no spaces around the "=" sign. VAR=value works; VAR = value doesn't work. In the first case, the
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

We can interactively set variable names using the `read` command. The following script asks your for your name and then
greets you personally.

_var3.sh_

```
#!/bin/sh
echo What is your name?
read MY_NAME
echo "Hello $MY_NAME - hope you're well."
```

This is using the shell-builtin command `read` which reads a line from standard input into the variable supplied. Note
that even if you give your full name and don't use double quotes around the `echo` command, it still outputs correctly.
With the `MY_MESSAGE` variable earlier we had to put double quotes around it to set it.

What happens is that `read` command automatically places quotes around its input, so that spaces are treated correctly.

### Scope of variables
