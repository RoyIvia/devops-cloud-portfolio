# Linux Wildcards & File Pattern Matching

 Wildcards allow you to match files using patterns, which is essential for DevOps, scripting, and automation.
 
## Common Wildcards

- `*`      - Matches zero or more characters
- `?`      - Matches exactly one character
- `[abc]`  - Matches any one character in the set
- `[a-z]`  - Matches a character in the range
- `[^abc]` - Matches any character not in the set

Setup Testing Environment:

```
mkdir -p wildcard_lab
cd wildcard_lab
touch file1.txt file2.txt fileA.txt test.log data.csv script.sh gamer ghost grape gnose gonzp guyak gumpy mkfile mkdocs mk
```

Examples:

`ls *.txt `            # List all .txt files
`ls file?.txt`         # List files with exactly one character in place of ?
`ls file[ab].txt`      # List files where one character is a or b
`ls file[a-c].txt`     # List files where one character is a, b, or c
`ls file[^a-c].txt`    # List files excluding a, b, c

Practical Examples:

`ls -a `          # View all files including hidden
`ls g????`        # Files starting with 'g' and exactly five letters
`ls mk*`          # Files starting with 'mk' followed by any characters
`ls g[a-n]???`    # Files five letters starting with 'g', second letter a–n
`ls g[^a-m]???`   # Files five letters starting with 'g', second letter NOT a–m
`ls g[a-n]*.txt`  # Files starting with 'g', second letter a–n, ending with .txt

Real DevOps Use Cases:

`rm *.log`         # Delete all .log files
`mv *.sh scripts/` # Move all shell scripts
`cp g???? backup/` # Backup files starting with g
`ls g[^a-m]???`    # List files not matching a range

Hidden File Caveats:

`ls *`       # Non-hidden files
`ls .*`     # Hidden files
`ls .* *`   # Both hidden and normal files

Testing Patterns:
`ls *.txt`        # Lists all files ending with .txt
`ls g???? `       # Lists files starting with 'g' and exactly 5 characters
`ls mk*`         # Lists files starting with 'mk'
`ls g[a-n]???`   # Lists 5-letter files starting with 'g', 2nd letter a–n
`ls g[^a-m]???`   # Lists 5-letter files starting with 'g', 2nd letter NOT a–m

Summary & Best Practices:

`*` → zero or more characters
`?` → exactly one character
`[abc]` → match a set
`[^abc]`→ exclude a set
Use `-a `to include hidden files
Always test with `ls` before using `rm` or `mv`

Mastery of wildcards is essential for scripting, log management, CI/CD pipelines, and automation in DevOps.
