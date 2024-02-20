### Ubuntu Command-Line Tips and Tricks

Ubuntu, like all Linux distributions, offers a rich command-line experience. Here's a collection of tips, tricks, and shortcuts to help you get the most out of the Ubuntu terminal:

#### **1. Command History Shortcuts:**

- **History Command**:

  - Display the command history using `history`.
  - This will list previously executed commands.

- **Search Through Command History**:

  - Press `Ctrl + R` and start typing to search through the previously executed commands.
  - Continue pressing `Ctrl + R` to cycle through matching commands.

- **Execute Previous Command**:

  - Use `!!` to quickly run the last command.

- **Use Previous Command's Arguments**:
  - Use `!$` to reuse the arguments from the last command.

#### **2. Terminal Navigation Shortcuts:**

- **Move to the Beginning of the Line**: `Ctrl + A`
- **Move to the End of the Line**: `Ctrl + E`
- **Delete from Cursor to Beginning of Line**: `Ctrl + U`
- **Delete from Cursor to End of Line**: `Ctrl + K`
- **Clear the Screen**: `Ctrl + L` (Alternatively, use the `clear` command.)

#### **3. Terminal Tab Completion:**

- Start typing a command, filename, or directory name and then press `Tab`. The terminal will auto-complete based on context. If multiple completions are possible, double-tap `Tab` to list all matching items.

#### **4. Working with Directories:**

- **Change to Home Directory**: Simply use `cd` without arguments.

- **Move One Directory Up**: Use `cd ..`

- **View Contents of a Directory**: Use `ls`. Add `-l` for a long listing format and `-a` to show hidden files.

#### **5. Useful Key Combinations:**

- **Stop a Running Command**: `Ctrl + C`
- **Pause a Running Command**: `Ctrl + Z`

  - To resume the paused command in the foreground, use `fg`.

  - To resume the paused command in the background, use `bg`.

- **Exit Terminal**: `Ctrl + D` (Alternatively, use the `exit` command.)

#### **6. Command Aliases:**

- Create shortcuts for long commands using aliases.

  - Example: `alias ll='ls -la'`. This will allow you to use `ll` as a shortcut for `ls -la`.

- These aliases are session-specific. To make them permanent, add them to your `~/.bashrc` or `~/.bash_aliases` file.

#### **7. Redirect and Chain Commands:**

- **Redirect Output**: Use `>` to redirect the output of a command. For example, `echo "Hello" > hello.txt` will save the text "Hello" to a file named hello.txt.
- **Append Output**: Use `>>` to append the output to an existing file.
- **Chain Commands**: Use `&&` to execute one command after another only if the first one succeeds. For example, `mkdir new_directory && cd new_directory`.

#### **8. Check Disk Usage:**

- **Disk Usage of a Directory**: Use `du -sh <directory-name>` to see the total disk usage of a directory.
- **Disk Usage of a System**: Use `df -h` to get a readable format of disk space usage on all mounted filesystems.
