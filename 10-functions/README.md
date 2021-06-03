# Functions

Functions are read in, but basically ignored until they are actually called. Function may return a value in one of the
four different ways.

- Change the state of a variable or variables
- Use the `exit` command to end the shell script
- User the `return` command to the function and return the supplied value to the calling section of the shell script
- echo output to stdout, which will be caught by the caller just as c=`expr $a + $b` is caught

_function1.sh_

```
#!/bin/sh

add_a_user()
{
  USER=$1
  PASSWORD=$2
  shift; shift;
  # Having shifted twice, the rest is now comments ...
  COMMENTS=$@
  echo "Adding user $USER ..."
  echo useradd -c "$COMMENTS" $USER
  echo passwd $USER $PASSWORD
  echo "Added user $USER ($COMMENTS) with the pass $PASSWORD"
}

# Main body of the script starts here
echo "Start of script..."
add_a_user bob letmein Bob Holness the presenter
add_a_user fred badpassword Fred Durst the singer
add_a_user bilko worsepassword Sgt. Bilko the role model
echo "End of script..."
```

In this case `add_a_user` is read in and checked for syntax, but not executed until it is explicitly called.

## Scope of variables

Programmers used to other languages may be surprised at the scope rules for shell functions. Basically there is no
scoping , other than the parameters (`$1`, `$2`, `$@` etc).

_function2.sh_

```
#!/bin/sh

myfunc()
{
  echo "I was called as: $@"
  x=2
}

# Main script starts here

echo "Script was called wth $@"
x=1
echo "x is $x"
myfunc 1 2 3
echo "x is $x"
```

Let's look at the sample output.

```
$ ./function2.sh a b c
Script was called with a b c
x is 1
I was called as 1 2 3
x is 2
```

The `$@` parameters are changed within the function to reflect how the function was called. The variable `x` however, is
effectively a global variable - `myfunc` changed it and that change is still effective when control returns to the main
script.

## Recursion

Functions can be recursive, here's a simple example of factorial function.
