#!/bin/bash
set -e

echo "🚀 Setting up COMPLETE development environment with Go 1.25.1 + ALL tools..."
echo "This will install:"
echo "  ✅ Go 1.25.1 (latest)"
echo "  ✅ Make, GCC, Git"  
echo "  ✅ Vim, Tmux, Htop, Tree"
echo "  ✅ Curl, Wget, Python, Node.js"
echo "  ✅ All development utilities"
echo ""

# Install Go 1.25.1
echo "📥 Installing Go 1.25.1..."
sudo mkdir -p /usr/local
curl -fsSL https://go.dev/dl/go1.25.1.linux-amd64.tar.gz | sudo tar -C /usr/local -xz

# Install ALL development tools
echo "🛠️ Installing ALL development tools..."
sudo rpm-ostree install \
    make \
    gcc \
    gcc-c++ \
    git \
    wget \
    curl \
    tar \
    gzip \
    which \
    tree \
    htop \
    rsync \
    vim \
    nano \
    tmux \
    screen \
    less \
    file \
    findutils \
    bash-completion \
    python3 \
    python3-pip \
    nodejs \
    npm

echo "⚙️ Setting up environment configuration..."

# Create Go environment setup
sudo tee /etc/profile.d/go125.sh << 'GOEOF'
export PATH=/usr/local/go/bin:$PATH:$HOME/go/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
GOEOF
sudo chmod +x /etc/profile.d/go125.sh

# Add to user's bashrc for immediate availability
echo 'source /etc/profile.d/go125.sh' >> ~/.bashrc

# Create comprehensive development aliases
sudo tee /etc/profile.d/dev-complete.sh << 'DEVEOF'
# Development aliases
alias ll="ls -la --color=auto"
alias la="ls -la --color=auto"
alias l="ls -l --color=auto"
alias ..="cd .."
alias ...="cd ../.."
alias grep="grep --color=auto"
alias tree="tree -C"

# Go shortcuts
alias gv="go version"
alias gb="go build"
alias gr="go run"
alias gt="go test"
alias gm="go mod"
alias gf="go fmt"
alias gi="go install"
alias gc="go clean"

# Development shortcuts
alias mk="make"
alias v="vim"
alias h="htop"
alias t="tmux"

# Show development environment status on login
echo "🚀 Complete Development Environment Ready!"
echo "🐹 Go: \$(go version 2>/dev/null || echo 'Go 1.25.1 (source /etc/profile.d/go125.sh)')"
echo "🔨 GCC: \$(gcc --version 2>/dev/null | head -1 || echo 'GCC available after reboot')"
echo "📝 Make: \$(make --version 2>/dev/null | head -1 || echo 'Make available after reboot')"
echo "📁 Git: \$(git --version 2>/dev/null || echo 'Git available after reboot')"
echo "💻 Tools: vim, nano, tmux, screen, htop, tree, curl, wget"
echo "�� Python: \$(python3 --version 2>/dev/null || echo 'Python available after reboot')"
echo "🟢 Node.js: \$(node --version 2>/dev/null || echo 'Node.js available after reboot')"
echo ""
echo "📂 Ready to code! Try: cd ~/workspace && go run hello.go"
echo ""
DEVEOF
sudo chmod +x /etc/profile.d/dev-complete.sh

# Source the environment immediately
source /etc/profile.d/go125.sh

# Create workspace and sample code
echo "📁 Setting up workspace..."
mkdir -p ~/workspace
mkdir -p ~/go/src

# Create comprehensive test program
cat > ~/workspace/hello-complete.go << 'HELLO'
package main

import (
    "fmt"
    "runtime"
    "os/exec"
    "strings"
)

func getVersion(cmd string, args ...string) string {
    out, err := exec.Command(cmd, args...).Output()
    if err != nil {
        return "Not available yet (may need reboot)"
    }
    return strings.TrimSpace(string(out))
}

func main() {
    fmt.Printf("🚀 Complete Development Environment on %s/%s\n\n", 
        runtime.GOOS, runtime.GOARCH)
    
    fmt.Printf("🐹 Go: %s\n", runtime.Version())
    
    // Test other tools (may not be available until reboot)
    tools := map[string][]string{
        "🔨 GCC": {"gcc", "--version"},
        "�� Make": {"make", "--version"}, 
        "📁 Git": {"git", "--version"},
        "🐍 Python": {"python3", "--version"},
        "🟢 Node.js": {"node", "--version"},
    }
    
    for name, cmd := range tools {
        version := getVersion(cmd[0], cmd[1:]...)
        if strings.Contains(version, "Not available") {
            fmt.Printf("%s: %s\n", name, version)
        } else {
            lines := strings.Split(version, "\n")
            fmt.Printf("%s: %s\n", name, lines[0])
        }
    }
    
    fmt.Println("\n🎉 Go 1.25.1 is ready immediately!")
    fmt.Println("💻 Other tools will be available after reboot.")
    fmt.Println("📋 This VM includes everything for development!")
}
HELLO

# Create comprehensive Makefile
cat > ~/workspace/Makefile << 'MAKEFILE'
# Complete Development Environment Makefile
.PHONY: build run test clean fmt vet deps help tools-check

BINARY_NAME=myapp
MAIN_PACKAGE=.

help:
@echo "🚀 Complete Development Environment"
@echo "Available targets:"
@echo "  build        - Build Go application"
@echo "  run          - Run Go application"  
@echo "  test         - Run tests"
@echo "  clean        - Clean artifacts"
@echo "  fmt          - Format code"
@echo "  vet          - Vet code"
@echo "  deps         - Manage dependencies"
@echo "  tools-check  - Check all tools"

build:
go build -o ${BINARY_NAME} ${MAIN_PACKAGE}

run:
go run hello-complete.go

test:
go test -v ./...

clean:
go clean
rm -f ${BINARY_NAME}

fmt:
go fmt ./...

vet:
go vet ./...

deps:
go mod download
go mod tidy

tools-check:
@echo "🔧 Development tools status:"
@go version 2>/dev/null || echo "Go: Not in PATH"
@gcc --version 2>/dev/null | head -1 || echo "GCC: Not available (needs reboot)"
@make --version 2>/dev/null | head -1 || echo "Make: Not available (needs reboot)" 
@git --version 2>/dev/null || echo "Git: Not available (needs reboot)"
@python3 --version 2>/dev/null || echo "Python: Not available (needs reboot)"
@node --version 2>/dev/null || echo "Node.js: Not available (needs reboot)"

all: clean fmt vet deps test build
MAKEFILE

echo "✅ Go 1.25.1 installed and ready!"
echo "🎯 Testing Go installation:"
go version

echo ""
echo "🔄 Development tools installed but require REBOOT to be available"
echo "📋 After reboot, all tools will be ready:"
echo "  - make, gcc, git, vim, tmux, htop, tree"
echo "  - curl, wget, python3, nodejs, npm"
echo "  - All aliases and environment configured"
echo ""
echo "🚀 To complete setup:"
echo "  1. Reboot the VM: sudo systemctl reboot"
echo "  2. Test installation: cd ~/workspace && make run"
echo "  3. Check all tools: make tools-check"
echo ""
echo "💡 Go 1.25.1 is immediately available!"
echo "💻 Other tools available after reboot due to rpm-ostree layering"
