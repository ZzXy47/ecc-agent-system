# ECC Agent System — Windows Install Script
# PowerShell 执行: .\install.ps1

Write-Host "🚀 Installing ECC Agent System..." -ForegroundColor Green

# Check VS Code
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "❌ VS Code not found. Please install VS Code first." -ForegroundColor Red
    exit 1
}

# Create directories
$dirs = @(
    "$env:USERPROFILE\.copilot\agents",
    "$env:USERPROFILE\.copilot\hooks",
    "$env:USERPROFILE\.copilot\skills",
    "$env:USERPROFILE\.copilot\prompts",
    "$env:USERPROFILE\.claude\rules"
)

foreach ($dir in $dirs) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }
}

# Copy files
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host "📁 Copying agents..."
Copy-Item -Path "$scriptDir\agents\*" -Destination "$env:USERPROFILE\.copilot\agents\" -Recurse -Force

Write-Host "📁 Copying hooks..."
Copy-Item -Path "$scriptDir\hooks\*" -Destination "$env:USERPROFILE\.copilot\hooks\" -Recurse -Force

Write-Host "📁 Copying skills..."
Copy-Item -Path "$scriptDir\skills\*" -Destination "$env:USERPROFILE\.copilot\skills\" -Recurse -Force

Write-Host "📁 Copying prompts..."
Copy-Item -Path "$scriptDir\prompts\*" -Destination "$env:USERPROFILE\.copilot\prompts\" -Recurse -Force

Write-Host "📁 Copying rules..."
Copy-Item -Path "$scriptDir\rules\ecc" -Destination "$env:USERPROFILE\.claude\rules\" -Recurse -Force

Write-Host "📁 Copying lefthook config..."
Copy-Item -Path "$scriptDir\lefthook.yml" -Destination "$env:USERPROFILE\.copilot\" -Force

# Install lefthook if not present
if (-not (Get-Command lefthook -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Installing lefthook..." -ForegroundColor Yellow
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        npm install -g lefthook
    } elseif (Get-Command scoop -ErrorAction SilentlyContinue) {
        scoop install lefthook
    } else {
        Write-Host "⚠️  lefthook not installed. Please install manually:" -ForegroundColor Yellow
        Write-Host "   npm install -g lefthook"
        Write-Host "   or: scoop install lefthook"
    }
}

Write-Host ""
Write-Host "✅ ECC Agent System installed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Next steps:"
Write-Host "   1. Restart VS Code"
Write-Host "   2. Open a project and run: lefthook install"
Write-Host "   3. Start using Conductor in Copilot Chat!"
Write-Host ""
Write-Host "📖 Read the guide: docs/GUIDE-zh.md (中文) or docs/GUIDE-en.md (English)"
