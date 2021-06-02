# Test

Test is more frequently called `[`. `[` is a symbolic link to `test`. This means that `[` is actually a program, just
like `ls` and other programs. So it must be surrounded by spaces.

```
if [$foo = "bar" ]
```

Will not work, as it is interpreted as `if test$foo = "bar" ]`, which is a `]` without a beginning `[`.

A single `=` should be used for string comparison and `-eq` for integers.

Test is most often invoked indirectly via the `if` and `while` statements. It is also the reason you will come into
difficulties if you create a program called `test` and try to run it, as this shell built-in will be called instead of
your program!

The syntax for if...then...else... is.

```
if [ ... ]
then
  # if-code
else
  # else -code
fi
```

Note that `if [ ... ]` and `then` commands must be on different lines. Alternatively the semicolon `;` can separate
them.

```
if [ ... ]; then
  # do something
fi
```

You can also use `elif` like this.

```
if [ something ]; then
  echo "Something"
elif [ something_else ]; then
  echo "Something else"
else
  echo "None of the above"
fi
```

The following is a good example of various if constructs.

_test1.sh_

```
#!/bin/sh
if [ "$X" -lt "0" ]
then
  echo "X is less than zero"
fi
if [ "$X" -gt "0" ]; then
  echo "X is more than zero"
fi
[ "$X" -le "0" ] && \
    echo "X is less than or equal to zero"
[ "$X" -ge "0" ] && \
    echo "X is more than or equal to zero"
[ "$X" = "0" ] && \
    echo "X is the string or number \"0\""
[ "$X" = "hello" ] && \
    echo "X matches the string \"hello\""
[ "$X" != "hello" ] && \
    echo "X is not the string \"hello\""
[ -n "$X" ] && \
    echo "X is of nonzero length"
[ -f "$X" ] && \
    echo "X is the path of a real file" || \
    echo "No such file: $X"
[ -x "$X" ] && \
    echo "X is the path of an executable file"
[ "$X" -nt "/etc/passwd" ] && \
    echo "X is a file which is newer than /etc/passwd"
```

As we see from this example, `test` can perform many tests on numbers, strings and filenames.

Note than we can use the semicolon (;) to join two lines together. This is often done to save a bit of space in simple
`if` statements. The backslash (\\) serves a similar but opposite purpose. It tells the shell that this is not the end
of the line, but the following line should be treated as part of the current line. This is useful for readability.

Similarly `-a`, `-e` means file exists. `-S` means file is a socket, `-nt` mean file is newer than, `-ot` means file is
older than and `-O` means file is owned by the user runnings the test.

One last example which is self explanatory.

_test2.sh_

```
#!/bin/sh
X=0
while [ -n "$X" ]
do
  echo "Enter some text (RETURN to quit)"
  read X
  if [ -n "$X" ]; then
    echo "You said: $X"
  fi
done
___
