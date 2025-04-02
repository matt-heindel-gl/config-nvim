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

- install [packer](https://github.com/wbthomason/packer.nvim) (plugin manager)

  ```bash
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  ```

### Installing/Updating dependencies

After installing all prerequisites:

1. Navigate to `~/.config/nvim`
1. Start Neovim by running `nvim .`
1. You may see some initial errors - this is normal as plugins aren't installed yet
1. Open the file `lua/configs/packer.lua`
1. Run the command `:so`
1. Run the command `:PackerSync` to install all plugins
1. Wait for installation to complete, then quit Neovim (`:qa`)
1. Start Neovim again and everything should be properly set up

### iTerm2 Key Bindings

To ensure all keybindings work correctly when using iTerm2, you need to configure custom key bindings:

1. Open iTerm2 Preferences (cmd+,)
2. Go to Profiles > Keys
3. Click "Key Bindings"
4. Add these bindings:
   - cmd+p:
     - Keyboard Shortcut: cmd+p
     - Action: Send Hex Code
     - Value: 0x10
   - cmd+s:
     - Keyboard Shortcut: cmd+s
     - Action: Send Hex Code
     - Value: 0x13

This allows these key combinations to be properly forwarded to Neovim instead of being intercepted by iTerm2.
