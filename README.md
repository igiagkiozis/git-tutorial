Instructions
------------
Step 1
------
Add to your remotes all the other repositories, including origin (excluding your own of course...).
These are:
* ConnorRepo
* GarethRepo
* GiulioRepo
* GurmitRepo
* IoannisRepo
* JyothiRepo
* MikeRepo
* PatrickRepo
* PriyaRepo
* SteveRepo
* origin
Make sure you include the full path to the repository.
Use the following for this step:
>> git remote add <remote_name> <git_remote_URL>



Step 2
------
Create a file with your name + ".txt" and add some text to it (anything).
Stage it and commit it.
Push this to the origin repo.

Step 3 (Octopus merge)
------
>> git fetch from all repos except origin.
>> git merge with all repositories (in one command) (add --allow-unrelated-repositories)
Once successful check the number of parents in the merge commit. 

Step 4
------
Useful aliases
Add the following to your .gitconfig file (you can find this file @ C:\Users\your_user_name\.gitconfig)

```{r, engine='bash'}
[alias]
  st = status
  sta = status
  glog = log --graph --decorate --oneline
  glog-long = log --graph --decorate --pretty=oneline
  objects = rev-list --objects --all --pretty=oneline
  gobjects = rev-list --objects --all --graph --pretty=oneline
  unstage = reset HEAD
  content = cat-file -p
  type = cat-file -t
  detach = checkout --detach
  previous = checkout -
```
Copy the show-all-objects to C:\Program Files\Git\mingw64\bin

Everything in the .gitconfig aliases section will be available in git bash - and will come up as a suggestion 
if you mistype it!