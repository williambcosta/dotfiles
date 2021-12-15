## Introduction

Searching for an elegant way to backup my dotfiles, I found this [article](https://www.atlassian.com/git/tutorials/dotfiles) from [Nicola Paolucci](https://twitter.com/durdn). With this solution, is easier to do so, with the benefit of version control.


## Alternatives

Before we start is good to know some alternatives that you may find easier, or more convenient for you to try.

One way is to do this all by yourself copying the files in a backup folder, using a usb drive, etc. Some people use [GNU Stow](https://www.gnu.org/software/stow/) for this purpose.

### GNU Stow

[GNU Stow](https://www.gnu.org/software/stow/) is a symlink farm manager. In other words, it take what you want to manage, puts it in a directory and create a symlink to it in the original place. It works great and is relatively easy to find a good tutorial in the internet to learn how to use it for manage your dotfiles.

But, as I don't have a lot of things to manage it is a little to much for me. But I'll definitely will consider change method as the number of files I want to track grow.

## Configuration

We will use git to keep track of our files, and you can store them in a remote repo, if you want.

First you have to create a [git bare repository](http://www.saintsjd.com/2011/01/what-is-a-bare-git-repository/). I call mine `.dotfiles`, but you can name it as you prefer.

```bash
git init --bare $HOME/.dotfiles
```

Now to help manage the files you have to create an alias for the git command passing the bare repo you just created as the git dir and `$HOME` as the working tree. You don't need to do that, but it saves a lot of keystrokes.

```bash
alias dfconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

It may vary depend of your chosen shell, so make sure to adapt this command if necessary. For example, fish shell doesn't have aliases, so you have to create a function.

```sh
# In fish shell you have to add the $argv to allow passing arguments for the function.
# Don't forget to save the function with funcsave or put this in your fish config file.
function dfconfig
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
```

Finally configure your repo to hide the untracked files (allowing you to run dfconfig status without showing all the files on you HOME folder) and ignore the repo folder.

```bash
dfconfig config --local status.showUntrackedFiles no
echo ".dotfiles" >> $HOME/.gitignore
```


## Usage

With everything done, you can manage your dotfiles the same way as any git repo, but using dfconfig instead of the git command.

```bash
dfconfig add .vimrc
dfconfig commit -m "Add vim config file"
dfconfig status
dfconfig add ~/.config/fish/config.fish
dfconfig commit -m "Add config.fish"
dfconfig push
```

Basically you add, commit and push everything you want to track. Don't forget to add the remote origin before push it.

```bash
dfconfig remote add origin <git-repo-url>
```


### Installing your dotfiles in a new system

Clone your files into a bare repository in your Home directory:

```bash
git clone --bare <git-repo-url> $HOME/.dotfiles
```

Define an alias in the new system:

```bash
alias dfconfig='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

In fish:
```sh
function dfconfig
    git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
```

And finally checkout to restore the files:

```bash
dfconfig checkout
```

The command above may fail if, in the new system, you already have a file with the same name as the one git is trying to copy. Like below:

```bash
error: The following untracked working tree files would be overwritten by checkout:
    .bashrc
    .gitignore
Please move or remove them before you can switch branches.
Aborting
```

You can delete the conflicting files or, if the files have some configuration you want to keep, move them to a backup folder and try checkout again.

Don't forget to hide the untracked files:

```bash
dfconfig config --local status.showUntrackedFiles no
```

Done. Now your files are in place and you can use your alias as always to track new files and changes.

```bash
dfconfig add ~/.config/alacritty/alacritty.yml
dfconfig status
dfconfig commit -a -m "Update vim config file and add alacritty.yml" # I know, this is dumb
dfconfig push
```
