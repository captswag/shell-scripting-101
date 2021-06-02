# External programs

the backtick (\`) is often associated with external commands. The backtick is used to indicate that the enclosed text is
to be executed as a command.

```
$ grep "^${USER}:" /etc/passwd | cut -d: -f5
Anjith Sasindran
```

Now we will grab this output into a variable which we can manupilate more easily.

```
$ MYNAME=`grep "^${USER}:" /etc/passwd | cut -d: -f5`
$ echo $MYNAME
Anjith Sasindran
```

So we see that the backtick simply catches the standard output from any command or set of commands and we chose to run.
It can also improve performance if you want to run a slow command or set of commands and parse various bits of its
output.

```
#!/bin/sh
find / -name "*.html" - print | grep "/index.html$"
find / -name "*.html" - print | grep "/contents.html$"
```

This could could take a long time to run, and we are doing it twice! A better solution is.

```
#!/bin/sh
HTML_FILES=`find / -name "*.html" - print`
echo "$HTML_FILES" | grep "/index.html$"
echo "$HTML_FILES" | grep "/contents.html$"
```

Note the quotes around `$HTML_FILES` are essential to preserve the newlines between each file listed. Otherwise `grep`
will see one huge line of text, and not one line per file.

This will we are only running the slow `find` once roughly halving the execution time of the script.
