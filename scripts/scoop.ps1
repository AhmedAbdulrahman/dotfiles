#requires -v 3

if (Get-Command scoop -errorAction SilentlyContinue)
{
	write-host "Scoop already installed!"
} else {
	set-executionpolicy unrestricted -s cu
	invoke-expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
}
scoop bucket add extras https://github.com/lukesampson/scoop-extras.git

# Utils
scoop install git git-lfs 7zip curl sudo openssh openssl 
scoop install aria2 touch coreutils grep sed less which zip unzip tar gzip make

[environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')

# dev tools
scoop install vagrant winmerge hugo glide vscode ngrok insomnia postman oraclejdk-lts android-studio

# Programming Languages
scoop install python ruby nvm dotnet nuget

# AWS Command Line Interface
pip install awscli

# Go & Dependency management tool 
scoop install go
go get -u github.com/golang/dep/cmd/dep

# Install Node using NVM for more info visit https://github.com/creationix/nvm
nvm install latest
scoop install yarn
sudo npm install --global --production windows-build-tools # VERY IMPORTANT

# Less often
scoop install vlc

# vim
scoop install vim

# 'extras' bucket is a special bucket that contains apps which are don't quite fit the criteria of the main bucket
# for more info visit https://github.com/lukesampson/scoop/wiki/Buckets
scoop bucket add extras
scoop bucket add versions
scoop bucket add java
