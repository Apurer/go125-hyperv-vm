# Building Go 1.25.1 VM Images

This document explains how to build the VM images from scratch.

## Prerequisites

- Podman with machine support
- qemu-img tools
- Git LFS
- Sufficient disk space (20GB+)

## Build Process

### 1. Run Build Script
```bash
./create-vm-disk-images.sh
```

### 2. Compress Images
```bash
gzip *.qcow2 *.vhdx *.vmdk *.vdi
```

### 3. Push to GitHub
```bash
./build-and-push.sh
```

## Build Details

The build process:

1. **Downloads** Fedora CoreOS base image
2. **Mounts** and customizes the image
3. **Installs** Go 1.25.1 from official releases
4. **Configures** development environment
5. **Converts** to multiple VM formats
6. **Compresses** for distribution

## Output Files

- `fedora-coreos-go125.qcow2` - For KVM/QEMU/podman machine
- `fedora-coreos-go125-hyperv-fixed.vhdx` - For Windows Hyper-V
- `fedora-coreos-go125.vmdk` - For VMware
- `fedora-coreos-go125.vdi` - For VirtualBox

## Testing

### Test with podman machine
```bash
podman machine init --image ./fedora-coreos-go125.qcow2 test-vm
podman machine start test-vm
podman machine ssh test-vm "go version"
```

### Test VHDX in Hyper-V
1. Import VHDX into Windows Hyper-V
2. Boot VM
3. Verify Go installation

## Customization

To customize the build:

1. Edit `create-vm-disk-images.sh`
2. Modify the VM customization section
3. Add/remove packages as needed
4. Rebuild and test
