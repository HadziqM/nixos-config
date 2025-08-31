#!/usr/bin/env bash

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration variables
NIX_CONF_PATH="/etc/nix/nix.conf"
BACKUP_PATH="/etc/nix/nix.conf.backup.$(date +%Y%m%d-%H%M%S)"
USERNAME="${USER:-$(whoami)}"

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root for system-wide config
check_permissions() {
    if [[ $EUID -eq 0 ]]; then
        print_status "Running as root - will configure system-wide nix.conf"
    else
        print_error "This script needs to be run with sudo to modify /etc/nix/nix.conf"
        echo "Usage: sudo $0"
        exit 1
    fi
}

# Create nix directory if it doesn't exist
ensure_nix_dir() {
    if [[ ! -d "/etc/nix" ]]; then
        print_status "Creating /etc/nix directory"
        mkdir -p /etc/nix
    fi
}

# Backup existing config
backup_existing_config() {
    if [[ -f "$NIX_CONF_PATH" ]]; then
        print_status "Backing up existing config to $BACKUP_PATH"
        cp "$NIX_CONF_PATH" "$BACKUP_PATH"
    fi
}

# Generate nix.conf content
generate_nix_conf() {
    cat > "$NIX_CONF_PATH" << EOF
# Nix Configuration
# Generated on $(date)

# Enable experimental features
experimental-features = nix-command flakes

# Trusted users (can use --impure, binary caches, etc.)
trusted-users = root $ACTUAL_USER @wheel

# Substituters (binary caches)
substituters = https://cache.nixos.org/ https://nix-community.cachix.org

# Trusted public keys for binary caches
trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=

# Build settings
max-jobs = auto
cores = 0
sandbox = true

# Storage optimization
auto-optimise-store = true
keep-outputs = true
keep-derivations = true

# Build users group
build-users-group = nixbld

# Additional settings
warn-dirty = false
allow-import-from-derivation = true
EOF
}

# Restart nix daemon
restart_nix_daemon() {
    print_status "Restarting Nix daemon..."
    
    if command -v systemctl >/dev/null 2>&1; then
        if systemctl is-active --quiet nix-daemon; then
            systemctl restart nix-daemon
            print_status "Nix daemon restarted successfully"
        else
            print_warning "Nix daemon is not running, attempting to start..."
            systemctl start nix-daemon
        fi
    elif command -v service >/dev/null 2>&1; then
        service nix-daemon restart
        print_status "Nix daemon restarted successfully"
    else
        print_warning "Could not restart Nix daemon - no systemctl or service command found"
        print_warning "You may need to restart it manually"
    fi
}

# Validate configuration
validate_config() {
    print_status "Validating Nix configuration..."
    
    if nix show-config >/dev/null 2>&1; then
        print_status "Configuration is valid!"
        
        # Show some key settings
        echo ""
        echo "Key configuration values:"
        echo "  Experimental features: $(nix show-config | grep experimental-features | cut -d'=' -f2 | xargs)"
        echo "  Trusted users: $(nix show-config | grep trusted-users | cut -d'=' -f2 | xargs)"
        echo "  Max jobs: $(nix show-config | grep max-jobs | cut -d'=' -f2 | xargs)"
    else
        print_error "Configuration validation failed!"
        print_error "Check the generated config at $NIX_CONF_PATH"
        return 1
    fi
}

# Main function
main() {
    print_status "Starting Nix configuration setup..."
    
    # Get the actual user (in case of sudo)
    if [[ -n "${SUDO_USER:-}" ]]; then
        ACTUAL_USER="$SUDO_USER"
    else
        ACTUAL_USER="$USERNAME"
    fi
    
    print_status "Configuring for user: $ACTUAL_USER"
    
    check_permissions
    ensure_nix_dir
    backup_existing_config
    generate_nix_conf
    
    print_status "Generated new nix.conf at $NIX_CONF_PATH"
    
    restart_nix_daemon
    
    # Small delay to let daemon start
    sleep 2
    
    if validate_config; then
        print_status "✅ Nix configuration applied successfully!"
        echo ""
        echo "You can now use 'nix' commands with flakes support."
        echo "Try: nix shell nixpkgs#hello"
    else
        print_error "❌ Configuration validation failed"
        if [[ -f "$BACKUP_PATH" ]]; then
            print_status "Restoring backup..."
            cp "$BACKUP_PATH" "$NIX_CONF_PATH"
            restart_nix_daemon
        fi
        exit 1
    fi
}

# Help function
show_help() {
    echo "Usage: sudo $0 [OPTIONS]"
    echo ""
    echo "Generate and apply a Nix configuration file."
    echo ""
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo ""
    echo "This script will:"
    echo "  1. Backup existing /etc/nix/nix.conf"
    echo "  2. Generate a new configuration"
    echo "  3. Restart the Nix daemon"
    echo "  4. Validate the configuration"
}

# Parse arguments
case "${1:-}" in
    -h|--help)
        show_help
        exit 0
        ;;
    "")
        main
        ;;
    *)
        print_error "Unknown option: $1"
        show_help
        exit 1
        ;;
esac
