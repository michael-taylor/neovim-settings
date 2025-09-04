# Neovim configuration

## Prerequisites

To install the prerequisite utilities, Scoop can be used on Windows by running
this command:

```powershell
scoop import scoop-pkgs.json
```

On Fedora Linux, the following command will install the prerequisites:

```bash
sudo dnf copr enable dejan/lazygit
sudo dnf install fd fzf lua luarocks nodejs ripgrep lazygit
```

## Installing

To install this Neovim configuration, perform the following step:

* Linux: `git clone https://github.com/michael-taylor/neovim-settings.git ~/.config/nvim`
* Windows: `git clone https://github.com/michael-taylor/neovim-settings.git $env:LOCALAPPDATA/nvim`
