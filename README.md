## parcel-setup.sh

### install

download parcel-setup into any folder in your PATH, eg ~/bin or ~/.local/bin
```
cd ~/bin
curl https://raw.githubusercontent.com/arnolievens/parcel-setup/main/parcel-setup.sh -o parcel-setup && chmod u+x $_
```

### usage

`parcel-setup <local path> [new remote url]`

+ clones David's parcel2starterkit into `<local path>` folder
+ optionally set new branch name (eg main)
+ sets name in package.json to foldername
+ activates .gitignore file
+ untrack .env. files
+ installs npm dependencies
+ sets new remote url if provided
+ type parcel-setup --help for more info

options:<br>
-b, --branch        rename master branch


### example
`parcel-setup myProject https://github.com/kermit/myProject.git --branch main`

