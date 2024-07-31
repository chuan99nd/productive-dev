# Check nvim installed or not
if ! command -v nvim &> /dev/null
then
    echo "nvim could not be found"
    echo "Installing nvim..."
    # Download and extract nvim
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo rm -rf /opt/nvim
    sudo tar -C /opt -xzf nvim-linux64.tar.gz

    git clone https://github.com/NvChad/starter ~/.config/nvim 
else 
    echo "nvim is already installed"
fi
