# Vi Editor & Shortcuts

The vi editor is a powerful, terminal-based text editor used in Unix and Linux systems for editing configuration files, scripts, and system documents.

It is lightweight, fast, and available by default on almost every Linux distribution — making it essential for system administrators and DevOps engineers.

vi (Visual Editor) is a modal text editor created for Unix systems which is;

- Terminal-based

- Lightweight

- Keyboard-driven

- Always available on minimal Linux systems

It is widely used for:

- Editing system files (/etc/passwd, /etc/ssh/sshd_config)

- Writing shell scripts

- Modifying configuration files

- Quick file edits on servers

## Vim 

vim stands for:

Vi Improved

It is an enhanced version of vi with:

- Syntax highlighting

- Better undo/redo

- Improved search

- Visual mode

- Plugins support

- Extended features

Most modern systems use vim even when you type vi.

## Difference Between vi and vim

```
| Feature                    | vi       | vim                  |
| -------------------------- | -------  | -------------------- |
| Default on minimal systems | ✅       | ❌ (may need install) |
| Syntax highlighting        | ❌       | ✅                    |
| Multiple undo levels       | Limited  | Unlimited            |
| Visual mode                | ❌       | ✅                    |
| Plugin support             | ❌       | ✅                    |

```
## Installing Vim

On Debian/Ubuntu systems:
```
apt update
apt install vim
```

Verify installation:
```
vim --version
```

## Creating Files

### Method 1 – Using touch

```
touch myfile.txt
```

Then open it:

```
vim myfile.txt
```

### Method 2 – Create File Directly with Vim

```
vim newfile.txt
```
- If the file does not exist, Vim creates it upon saving.

## Vim Modes

Vim is a modal editor, meaning it has different modes for different actions.

Modes in VI Editor:

- Normal Mode (default) – Used for navigation and command execution.

- Insert Mode – Used for text editing (press i to enter, Esc to exit).

- Command Mode – Used for saving, quitting, and searching (press : in Normal mode).

Basic Workflow Example;

Step 1 – Open File:
```
vim example.txt
```

Step 2 – Enter Insert Mode

Press:
```
i
```

You are now in Insert Mode.

Write a paragraph:
```
Linux is a powerful multi-user operating system.
The vi editor is essential for server administration.
Understanding Vim improves productivity and efficiency.
```

Step 3 – Exit Insert Mode

Press:
```
Esc
```
You are now back in Normal Mode.

Step 4 – Save and Quit

Save and exit:
```
:wq
```

Force save and quit:
```
:wq!
```

Quit without saving:
```
:q!
```

Other Useful Save/Quit Options:

```
| Command       | Action                   |
| ------------- | ------------------------ |
| `:w`          | Save file                |
| `:q`          | Quit (if no changes)     |
| `:w filename` | Save as new file         |
| `ZZ`          | Save and quit (shortcut) |
| `:x`          | Save and quit (like :wq) |
```

View File Content

After exiting Vim:


```
cat example.txt
```
This displays what you wrote.


VI Editor Shortcuts
Modes in VI Editor

Normal Mode (default) – Used for navigation and command execution.

Insert Mode – Used for text editing (press i to enter, Esc to exit).

Command Mode – Used for saving, quitting, and searching (press : in Normal mode).

Basic Navigation

h – Move left

l – Move right

j – Move down

k – Move up

0 – Move to the beginning of the line

^ – Move to the first non-blank character of the line

$ – Move to the end of the line

w – Move to the next word

b – Move to the previous word

gg – Move to the start of the file

G – Move to the end of the file

:n – Move to line number n

Insert Mode Shortcuts

i – Insert before cursor

I – Insert at the beginning of the line

a – Append after cursor

A – Append at the end of the line

o – Open a new line below

O – Open a new line above

Esc – Exit insert mode

Editing Text

x – Delete a character

X – Delete a character before cursor

dw – Delete a word

dd – Delete a line

d$ – Delete from cursor to end of line

d0 – Delete from cursor to beginning of line

D – Delete from cursor to end of line

u – Undo last action

Ctrl + r – Redo an undone change

yy – Copy (yank) a line

yw – Copy (yank) a word

p – Paste after the cursor

P – Paste before the cursor

Search and Replace

/pattern – Search forward for a pattern

?pattern – Search backward for a pattern

n – Repeat last search forward

N – Repeat last search backward

:%s/old/new/g – Replace all occurrences of "old" with "new"

:s/old/new/g – Replace all occurrences in the current line

Working with Multiple Files

:e filename – Open a new file

:w – Save file

:wq – Save and exit

:q! – Quit without saving

:split filename – Split screen horizontally and open another file

:vsplit filename – Split screen vertically

Ctrl + w + w – Switch between split screens

