# Variables (Part 2)

There are a set of variables which are set for you already, and most of these cannot have values assigned to them.

- `$0 .. $9` Are the first 9 additional parameters the script was called with.
- `$@` Is all the parameters `$1 .. whatever`.
- `$*` Is similar, but does not preserve any whitespace and quoting.
- `$#` Is the number of parameters the script was called with.

_var1.sh_

```
#!/bin/sh
echo "I was called with $# parameters"
echo "My name is $0"
echo "My first parameter is $1"
echo "My second paramter is $2"
echo "All paramteres are $@"
```

Let's look at running this code and see the output.

```
$ ./var.sh anjith swetha hola
I was called with 3 parameters
My name is ./var.sh
My first parameter is anjith
My second paramter is swetha
All parameters are anjith swetha hola
```

Note that the value of `$0` changes depending on how the script was called. The external utility `basename` can help
tidy this up.

```
echo "My name is `basename $0`"

We can take more than 9 parameters by using the `shift command`. Look at the script below.

_var2.sh_

```
#!/bin/sh
while [ "$#" -gt "0" ]
do
  echo "\$1 is $1"
  shift
done
```

This script keeps on using `shift` until `$#` is down to zero, at which point the list is empty.

Another special variable is `$?`. This contains the exit value of the last run command. So the code.

```
#!/bin/sh
/usr/local/bin/my-command
if [ "$?" -ne "0" ]; then
  echo "Sorry, we had a problem there!"
fi
```

Will attempt to run _/usr/local/bin/my-command_ which should exit with a value of zero if all went well, or a nonzero
value on failure. We can then handle this by checking the value of `$?` after calling the command. This helps make
scripts more robust and more intelligent. Well behaved applications should return zero on success.

The other two main variables set for you by the environment are `$$` and `$!`. These are both process numbers.

The `$$` variable is the PID (Process IDentifier) of the currently running shell. This can be useful for creating
temporary files such as _tmp/my-script.$$_ which is useful if many instances of the script could be run at the same
time, and they all need their own temporary files.

The `$!` variable is the PID of the last run background process. This is useful to keep track of the process as it gets
on with its job.
