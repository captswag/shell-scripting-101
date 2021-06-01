# A First Script

_first.sh_

```
#!/bin/sh
# This is a comment
echo Hello World # This is a comment, too!
```

The first line tells Unis the that the file is to be executed by /bin/sh. This is the standard location of the Bourne
shell on just about every Unix system.

\# marks the line as a comment.

The third line runs a command: echo, with two parameters or arguments. The first is "Hello", and the second is "World".

Now run `chmod 755 first.sh` to make the file executable and run `./first.sh`.

The screen should look like this.

```
$ ./first.sh
Hello World
$
```
