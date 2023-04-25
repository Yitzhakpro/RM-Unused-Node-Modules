# Remove Unused NPM Modules

Want to free some space that is taken by unused projects' node_modules?
Use this tool!

## Usage

Run the EXE and follow the instructions, you will be asked to enter a directory, after that the tool will traverse recursively the directory and will ask you on every single project if you want to delete the `node modules` of it or not or not.

**For convenience** make sure you put the EXE inside a directory in the `$PATH` variable

## Compile & Run

Install ps2exe Module

```bash
Install-Module ps2exe

# output:
# Untrusted repository
#  You are installing the modules from an untrusted repository. If you trust this repository, change
#  its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to
#  install the modules from 'PSGallery'?
#  [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): Y
```

Compile the powershell script

```bash
$ Invoke-ps2exe .\rm_unused_modules.ps1 .\rm_unused_modules.exe
```
