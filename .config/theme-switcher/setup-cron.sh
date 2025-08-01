#!/usr/bin/env bash

# =============================================================================
# Cron Setup for Automatic Theme Switching
# =============================================================================
# This script sets up cron jobs to automatically switch themes based on time
#
# Usage: ./setup-cron.sh [install|uninstall]
# =============================================================================

set -euo pipefail

SCRIPT_DIR=""
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
readonly THEME_SWITCHER="${SCRIPT_DIR}/../../bin/theme-switcher"

# Colors for output
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly RED='\033[0;31m'
readonly NC='\033[0m'

log_info() {
    echo -e "${YELLOW}[INFO]${NC} $*" >&2
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $*" >&2
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

install_cron() {
    log_info "Setting up automatic theme switching with cron..."
    
    # Get current crontab, excluding our theme switcher entries
    local temp_crontab
    temp_crontab=$(mktemp)
    
    (crontab -l 2>/dev/null || true) | grep -v "theme-switcher" > "$temp_crontab"
    
    # Add our cron entries
    cat >> "$temp_crontab" << EOF
# Automatic theme switching (managed by theme-switcher)
# Switch to light theme at 7:00 AM every day
0 7 * * * ${THEME_SWITCHER} light >/dev/null 2>&1
# Switch to dark theme at 7:00 PM every day  
0 19 * * * ${THEME_SWITCHER} dark >/dev/null 2>&1
# Check and auto-adjust theme every hour
0 * * * * ${THEME_SWITCHER} auto >/dev/null 2>&1
EOF
    
    # Install the new crontab
    crontab "$temp_crontab"
    rm "$temp_crontab"
    
    log_success "Cron jobs installed for automatic theme switching"
    log_info "Themes will switch at 7:00 AM (light) and 7:00 PM (dark)"
    log_info "Run 'crontab -l' to see the installed cron jobs"
}

uninstall_cron() {
    log_info "Removing automatic theme switching cron jobs..."
    
    local temp_crontab
    temp_crontab=$(mktemp)
    
    # Get current crontab without our entries
    (crontab -l 2>/dev/null || true) | grep -v "theme-switcher" > "$temp_crontab"
    
    # Install the cleaned crontab
    if [[ -s "$temp_crontab" ]]; then
        crontab "$temp_crontab"
    else
        crontab -r 2>/dev/null || true  # Remove empty crontab
    fi
    
    rm "$temp_crontab"
    
    log_success "Theme switching cron jobs removed"
}

show_help() {
    cat << EOF
Cron Setup for Automatic Theme Switching

USAGE:
    setup-cron.sh [COMMAND]

COMMANDS:
    install     Install cron jobs for automatic theme switching
    uninstall   Remove theme switching cron jobs
    help        Show this help message

DESCRIPTION:
    This script manages cron jobs that automatically switch themes:
    - Light theme at 7:00 AM daily
    - Dark theme at 7:00 PM daily  
    - Hourly check to ensure correct theme

EXAMPLES:
    ./setup-cron.sh install     # Install cron jobs
    ./setup-cron.sh uninstall   # Remove cron jobs
EOF
}

main() {
    local command="${1:-help}"
    
    # Check if theme-switcher exists
    if [[ ! -x "$THEME_SWITCHER" ]]; then
        log_error "theme-switcher not found at $THEME_SWITCHER"
        exit 1
    fi
    
    case "$command" in
        "install")
            install_cron
            ;;
        "uninstall")
            uninstall_cron
            ;;
        "help")
            show_help
            ;;
        *)
            log_error "Unknown command: $command"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi