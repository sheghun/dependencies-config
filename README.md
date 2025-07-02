this is my config for tmux, neovim, and alacritty. clone this repo into `~/.config`.

you need to first of all download anyone of these tools you want to use.

```console
cd projects
nvim .
```

neovim automatically downloads and sets up the dependencies you need. you also need to run `:MasonInstallAll` to install the preconfigured lsps. you can use `:Mason` to find and install other lsps, linters and formatters you might need.


you need to download and set up nerdfonts for your terminal for neovim to work correctly.


#
#
for tmux:

you need to create a symlink to link `~/.tmux.conf` to `~/.config/tmux/.tmux.conf`
