# Automatic Theme Switcher

An intelligent theme switching system that automatically adjusts themes for your terminal, shell, and Neovim based on the time of day.

## Features

- **Time-based switching**: Automatically switches between light and dark themes based on configured hours
- **Multi-application support**: 
  - **Ghostty terminal**: Theme switching with custom color palettes
  - **Bash shell**: Dynamic color variables for prompts and scripts
  - **Neovim**: Automatic colorscheme switching (Dracula ↔ Tokyo Night Day)
- **Manual override**: Force light or dark theme regardless of time
- **Cross-platform**: Works on Linux and macOS
- **Easy setup**: One command installation with guided setup

## Quick Start

1. **Install the theme switcher**:
   ```bash
   # Run the setup to create all configuration files
   ./bin/theme-switcher setup
   ```

2. **Enable bash integration** (add to your `.bashrc`):
   ```bash
   source "$HOME/.config/theme-switcher/bashrc-addition"
   ```

3. **Test theme switching**:
   ```bash
   theme-switcher light    # Force light theme
   theme-switcher dark     # Force dark theme  
   theme-switcher auto     # Auto-detect based on time
   theme-switcher status   # Show current status
   ```

4. **Set up automatic switching** (optional):
   ```bash
   .config/theme-switcher/setup-cron.sh install
   ```

## Usage

### Commands

```bash
theme-switcher [COMMAND]
```

**Available commands:**
- `auto` - Switch theme based on time of day (default)
- `light` - Force light theme
- `dark` - Force dark theme
- `status` - Show current theme status
- `setup` - Initialize theme configuration files
- `help` - Show help message

### Configuration

Set these environment variables to customize switching times:

```bash
export THEME_LIGHT_HOUR=7   # Hour to switch to light theme (24h format)
export THEME_DARK_HOUR=19   # Hour to switch to dark theme (24h format)
```

### Examples

```bash
# Auto-switch based on current time
theme-switcher auto

# Force specific themes
theme-switcher light
theme-switcher dark

# Check current status
theme-switcher status
# Output:
# Theme Switcher Status:
#   Current theme: light
#   Current time: 14:30
#   Auto theme: light
#   Light hours: 7:00 - 18:59  
#   Dark hours: 19:00 - 6:59
```

## Application Integration

### Ghostty Terminal

The theme switcher creates custom color palettes for Ghostty:

- **Light theme**: High contrast with dark text on light background
- **Dark theme**: Dracula-inspired colors with good readability

Themes are stored in `~/.config/ghostty/themes/` and automatically applied to your Ghostty configuration.

### Bash Shell

Theme-aware color variables are available in your shell:

```bash
# Available color variables (automatically set based on current theme)
$THEME_PRIMARY     # Main accent color
$THEME_SECONDARY   # Secondary accent color  
$THEME_ACCENT      # Highlight color
$THEME_WARNING     # Warning color
$THEME_ERROR       # Error color
$THEME_TEXT        # Primary text color
$THEME_DIM         # Dimmed text color
$THEME_RESET       # Reset to default
```

Use in your prompts or scripts:
```bash
echo -e "${THEME_PRIMARY}Hello${THEME_RESET} ${THEME_TEXT}World${THEME_RESET}"
```

### Neovim

Automatic colorscheme switching between:
- **Light**: Tokyo Night Day theme
- **Dark**: Dracula theme  

The theme switcher integrates with LazyVim and provides:
- Automatic theme detection on startup
- `:ThemeSwitch [light|dark]` command for manual switching
- Seamless integration with existing Neovim configuration

## Installation Details

### Manual Setup

1. **Copy files to your dotfiles**:
   ```bash
   # The theme switcher files are included in this dotfiles repository
   # When you install dotfiles with 'make install', they'll be symlinked
   ```

2. **Run initial setup**:
   ```bash
   theme-switcher setup
   ```

3. **Update your `.bashrc`**:
   ```bash
   echo 'source "$HOME/.config/theme-switcher/bashrc-addition"' >> ~/.bashrc
   ```

### Automatic Switching

Set up cron jobs for hands-free theme switching:

```bash
# Install cron jobs (switches at 7 AM and 7 PM by default)
.config/theme-switcher/setup-cron.sh install

# Remove cron jobs  
.config/theme-switcher/setup-cron.sh uninstall
```

The cron jobs will:
- Switch to light theme at 7:00 AM
- Switch to dark theme at 7:00 PM
- Check and correct theme every hour

## File Structure

```
.config/
├── ghostty/
│   ├── config                    # Updated with theme support
│   └── themes/
│       ├── light.conf           # Light theme colors
│       └── dark.conf            # Dark theme colors
├── nvim/
│   ├── lua/
│   │   ├── config/
│   │   │   └── theme.lua        # Theme switching logic
│   │   └── plugins/
│   │       └── colorscheme.lua  # Updated with light/dark themes
└── theme-switcher/
    ├── bashrc-addition          # Bash integration
    ├── setup-cron.sh           # Automatic switching setup
    └── current-theme           # Current theme state file

bin/
└── theme-switcher              # Main theme switching script
```

## Customization

### Adding New Applications

To add support for additional applications, modify the `apply_theme()` function in `bin/theme-switcher`:

```bash
apply_theme() {
    local theme="$1"
    
    # ... existing applications ...
    
    # Add your application
    if command -v your_app &>/dev/null; then
        apply_your_app_theme "$theme"
    fi
}
```

### Custom Time Ranges

Set custom switching hours:

```bash
# In your .bashrc or .profile
export THEME_LIGHT_HOUR=6    # 6 AM
export THEME_DARK_HOUR=20    # 8 PM
```

### Custom Themes

Create additional theme files in the themes directories:

```bash
# Create custom Ghostty theme
cat > ~/.config/ghostty/themes/custom.conf << 'EOF'
background = #your_bg_color
foreground = #your_fg_color
# ... more colors
EOF
```

Then modify the theme switcher to use your custom themes.

## Troubleshooting

### Theme not switching in terminal
- Make sure Ghostty is installed and configured
- Check that theme files exist in `~/.config/ghostty/themes/`
- Restart your terminal after initial setup

### Bash colors not working
- Ensure you've sourced the bashrc-addition file
- Check that `theme-switcher` is in your PATH
- Restart your shell: `exec bash`

### Neovim themes not loading
- Make sure you have both Dracula and Tokyo Night themes installed
- Check that the theme.lua file is being loaded by LazyVim
- Run `:ThemeSwitch light` or `:ThemeSwitch dark` manually in Neovim

### Cron jobs not working
- Check cron service is running: `systemctl status cron`
- Verify cron jobs are installed: `crontab -l`
- Check cron logs: `grep theme-switcher /var/log/syslog`

## Requirements

- **Bash 4.0+** for the theme switcher script
- **Ghostty terminal** for terminal theme switching
- **Neovim with LazyVim** for editor theme switching
- **cron** for automatic switching (optional)

## Contributing

To contribute or report issues, please see the main dotfiles repository.

## License

This theme switcher is part of the bdossantos/dotfiles repository and follows the same license terms.