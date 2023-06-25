# DOTFILES

A collection of configuration files for the programs and tools I most commonly
use.

Feel free to *steal* any idea you find to your liking.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Install

The [install.sh] script creates a symlink for each folder of this repository to
a specific location (mostly ```$XDG_CONFIG_HOME``` - i.e. ```$HOME/.config```).  
This allows to reflect any changes to the configuration of one of these programs
in this git repository.

```sh
git clone https://github.com/marcoplaitano/dotfiles
cd dotfiles && ./install.sh
```

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Overview

### bat

A replacement for the `cat` utility that adds more functionalities.  
My config specifies the color theme and the information to display: line numbers,
git diffs and separator for different files.

### cronjobs

A text copy of my crontab file.

### git

+ config  
    aliases, formats, defaults.
+ ignore  
    files to ignore by default in every repository.
+ message  
    commit message info template.

### gnupg

The only interesting setting is: keep passphrase valid for 10 hours.

### nvim

**neovim** is my main editor. I use a personal configuration written in *Lua*
called **Moonvim**, inspired by both [LunarVim] and [AstroNvim].  
It uses:
+ [packer] as package manager;
+ [alpha] to show a welcome dashboard;
+ [telescope] for fuzzy finding;
+ [mason] to install Language Servers (used with [lspconfig] and [cmp]);
+ [lualine] as default statusline;
+ [treesitter] for better syntax highlighting;

![image-nvim]

### polybar

A panel with customizable modules. Here's how it looks like with my config:

![image-polybar]

### python

With this config file I specified some default imports to have on every new
interactive shell. Most of these are math variables and builtin functions.  
I also disabled the history file.

### redshift

Specified color temperature to use at night and location provider method.

### shell

My default shell is `zsh`. I also keep an old `bash` configuration for
occasional use.  
I am againts the usage of "*oh-my-zsh*" or any other plugin manager for it is
incredibly easy to add new plugins to the shell. The ones I use are:

+ [fast-syntax-highlighting]
+ [zsh-autosuggestions]
+ [zsh-fzf-history-search]
+ [zsh-autopair]

![image-shell]

### tmux

It uses `Ctrl+Space` as *prefix* key. Most of the common keybindings have also
been redefined to fit my preferences.

![image-tmux]

### vim

Minimal `vimrc` configuration for occasional usage of vim instead of nvim.

### vlc

This is only here because I don't like the volume slider going past 100% and I
am too lazy to manually change the limit.

### xfce4

+ xfce4-terminal configuration and theme files.
+ system's keyboard shortcuts.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Author

Marco Plaitano

<!-- LINKS -->

[install.sh]:
install.sh
"Repository file"

[LunarVim]:
https://www.lunarvim.org/

[AstroNvim]:
https://astronvim.com/

[packer]:
https://github.com/wbthomason/packer.nvim

[alpha]:
https://github.com/goolord/alpha-nvim

[telescope]:
https://github.com/nvim-telescope/telescope.nvim

[mason]:
https://github.com/williamboman/mason.nvim

[lspconfig]:
https://github.com/neovim/nvim-lspconfig

[cmp]:
https://github.com/hrsh7th/nvim-cmp

[lualine]:
https://github.com/nvim-lualine/lualine.nvim

[treesitter]:
https://github.com/nvim-treesitter/nvim-treesitter

[image-nvim]:
https://github.com/marcoplaitano/images/blob/main/dotfiles-nvim.png
"nvim demo image"

[image-polybar]:
https://github.com/marcoplaitano/images/blob/main/dotfiles-polybar.png
"polybar demo image"

[fast-syntax-highlighting]:
https://github.com/zdharma-continuum/fast-syntax-highlighting

[zsh-autosuggestions]:
https://github.com/zsh-users/zsh-autosuggestions

[zsh-fzf-history-search]:
https://github.com/joshskidmore/zsh-fzf-history-search

[zsh-autopair]:
https://github.com/hlissner/zsh-autopair

[image-shell]:
https://github.com/marcoplaitano/images/blob/main/dotfiles-shell.png
"shell demo image"

[image-tmux]:
https://github.com/marcoplaitano/images/blob/main/dotfiles-tmux.png
"tmux demo image"
