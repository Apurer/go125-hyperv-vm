# GitHub Actions for VM Distribution

## Automated Workflows

### 1. Tag-Based Release (`build-vm-artifacts.yml`)

**Triggers**: When you create a git tag
```bash
git tag v1.0.0
git push origin v1.0.0
```

**What it does**:
- ✅ Pulls LFS files (VM images)
- ✅ Creates checksums for verification  
- ✅ Uploads as artifacts (90-day retention)
- ✅ Creates GitHub release with files attached
- ✅ Verifies all files

### 2. Manual Build (`manual-vm-build.yml`)

**Triggers**: Manual workflow dispatch from GitHub web interface

**Options**:
- **VM Type**: fixed, dynamic, or both
- **Create Release**: Option to create GitHub release

**Usage**:
1. Go to repository → Actions tab
2. Select "Manual VM Build"  
3. Click "Run workflow"
4. Choose options and run

## Benefits of This Approach

### ✅ GitHub LFS + Actions
- **Large files** handled properly by LFS
- **Automated releases** on tags  
- **Artifact storage** with retention
- **Checksum verification** for integrity
- **No size limits** (within LFS quotas)

### ✅ Multiple Distribution Methods
1. **Git clone** - Gets everything including LFS files
2. **GitHub Releases** - Direct download of VM files
3. **Actions Artifacts** - Temporary builds and testing

## File Organization

```
repository/
├── .github/workflows/
│   ├── build-vm-artifacts.yml      # Tag-based releases
│   └── manual-vm-build.yml         # Manual builds
├── .gitattributes                  # LFS file tracking
├── .gitignore                      # Git ignore rules
├── README.md                       # Main documentation
├── setup-complete-dev-environment.sh  # VM setup script
├── README-HYPERV-VM.md            # VM-specific docs
├── RELEASE-NOTES.md               # Release information
├── fedora-coreos-go125-hyperv-fixed.vhdx.gz    # VM image (LFS)
└── fedora-coreos-go125-hyperv-dynamic.vhdx.gz  # VM image (LFS)
```

## Usage for End Users

### Option 1: Full Repository Clone
```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
# LFS files downloaded automatically
gunzip *.vhdx.gz
# Import VHDX into Hyper-V
```

### Option 2: Release Download
1. Go to repository Releases page
2. Download `fedora-coreos-go125-hyperv-fixed.vhdx.gz`  
3. Download `setup-complete-dev-environment.sh`
4. Decompress and import into Hyper-V

### Option 3: Actions Artifacts (Temporary)
- For testing and CI/CD workflows
- 90-day retention
- Access via Actions tab

## Commands to Set Up

```bash
# Create and push repository
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git push -u origin main

# Create first release
git tag v1.0.0
git push origin v1.0.0
# This triggers automatic release creation!
```

This gives you professional VM distribution with proper large file handling! 🚀
