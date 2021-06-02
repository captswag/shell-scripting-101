# 3. Escape characters

How do we display `Hello       "World"`?

```
$ echo "Hello      \"World\""    
```

The first and last " characters wrap the whole lot into one parameter passed to the `echo` program so that the spacing
between the two words is kept as is.

Similarly most characters (\*,\`,etc) are not interpreted (ie, they are taken literally) by means of placing them in
double quotes (""). They are taken as is and passed on the command being called. An example using the asterisk (\*)
goes.

```
$ echo *
file1.html file2.txt file3.mp3 file4.mp4
$ echo *txt
file2.txt
$ echo "*"
*
$ echo "*txt"
*txt
```

In the first example * is expanded to mean all files in the current directory. In the second example, \*txt mean all
files ending in txt. In the third, we put * in double quotes and it is interpreted literally. In the fourth example, the
same applies, but we have appended txt to the string.

However ", $, \`, and \ are still interpreted by the shell, even when they're in double quotes. The backslash (\\)
character is used to mark these special characters so that they are not interpreted by the shell, but passed on to the
command being run (for example, `echo`).

So inorder to output the string (assuming that the value of $X is 5).

```
A quote is ", backslash is \, backtick is `.
A few spaces are    and dollar is $. $X is 5
```

We would have to write.

```
$ echo "A quote is \", backslash is \\, backtick is \`."
A quote is ", backslash is \, backtick is`.
$ echo "A few spaces are    and dollar is \$. \$X is ${X}."
A few spaces are    and dollar is $. $X is 5.
```

We have seen why the " is special for preserving spacing. Dollar ($) is special because it marks a variable, so $X is
replaced by the shell with the contents of the variable X. Backlash (\\) is special because it itself is used to mark
other characters off.

```
$ echo "This is \" a quote and this is \\ a backslash"
This is " a quote and this is \ a backslash
```
