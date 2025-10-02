# Go 1.25.1 Development VM for Windows 11 Hyper-V

## VM Image Files

### Download Options
- **fedora-coreos-go125-hyperv-fixed.vhdx.gz** (Recommended) - Better performance, ~3-4GB compressed
- **fedora-coreos-go125-hyperv-dynamic.vhdx.gz** - Space efficient, ~2GB compressed

### What's Included
✅ **Go 1.25.1** (latest version)  
✅ **Make 4.4.1** - Build automation  
✅ **GCC 15.2.1** - C/C++ compiler suite  
✅ **Git 2.51.0** - Version control  
✅ **Python 3.13.7** + pip  
✅ **Node.js 22.19.0** + npm  
✅ **Development tools**: vim, nano, tmux, screen, htop, tree  
✅ **Utilities**: curl, wget, rsync, tar, gzip, which, file, findutils  
✅ **Shell enhancements**: bash-completion  

### Installation Instructions

1. **Download** the VHDX file and decompress:
   ```bash
   gunzip fedora-coreos-go125-hyperv-fixed.vhdx.gz
   ```

2. **Hyper-V Setup**:
   - Open Hyper-V Manager as Administrator
   - Create New Virtual Machine
   - **Generation 2** (UEFI) - REQUIRED
   - Memory: 4-8GB recommended
   - Use existing virtual hard disk → Browse to .vhdx file
   - **Settings → Security → Disable Secure Boot**

3. **First Boot**:
   ```bash
   # Login as 'core' user (no password)
   ./setup-complete-dev-environment.sh
   sudo systemctl reboot
   # After reboot: all tools ready!
   ```

### Usage
```bash
cd ~/workspace
go version                    # Go 1.25.1
make run                     # Test complete environment
make tools-check             # Verify all tools
```

### Architecture
- **OS**: Fedora CoreOS (Immutable Linux)
- **Architecture**: AMD64/x86_64
- **Format**: VHDX (Hyper-V Generation 2)
- **User**: core (passwordless sudo)

### Requirements
- Windows 11 with Hyper-V enabled
- 4GB+ RAM available for VM
- ~15GB disk space

**Ready for immediate Go 1.25.1 development on Windows 11!**
