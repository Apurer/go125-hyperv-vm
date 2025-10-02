# Complete Development VM for Windows 11 Hyper-V

This VM includes **Go 1.25.1** and **ALL development tools** you requested.

## What's Included

### Go Development
- **Go 1.25.1** (latest version)
- Pre-configured GOROOT, GOPATH, and PATH
- Sample Go code and Makefile

### Development Tools  
- **Make 4.4.1** - Build automation
- **GCC 15.2.1** - C/C++ compiler suite
- **Git 2.51.0** - Version control
- **Python 3.13.7** + pip
- **Node.js 22.19.0** + npm

### Editors & Utilities
- **vim, nano** - Text editors
- **tmux, screen** - Terminal multiplexers  
- **htop** - System monitor
- **tree** - Directory visualization
- **curl, wget** - Network utilities
- **rsync** - File sync
- **tar, gzip** - Archive tools
- **bash-completion** - Shell enhancements

## Windows 11 Hyper-V Setup

### VM Files
- `fedora-coreos-go125-hyperv-dynamic.vhdx` - Smaller file (recommended for storage)
- `fedora-coreos-go125-hyperv-fixed.vhdx` - Better performance (recommended for use)

### Hyper-V Configuration
1. **Copy VHDX** to your Windows system (e.g., C:\VMs\)
2. **Open Hyper-V Manager** as Administrator
3. **Create New VM**:
   - Name: Go-Development-VM
   - **Generation: 2** (UEFI - REQUIRED!)
   - Memory: 4GB minimum, 8GB recommended
   - Network: Default Switch
   - **Use existing virtual hard disk** → Browse to .vhdx file
4. **Before first boot**: VM Settings → Security → **Disable Secure Boot**
5. **Start VM**

## First Boot Setup

```bash
# Login as 'core' user (no password)

# Run the complete setup script
./setup-complete-dev-environment.sh

# Reboot to activate all tools
sudo systemctl reboot

# After reboot, test everything
cd ~/workspace
make run
make tools-check
```

## Development Workflow

### Immediate (Go 1.25.1 ready)
```bash
cd ~/workspace
go version                    # ✅ Works immediately
go run hello-complete.go      # ✅ Works immediately  
```

### After Reboot (All tools ready)
```bash
make tools-check             # Check all tools
gcc --version               # C/C++ compilation
git --version               # Version control
python3 --version           # Python development
node --version              # JavaScript development
```

### Aliases Available
- `gv` → `go version`
- `gb` → `go build`
- `gr` → `go run`  
- `gt` → `go test`
- `mk` → `make`
- `v` → `vim`
- `h` → `htop`
- `t` → `tmux`
- `ll` → `ls -la --color=auto`

## Why Two Steps?

1. **Go 1.25.1** installs immediately (binary installation)
2. **Development tools** use rpm-ostree layering (requires reboot)

This gives you Go development capability instantly, with full toolchain after reboot.

## Network & SSH

To enable SSH for easier development:
```bash
sudo passwd core        # Set password
ip addr show           # Get VM IP
# From Windows: ssh core@<vm-ip>
```

## Persistence

- **Go 1.25.1**: ✅ Persistent across reboots
- **Development tools**: ✅ Persistent (after initial reboot)
- **User data**: ✅ ~/workspace and /home are persistent
- **System packages**: ✅ Layered with rpm-ostree

Happy Go development on Windows 11! 🚀
