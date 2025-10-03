# Go 1.25.1 VM Images

Complete virtual machine images with Go 1.25.1 and full development environment.

## 🚀 Quick Start

### Option 1: Podman Machine (Recommended)
```bash
# Download qcow2 image
curl -L -o go125.qcow2.gz https://github.com/Apurer/go125-vm-images/releases/download/v1.1.0/fedora-coreos-go125.qcow2.gz
gunzip go125.qcow2.gz

# Create and start VM
podman machine init --image ./go125.qcow2 go125-dev
podman machine start go125-dev
podman machine ssh go125-dev

# Inside VM
source /etc/profile.d/go125.sh
go version  # Shows: go version go1.25.1 linux/amd64
```

### Option 2: Windows 11 Hyper-V
```bash
# Download VHDX image
curl -L -o go125-hyperv.vhdx.gz https://github.com/Apurer/go125-vm-images/releases/download/v1.1.0/fedora-coreos-go125-hyperv-fixed.vhdx.gz
gunzip go125-hyperv.vhdx.gz

# Import into Hyper-V
1. Create new VM (Generation 2)
2. Use existing VHDX: go125-hyperv.vhdx
3. Disable Secure Boot
4. Set network to Default Switch
5. Start VM
```

## 📦 What's Included

### Go Development Environment
- **Go 1.25.1** installed at `/usr/local/go`
- **GOPATH** configured at `$HOME/go`
- **PATH** includes Go binaries

### Development Tools
- **Build tools**: make, gcc, gcc-c++
- **Version control**: git
- **Editors**: vim
- **System tools**: htop, tmux, tree
- **Network tools**: curl, wget

### System Configuration
- **OS**: Fedora CoreOS (stable)
- **User**: `core` with sudo access
- **SSH**: Configured automatically by podman machine
- **Workspace**: `~/workspace` directory ready

## 📁 Available Formats

| Format | Use Case | File |
|--------|----------|------|
| **QCOW2** | KVM, QEMU, **podman machine** | `fedora-coreos-go125.qcow2.gz` |
| **VHDX** | **Windows 11 Hyper-V** | `fedora-coreos-go125-hyperv-fixed.vhdx.gz` |
| **VMDK** | VMware | `fedora-coreos-go125.vmdk.gz` |
| **VDI** | VirtualBox | `fedora-coreos-go125.vdi.gz` |

## 🔧 Usage Examples

### Test Go Installation
```bash
podman machine ssh go125-dev
source /etc/profile.d/go125.sh
go version
go env
```

### Create Go Project
```bash
cd ~/workspace
mkdir hello-world
cd hello-world
go mod init hello-world
echo 'package main

import "fmt"

func main() {
    fmt.Println("Hello from Go 1.25.1!")
}' > main.go
go run main.go
```

### Build and Run
```bash
go build
./hello-world
```

## 🛠️ VM Specifications

- **CPU**: Multi-core support
- **Memory**: 2GB+ recommended
- **Disk**: 10GB allocated, ~2GB used
- **Network**: DHCP configured
- **Architecture**: AMD64/x86_64

## 📋 Troubleshooting

### Podman Machine Issues
```bash
# Check machine status
podman machine list

# Restart machine
podman machine stop go125-dev
podman machine start go125-dev

# SSH connection
podman machine ssh go125-dev
```

### Hyper-V Issues
- Ensure **Hyper-V** is enabled in Windows features
- Use **Generation 2** VMs
- **Disable Secure Boot** in VM firmware settings
- Configure **network adapter** (Default Switch recommended)

## 🔄 Updates

This repository contains VM images with Go 1.25.1. For newer versions:
1. Check [releases](https://github.com/Apurer/go125-vm-images/releases)
2. Download updated images
3. Create new podman machine or import new VHDX

## 📝 License

These VM images are based on Fedora CoreOS and include Go from the official Go project.
See individual project licenses for details.

## 🤝 Contributing

Issues and pull requests welcome! 

To rebuild images:
1. Clone repository
2. Run `./build-and-push.sh`
3. Create pull request

---

**Built with ❤️ for Go development**
