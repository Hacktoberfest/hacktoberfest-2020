# BegineersOnGit

### Configure Git for the first time
```
git config --global user.name "<Your Name>"
git config --global user.email "<Your Email>"
```

### To Clone the Git Repository
HTTPS:
```
git clone "https://github.com/Git-Begineers/BegineersOnGit.git"
cd BegineersOnGit
```

### If you already have code ready to be pushed to this repository then run this in your terminal.
```
cd existing-project
git init
git add --all
git commit -m "Initial Commit"
git remote add origin https://github.com/Git-Begineers/BegineersOnGit.git
git push -u origin <branch-name>
```