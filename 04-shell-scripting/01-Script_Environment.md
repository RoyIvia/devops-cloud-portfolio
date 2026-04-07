# Script Environment Setup and Execution

This section covers the fundamental workflow of creating, editing, and executing shell scripts in a Unix/Linux environment. It includes working with `vim`, understanding the shebang, running scripts, handling permission errors, and basic scripting practices.


### Creating a Script File
A script file can be created using:

```sh
touch script.sh
```

Alternatively, you can create and open the file directly using:

```sh
vim script.sh
```

### Editing the Script (Using Vim)
Open the script:

```sh
vim script.sh
```

Enter insert mode by pressing:

```sh
i
```


### Shebang (Specifying the Shell)
At the top of the script, define the shell using a shebang:

```sh
#!/bin/bash
```

The shebang tells the system which interpreter to use when executing the script. This ensures consistent behavior across environments.


### Writing a Simple Script
Example:

```sh
#!/bin/bash

echo "My name is Royston"
```

### Saving and Exiting Vim

Save and exit:

```sh
:wq
```

Exit without saving:

```sh
:q!
```


### Viewing the Script
To display the contents of the script:

```sh
cat script.sh
```


### Running the Script

Using `sh`:

```sh
sh script.sh
```

Running directly:

```sh
./script.sh
```

### Permission Denied Error
When running:

```sh
./script.sh
```

You may get:

```sh
Permission denied
```

This happens because the script does not have execute permissions.


### File Permissions
Grant execute permission using:

```sh
chmod +x script.sh
```

Then run:

```sh
./script.sh
```


### Understanding File Permissions
Linux files have permissions that control:

- Read (`r`)
- Write (`w`)
- Execute (`x`)

For a script to run, it must have execute (`x`) permission.


### Comments in Shell Scripts
Comments are used to explain code and are ignored during execution.

```sh
# This is a comment
echo "Hello"
```

Anything starting with `#` is treated as a comment, except the shebang (`#!`), which has a special meaning.



