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

_factorial.sh_

```
#!/bin/sh

factorial()
{
  if [ "$1" -gt "1" ]; then
    i=`expr $1 - 1`
    j=`factorial $i`
    k=`expr $1 \* $j`
    echo $k
  else
    echo 1
  fi
}

while :
do
  echo "Enter a number:"
  read x
  factorial $x
done
}
```

However when writing a suite of scripts, it is often easier to write a "library" of useful functions, and source that
file at the start of the other scripts, which use the functions. As we shall see in the following example.

_common.lib_

```
STD_MSG="About to rename some files..."

rename()
{
  # expects to be called as: rename .txt .bak
  FROM=$1
  TO=$2

  for i in *$FROM
  do
    j=`basename $i $FROM`
    mv $i ${j}$TO
  done
}
```

_function3.sh_

```
#!/bin/sh
. ./common.lib
echo $STD_MSG
rename .txt .bak
```

_function4.sh_

```
#!/bin/sh
. ./common.lib
echo $STD_MSG
rename .html .html-bak
```

Here we see two user shell scripts _function3.sh_ and _function4.sh_ each sourcing the common library file _common.lib_
and using variables and functions declared in that file.

## Return codes

_function5.sh_

```
#!/bin/sh

adduser()
{
  USER=$1
  PASSWORD=$2
  shift; shift;
  COMMENTS=$@
  useradd -c "${COMMENTS}" $USER
  if [ "$?" -ne "0" ]; then
    echo "Useradd failed"
    return 1
  fi
  passwd $USER $PASSWORD
  if [ "$?" -ne "0" ]; then
    echo "Setting password failed"
    return 2
  fi
  echo "Added user $USER ($COMMENTS) with pass $PASSWORD"
}

# Main script starts here

adduser bob letmein Bob Holness from Blockbusters
ADDUSER_RETURN_CODE=$?
if [ "$ADDUSER_RETURN_CODE" -eq "1" ]; then
  echo "Something went wrong with useradd"
elif [ "$ADDUSER_RETURN_CODE" -eq "2" ]; then
  echo "Something went wrong with passwd"
else
  echo "Bob Holness added to the system."
fi
```

You have to save `$?` because as soon as you run another command, such as `if`, it's value will be replaced. That is why
we save the `adduser` return value in `$ADDUSER_RETURN_CODE` variable, before acting on its content. 
`$ADDUSER_RETURN_CODE` is certain to remain the same. `$?` will change with every command that is executed.
