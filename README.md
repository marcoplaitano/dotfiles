# DOTFILES

A collection of configuration files for the programs and tools I most commonly
use.

Feel free to *steal* anything you find to your liking.

![demo-image]

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Install

The [install.sh] script creates a symlink for each directory of this repository
to a specific location (mostly `$XDG_CONFIG_HOME` - i.e. `$HOME/.config`).  
This allows to reflect any changes to the configuration of one of these programs
directly in this git repository.

```sh
git clone https://github.com/marcoplaitano/dotfiles
cd dotfiles && ./install.sh
```

You can also decide to only install some specific config files:

```sh
./install.sh --list         # list all config files
./install.sh i3 nvim tmux   # only install these 3
```

See `./install.sh --help` to know more.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Overview

A brief description of every directory in the repository.

### alacritty

Config file for the [alacritty] terminal. A separate file holds all the available
colorschemes from which to choose.

### autostart

Some `.desktop` files containing programs and scripts to execute on login.

### bat

[bat] is a replacement for the `cat` utility that adds more functionalities.  
My config specifies the color theme and the information to display: line numbers,
git diffs and separator for different files.

### bin

My shell scripts.

### cronjobs

A text copy of my crontab file.

### git

The `config` file contains declarations of aliases, format options, default values...  
The `ignore` file declares files to ignore by default in every repository.  
The `message` file is a template for the commit message.

### gnupg

Configuration for the gpg utility. The only interesting setting is: keep
passphrase valid for 10 hours.

### i3

I often switch between default `xfce4/xfwm4` and [i3] for my window management.  
This configuration file customizes appearance, sets keyboard shortcuts, workspaces
and defines the startup behaviour.

### nvim

[neovim] is my text editor of choice. I use a personal configuration written in
*Lua* called **Moonvim**, inspired by [LunarVim] and [AstroNvim].  
It relies on:
+ [packer] to manage plugins;
+ [alpha] to show a welcome dashboard;
+ [telescope] for fuzzy finding;
+ [mason] to install Language Servers (used with [lspconfig] and [cmp]);
+ [lualine] statusline;
+ [treesitter] for better syntax highlighting.

### picom

When running i3 as window manager, [picom] is the compositor that allows window
transparency and blur.  
The config file defines levels of transparency, blur, animations and effects...

### polybar

A main config file declares all the options for my [polybar] panel.  
A separate file stores all the modules (most rely on my personal scripts) to
choose from.

### python

With this config file I specified some default imports to have on every new
interactive Python shell. Most of these are math variables and builtin functions.
I also disabled the history file.

### redshift

Specified color temperature to use at night and location provider method.

### shell

My default shell is `zsh`. I also keep an old `bash` configuration for
occasional use.  
I am against the usage of "*oh-my-zsh*" or any other plugin manager since it is
incredibly easy to add new plugins to the shell. The ones I use are:

+ [fast-syntax-highlighting]
+ [zsh-autosuggestions]
+ [zsh-fzf-history-search]
+ [zsh-autopair]

### tmux

It uses `Ctrl+Space` as *prefix* key. Most of the common keybindings have also
been redefined to fit my preferences.

### vim

Minimal `vimrc` configuration for occasional usage of vim.

### vlc

This is only here because I don't like the volume slider going past 100% and I
am too lazy to manually change the limit.

### xfce4

+ xfce4-terminal configuration and colorscheme files.
+ system's keyboard shortcuts.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Author

Marco Plaitano

<!-- LINKS -->

[demo-image]:
https://github.com/marcoplaitano/images/blob/main/dotfiles-demo.png
"demo image"

[install.sh]:
install.sh
"Repository file"

[alacritty]:
https://alacritty.org/

[bat]:
https://github.com/sharkdp/bat

[i3]:
https://i3wm.org/

[neovim]:
https://neovim.io/

[picom]:
https://wiki.archlinux.org/title/picom

[polybar]:
https://github.com/polybar/polybar

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

[fast-syntax-highlighting]:
https://github.com/zdharma-continuum/fast-syntax-highlighting

[zsh-autosuggestions]:
https://github.com/zsh-users/zsh-autosuggestions

[zsh-fzf-history-search]:
https://github.com/joshskidmore/zsh-fzf-history-search

[zsh-autopair]:
https://github.com/hlissner/zsh-autopair
