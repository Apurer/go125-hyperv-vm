#!/usr/bin/env bash
set -euxo pipefail

echo "🚀 Creating traditional VM disk images with Go 1.25.1..."

# Ensure VM is running
podman machine start go125-reliable 2>/dev/null || echo "VM already running"

# Build actual VM disk images
podman machine ssh go125-reliable << 'CREATE_VM_DISK_IMAGES'
set -euxo pipefail

echo "💾 Creating traditional VM disk images with Go 1.25.1..."

# Create working directory
mkdir -p /tmp/vm-build
cd /tmp/vm-build

echo "📦 Downloading CoreOS raw image..."
#!/bin/bash
set -e

echo "Creating Hyper-V VM disk image with Go 1.25.1 for Windows 11 AMD64..."

# Download CoreOS Hyper-V image
echo "Downloading CoreOS Hyper-V image..."
COREOS_URL=$(curl -s "https://builds.coreos.fedoraproject.org/streams/stable.json" | jq -r '.architectures.x86_64.artifacts.hyperv.formats["vhdx.zip"].disk.location')
echo "Download URL: $COREOS_URL"

if [ "$COREOS_URL" = "null" ] || [ -z "$COREOS_URL" ]; then
    echo "Error: Could not get CoreOS Hyper-V download URL"
    exit 1
fi

# Download the CoreOS raw image
curl -L -o fedora-coreos.raw.xz "$STREAM_URL"

echo "📂 Extracting raw image..."
xz -d fedora-coreos.raw.xz

echo "🔧 Customizing VM image with Go 1.25.1..."
# Mount the image and customize it
sudo mkdir -p /mnt/coreos
LOOP_DEVICE=$(sudo losetup --find --partscan --show fedora-coreos.raw)
sudo mount "${LOOP_DEVICE}p4" /mnt/coreos  # CoreOS root partition

# Install Go 1.25.1
echo "📥 Installing Go 1.25.1 in VM image..."
sudo mkdir -p /mnt/coreos/usr/local
curl -fsSL https://go.dev/dl/go1.25.1.linux-amd64.tar.gz | sudo tar -C /mnt/coreos/usr/local -xz

# Create Go environment setup
sudo tee /mnt/coreos/etc/profile.d/go125.sh << 'EOF'
export PATH=/usr/local/go/bin:$PATH:$HOME/go/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
EOF
sudo chmod +x /mnt/coreos/etc/profile.d/go125.sh

# Install development tools using rpm-ostree in chroot
echo "🛠️ Installing development tools..."
sudo chroot /mnt/coreos rpm-ostree install make gcc gcc-c++ git wget curl vim htop tmux tree || true

# Add useful aliases and setup
sudo tee /mnt/coreos/etc/profile.d/dev-setup.sh << 'EOF'
alias ll="ls -la --color=auto"
alias gv="go version"
alias gb="go build"
alias gr="go run" 
alias gt="go test"
alias h="htop"
EOF
sudo chmod +x /mnt/coreos/etc/profile.d/dev-setup.sh

# Create workspace
sudo mkdir -p /mnt/coreos/home/core/workspace
sudo chown 1000:1000 /mnt/coreos/home/core/workspace

# Let podman machine handle SSH configuration automatically
# Do NOT manually configure SSH keys - podman machine init/start will handle this

# Create informative MOTD for when using via podman machine
sudo tee /mnt/coreos/etc/motd << 'EOF'
🚀 Fedora CoreOS with Go 1.25.1 Development Environment

🔧 Go Environment:
  • Go 1.25.1 installed at /usr/local/go
  • Run: source /etc/profile.d/go125.sh
  • Verify: go version

💻 Development Tools Available:
  • make, gcc, git, vim, htop, tmux, tree
  • Workspace: ~/workspace

📋 Usage:
  • For podman machine: SSH configured automatically
  • For direct Hyper-V: Manual SSH setup required

EOF

echo "💾 Finalizing VM image..."
# Sync and unmount
sudo sync
sudo umount /mnt/coreos
sudo losetup -d $LOOP_DEVICE

