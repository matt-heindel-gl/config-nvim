## Neovim Configs

Loosely based on [ThePrimeagen's init.lua](https://github.com/ThePrimeagen/init.lua)

### Getting Started

- install [ripgrep](https://github.com/BurntSushi/ripgrep)

  ```bash
  brew install ripgrep
  ```

- install icons and fonts

  ```bash
  brew tap homebrew/cask-fonts && brew install font-hack-nerd-font
  ```

- clone this repo into `~/.config/nvim/`

  ```bash
  gh repo clone matt-heindel-gl/config-nvim  ~/.config/nvim/
  ```

### Updating dependencies

Plug-ins are managed by [packer](https://github.com/wbthomason/packer.nvim) in `lua/configs/packer.lua`. To perform an update, 

- navigate to your config folder

  ```bash
  cd ~/.config/nvim
  ```

- open neovim with `nvim .`
- open the file `lua/configs/packer.lua`
- execute the command `:so`, then `:PackerSync`.
