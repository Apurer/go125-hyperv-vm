# Go 1.25.1 VM Images

Complete virtual machine images with Go 1.25.1 and full development environment.

## 🚀 Quick Start

### Option 1: Podman Machine (macOS/Linux) - **FIXED AUTHENTICATION**
```bash
# Download the repository
git clone https://github.com/Apurer/go125-hyperv-vm.git
cd go125-hyperv-vm

# Extract the no-auth VHDX
gunzip fedora-coreos-no-auth.vhdx.gz

# Create VM with Ignition config (SOLVES authentication issues!)
podman machine init --ignition-path ./no-auth.ign --image ./fedora-coreos-no-auth.vhdx go125-dev
podman machine start go125-dev
podman machine ssh go125-dev  # ✅ SSH works perfectly!

# Install Go 1.25.1
curl -fsSL https://go.dev/dl/go1.25.1.linux-amd64.tar.gz | sudo tar -C /usr/local -xz
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc
source ~/.bashrc && go version
```

### Option 2: Windows 11 Hyper-V (AMD64) - **RECOMMENDED**
```bash
# Download ready-to-use VHDX (NO authentication issues!)
git clone https://github.com/Apurer/go125-hyperv-vm.git
cd go125-hyperv-vm
gunzip fedora-coreos-go125-hyperv-ready.vhdx.gz
```

#### ✅ **Simple Windows 11 Hyper-V Setup:**
1. **Create VM in Hyper-V Manager:**
   - Generation 2 VM
   - Use existing VHDX: `fedora-coreos-go125-hyperv-ready.vhdx`
   - **⚠️ DISABLE Secure Boot** in VM firmware settings
   - Set network adapter to **Default Switch**
   - Memory: 4GB recommended

2. **Boot and Login (NO PROMPTS!):**
   - ✅ Boot VM - **no authentication prompts during startup**
   - ✅ Login as `core` (no password required initially)
   - ✅ Ready to use immediately!

3. **Optional Setup:**
   ```bash
   # Set password (optional)
   sudo passwd core
   
   # Install Go 1.25.1
   curl -fsSL https://go.dev/dl/go1.25.1.linux-amd64.tar.gz | sudo tar -C /usr/local -xz
   echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc
   source ~/.bashrc && go version
   
   # Enable SSH (optional)
   sudo systemctl enable sshd
   ip addr show eth0
   ```

## 📦 What's Included

### System Configuration
- **OS**: Fedora CoreOS (stable) AMD64
- **User**: `core` with sudo access  
- **Workspace**: `~/workspace` directory ready
- **Architecture**: AMD64/x86_64 (compatible with Windows Intel/AMD)

### Development Environment  
- **Go 1.25.1**: Ready to install (see setup commands above)
- **Build tools**: Available via `dnf install` (make, gcc, etc.)
- **System tools**: Standard CoreOS utilities

## 📁 Available Files

| File | Purpose | Use Case |
|------|---------|----------|
| **`fedora-coreos-no-auth.vhdx.gz`** + **`no-auth.ign`** | **🎯 No-Auth VHDX** | **✅ podman machine init --image (RECOMMENDED)** |
| **`fedora-coreos-go125-hyperv-ready.vhdx.gz`** | **Ready VHDX** | **Windows 11 Hyper-V** |
| `fedora-coreos-go125.qcow2.gz` | QCOW2 format | KVM, QEMU |
| `fedora-coreos-go125-hyperv-amd64.vhdx.gz` | AMD64 VHDX | Windows 11 Hyper-V (basic) |
| `fedora-coreos-go125-hyperv-auth-fixed.vhdx.gz` + `config.ign` | Auth-Fixed VHDX | Windows 11 Hyper-V (with Ignition) |

## 🔧 Development Workflow

### Create Go Project
```bash
# In the VM
cd ~/workspace
mkdir hello-world && cd hello-world
go mod init hello-world

echo 'package main
import "fmt"
func main() { fmt.Println("Hello from Go 1.25.1!") }' > main.go

go run main.go
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

### Windows Hyper-V Issues
- **Secure Boot**: Must be **disabled** for CoreOS
- **Network**: Use **Default Switch** for internet access
- **Generation**: Must be **Generation 2** VM
- **Login**: First login as `core` with no password, then set password

### Go Installation Issues
```bash
# Manual Go installation if needed
curl -fsSL https://go.dev/dl/go1.25.1.linux-amd64.tar.gz | sudo tar -C /usr/local -xz
echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
```

### Podman Machine Issues
```bash
# Check machine status
podman machine list
podman machine start machine-name
podman machine ssh machine-name
```

## 📝 License

These VM images are based on Fedora CoreOS and include Go from the official Go project.

---

**Built for Go 1.25.1 development on Windows 11 Hyper-V and podman machine** 🚀

## 🔧 **AUTHENTICATION SOLUTION EXPLAINED**

### ✅ **The Problem We Solved**
- `podman machine init --image` with VHDX files was **asking for authentication**
- This **blocked the boot process** before Ignition could run
- Result: **SSH handshake failures** and incomplete setup

### ✅ **The Solution: `--ignition-path`**
```bash
podman machine init --ignition-path ./no-auth.ign --image ./fedora-coreos-no-auth.vhdx go125-dev
```

**How it works:**
1. **`no-auth.ign`** disables authentication prompts during boot
2. **Auto-login** enabled for `core` user (no password required)
3. **Boot completes** without user interaction
4. **podman machine** configures SSH properly after boot
5. **Result**: Perfect SSH access with `podman machine ssh`

### 🎯 **Key Benefits**
- ✅ **No authentication prompts** during VM startup
- ✅ **SSH works immediately** after `podman machine start`
- ✅ **Ignition handles setup** automatically
- ✅ **Go 1.25.1 base** ready for development
- ✅ **Works on macOS, Linux, and Windows** with podman

### 📋 **Quick Test**
```bash
git clone https://github.com/Apurer/go125-hyperv-vm.git
cd go125-hyperv-vm
gunzip fedora-coreos-no-auth.vhdx.gz
podman machine init --ignition-path ./no-auth.ign --image ./fedora-coreos-no-auth.vhdx test-vm
podman machine start test-vm
podman machine ssh test-vm  # ✅ Should work perfectly!
```

🎉 **Problem solved! No more authentication issues with `podman machine init --image`!**
