# Get Node-RED version from package.json
$NODE_RED_VERSION = Select-String -Path .\package.json -Pattern '"node-red": "(\w*.\w*.\w*.\w*.\w*.)"' | % { $_.Matches } | % { $_.Groups[1].Value }

Write-Host "#########################################################################"
Write-Host "node-red version: $NODE_RED_VERSION"
Write-Host "#########################################################################"

# Build Docker image
$buildDate = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"
docker build  `
    --build-arg NODE_VERSION=16 `
    --build-arg NODE_RED_VERSION=$NODE_RED_VERSION `
    --build-arg BUILD_DATE=$buildDate `
    --build-arg TAG_SUFFIX=default `
    --file Dockerfile.centos `
    --tag testing:node-red-build .
