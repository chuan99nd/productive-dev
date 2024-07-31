# Prequisire
sudo apt-get install ripgrep -y

## Apply font
SOURCE_DIR="./fonts"
# Define the target directory where the fonts will be installed
# For user-specific fonts, use ~/.fonts; for system-wide fonts, use /usr/share/fonts or /usr/local/share/fonts
TARGET_DIR="$HOME/.local/share/fonts"
# Create the target directory if it doesn't exist
mkdir -p "$TARGET_DIR"
# Copy all .ttf files from the source directory to the target directory
cp "$SOURCE_DIR"/*.ttf "$TARGET_DIR"
# Update the font cache
fc-cache -fv

echo "Fonts installed and cache updated successfully."
