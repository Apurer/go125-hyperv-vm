# Go 1.25.1 Development VM for Windows 11 Hyper-V

[![Download VM](https://img.shields.io/badge/Download-VM%20Images-blue)](https://github.com/YOUR_USERNAME/YOUR_REPO/releases)
[![Go Version](https://img.shields.io/badge/Go-1.25.1-00ADD8)](https://golang.org/)
[![OS](https://img.shields.io/badge/OS-Fedora%20CoreOS-294172)](https://getfedora.org/coreos/)

## 🚀 Complete Development Environment

Ready-to-use virtual machine with **Go 1.25.1** and **all development tools** for Windows 11 Hyper-V.

### 📦 VM Image Files (GitHub LFS)

| File | Size | Description |
|------|------|-------------|
| `fedora-coreos-go125-hyperv-fixed.vhdx.gz` | ~1.1GB | **Recommended** - Better performance |
| `fedora-coreos-go125-hyperv-dynamic.vhdx.gz` | ~1.1GB | Space efficient |

### ✅ What's Included

#### Go Development
- **Go 1.25.1** (latest AMD64)
- Pre-configured environment (GOROOT, GOPATH, PATH)
- Sample code and comprehensive Makefile

#### Development Tools
- **Make 4.4.1** - Build automation
- **GCC 15.2.1** - C/C++ compiler suite  
- **Git 2.51.0** - Version control
- **Python 3.13.7** + pip
- **Node.js 22.19.0** + npm

#### Editors & Utilities
- **vim, nano** - Text editors
- **tmux, screen** - Terminal multiplexers
- **htop** - System monitoring
- **tree** - Directory visualization  
- **curl, wget** - Network utilities
- **rsync** - File synchronization
- **tar, gzip** - Archive tools
- **bash-completion** - Shell enhancements

## 🖥️ Installation Guide

### Prerequisites
- Windows 11 with Hyper-V enabled
- 4GB+ RAM available for VM
- ~15GB free disk space

### Download Options

#### Option 1: Git LFS (Current Repository)
```bash
# Clone with LFS support
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO

# LFS files are downloaded automatically
ls -la *.vhdx.gz
```

#### Option 2: Direct Download
Download individual files:
- [Fixed VHDX (Recommended)](./fedora-coreos-go125-hyperv-fixed.vhdx.gz)
- [Dynamic VHDX](./fedora-coreos-go125-hyperv-dynamic.vhdx.gz)
- [Setup Script](./setup-complete-dev-environment.sh)

### Hyper-V Setup

1. **Decompress VM image**:
   ```bash
   gunzip fedora-coreos-go125-hyperv-fixed.vhdx.gz
   ```

2. **Create Hyper-V VM**:
   - Open **Hyper-V Manager** as Administrator
   - **New Virtual Machine**
   - **Generation 2** (UEFI) - **Required!**
   - Memory: 4-8GB recommended
   - **Use existing virtual hard disk** → Browse to `.vhdx` file
   - **Settings → Security → Disable Secure Boot**

3. **First Boot**:
   ```bash
   # Login as 'core' user (no password)
   ./setup-complete-dev-environment.sh
   
   # Reboot to activate all tools
   sudo systemctl reboot
   ```

## 🔧 Usage

### Immediate (Go ready)
```bash
cd ~/workspace
go version                    # Go 1.25.1
go run hello-complete.go      # Test program
```

### After Reboot (All tools)  
```bash
make tools-check             # Verify all tools
gcc --version               # C/C++ development
git --version               # Version control
python3 --version           # Python development
node --version              # JavaScript development
```

### Development Workflow
```bash
# Create new Go project
mkdir ~/workspace/myapp && cd ~/workspace/myapp
go mod init myapp

# Create main.go
cat > main.go << 'MAIN'
package main
import "fmt"
func main() {
    fmt.Println("Hello from Hyper-V Go development!")
}
MAIN

# Build and run
go run main.go
go build -o myapp
```

## 🛠️ Useful Aliases

Pre-configured shortcuts:
- `gv` → `go version`
- `gb` → `go build`  
- `gr` → `go run`
- `gt` → `go test`
- `mk` → `make`
- `v` → `vim`
- `h` → `htop`
- `t` → `tmux`
- `ll` → `ls -la --color=auto`

## 🌐 Networking

Enable SSH for easier development:
```bash
sudo passwd core        # Set password
ip addr show           # Get VM IP
# From Windows: ssh core@<vm-ip>
```

## 📋 Technical Details

- **OS**: Fedora CoreOS (Immutable Linux)
- **Architecture**: AMD64/x86_64  
- **Format**: VHDX (Hyper-V Generation 2)
- **User**: core (passwordless sudo)
- **Persistence**: User data in `/home` and `/var`

## 🆘 Troubleshooting

### VM Won't Boot
- Ensure **Generation 2** VM
- **Disable Secure Boot** in VM settings
- Check UEFI boot order

### Tools Not Available
- Run setup script: `./setup-complete-dev-environment.sh`
- Reboot after setup: `sudo systemctl reboot`
- Tools are layered with rpm-ostree

### Performance Issues  
- Use **fixed VHDX** (not dynamic)
- Allocate more RAM (8GB recommended)
- Enable Hyper-V Integration Services

## 🤝 Contributing

Issues and improvements welcome! This VM provides a complete Go 1.25.1 development environment for Windows 11.

---

**Ready for Go 1.25.1 development on Windows 11 Hyper-V!** 🚀