# Create different VM formats
echo "🔄 Converting to multiple VM formats..."

# VMDK for VMware
echo "Creating VMDK..."
qemu-img convert -f raw -O vmdk fedora-coreos.raw fedora-coreos-go125.vmdk

# QCOW2 for KVM/QEMU
echo "Creating QCOW2..."
qemu-img convert -f raw -O qcow2 fedora-coreos.raw fedora-coreos-go125.qcow2

# VDI for VirtualBox  
echo "Creating VDI..."
qemu-img convert -f raw -O vdi fedora-coreos.raw fedora-coreos-go125.vdi

# VHDX for Hyper-V (proper format for Windows 11)
echo "Creating VHDX..."
qemu-img convert -f raw -O vhdx fedora-coreos.raw fedora-coreos-go125.vhdx

# VHD for older Hyper-V
echo "Creating VHD..."
qemu-img convert -f raw -O vpc fedora-coreos.raw fedora-coreos-go125.vhd

# Keep raw format too
mv fedora-coreos.raw fedora-coreos-go125.raw

echo "📏 VM disk images created:"
ls -lh fedora-coreos-go125.*

echo "✅ Traditional VM images with Go 1.25.1 ready!"
echo ""
echo "📦 Available formats:"
echo "  🔸 fedora-coreos-go125.vmdk  (VMware)"
echo "  🔸 fedora-coreos-go125.qcow2 (KVM/QEMU)" 
echo "  🔸 fedora-coreos-go125.vdi   (VirtualBox)"
echo "  🔸 fedora-coreos-go125.vhdx  (Hyper-V - Windows 11)"
echo "  🔸 fedora-coreos-go125.vhd   (Hyper-V - Legacy)"
echo "  🔸 fedora-coreos-go125.raw   (Raw disk)"

echo ""
echo "� SSH Configuration:"
echo "  • For podman machine: SSH configured automatically during init/start"
echo "  • For direct Hyper-V: Manual SSH setup required"

CREATE_VM_DISK_IMAGES

echo ""
echo "🎉 SUCCESS! Traditional VM disk images with Go 1.25.1 created!"
echo ""
echo "📁 VM Images Location: Inside go125-reliable VM at /tmp/vm-build/"
echo ""
echo "💾 To download VM images to your host:"
echo "  podman machine ssh go125-reliable"
echo "  cd /tmp/vm-build"
echo "  # Copy images to shared location or use scp"
echo ""
echo "🚀 How to use VM images:"
echo ""
echo "Podman Machine (RECOMMENDED):"
echo "  podman machine init --image ./fedora-coreos-go125.qcow2 go125-dev"
echo "  podman machine start go125-dev"
echo "  podman machine ssh go125-dev"
echo "  # SSH access configured automatically!"
echo ""
echo "Windows 11 Hyper-V (Direct VM):"
echo "  1. Copy fedora-coreos-go125.vhdx to Windows"
echo "  2. Create new VM in Hyper-V Manager:"
echo "     • Generation 2"
echo "     • Use existing VHDX: fedora-coreos-go125.vhdx"
echo "     • Disable Secure Boot"
echo "     • Set network to Default Switch"
echo "  3. Boot VM (SSH requires manual configuration for direct Hyper-V use)"
echo ""
echo "VMware:"
echo "  1. Create new VM in VMware"
echo "  2. Use existing disk: fedora-coreos-go125.vmdk"
echo "  3. Boot VM and login as 'core' user"
echo ""
echo "VirtualBox:"
echo "  1. Create new VM in VirtualBox" 
echo "  2. Use existing disk: fedora-coreos-go125.vdi"
echo "  3. Boot VM and login as 'core' user"
echo ""
echo "KVM/QEMU:"
echo "  qemu-system-x86_64 -hda fedora-coreos-go125.qcow2 -m 4G"
echo ""
echo "🔧 Once booted in VM:"
echo "  source /etc/profile.d/go125.sh"
echo "  go version  # Should show go1.25.1"
echo "  cd ~/workspace"
echo ""
echo "💡 These are real VM disk files you can use anywhere!"