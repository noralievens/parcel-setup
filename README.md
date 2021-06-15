## parcel-setup.sh

### install

```
cd ~/bin # or any other directory in your PATH
wget https://raw.githubusercontent.com/arnolievens/parcel-setup/main/parcel-setup.sh -O parcel-setup
```

### usage

`parcel-setup.sh <local path> [new remote url]`

+ clones David's parcel2starterkit into `<local path>` folder
+ sets name in package.json to foldername
+ activates .gitignore file
+ installs npm dependencies
+ sets new remote url if provided

make sure parcel-setup.sh is in your PATH and executable (chmod +x parcel-setup.sh)<br>

### example
`parcel-setup.sh myProject https://github.com/kermit/myProject.git`

