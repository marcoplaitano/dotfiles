# DOTFILES

A collection of configuration files for the programs and tools I most commonly
use, and some useful shell scripts.

The purpose of this repository is too keep an online backup - with version
control features - for personal use.  
Some of these files and scripts rely on each other for the declaration and
definition of environment variables, functions and aliases; I can't guarantee
that blindly copying these files or settings on your machine will work as
expected.

![demo-image]

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Install

The [install.sh] script creates a symlink for <s>each</s> most directories of
this repository to a specific location (usually `$XDG_CONFIG_HOME` - i.e.
`~/.config`).  
This allows to reflect any changes to the configuration of one of these programs
directly in this git repository.

```sh
git clone https://github.com/marcoplaitano/dotfiles
cd dotfiles && ./install.sh
```

You can also decide to only install some specific config files:

```sh
./install.sh --list      # list all config files
./install.sh nvim tmux   # only install configuration for these tools
```

See `./install.sh --help` to know more.

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## Author

Marco Plaitano

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

## License

Distributed under the [MIT] license.

<!-- Links -->

[demo-image]:
https://github.com/marcoplaitano/images/blob/main/dotfiles-demo.png
"demo image"

[install.sh]:
install.sh
"Repository file"

[MIT]:
LICENSE
"Repository file"
