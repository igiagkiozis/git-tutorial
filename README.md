## Setup
* Add the following to your .gitconfig file (you can find this file @ C:\Users\your_user_name\.gitconfig)
```{r, engine='bash'}
[alias]
  show-aliases = "!git config -l | grep alias | cut -c 7-"
  st = status
  sta = status
  glog = log --graph --decorate --oneline
  glog-long = log --graph --decorate --pretty=oneline
  objects = rev-list --objects --all --pretty=oneline
  gobjects = rev-list --objects --all --graph --pretty=oneline
  unstage = reset HEAD
  sunstage = "!git reset HEAD \"$@\" && git status"
  content = cat-file -p
  type = cat-file -t
  detach = checkout --detach
  previous = checkout -
  sadd = "!git add \"$@\" && git status"
  sad = "!git add \"$@\" && git status"
  scommit="!f() {\
  	git commit \"$@\"; \
  	git status; \
  }; f"
  scheckout = "!git checkout \"$@\" && git status"
  dangling = fsck --no-reflogs
  super-gc="!f() {\
  	git reflog expire --expire-unreachable=now --all; \
  	git gc --prune=now; \
  }; f"
```
* Everything in the .gitconfig aliases section will be available in git bash - and will come up as a suggestion 
if you mistype it! Also notice that in the event you forget an alias you can always use ```git show-aliases```, assuming you remember the ```show-aliases``` alias ;) 
* Copy the ```all-objects``` script to ```C:\Program Files\Git\mingw64\bin```

Some commands are commonly followed by ```git status```, just to verify that they did what we expected them to do. The most common of these commands are: 
* add
* commit
* checkout

To speed things up aliases for these have been defined with the prefix ```s```, namely
* ```git sadd somefile.txt``` is equivalent to ```git add somefile.txt && git status```
See also
* scommit
* scheckout
* sunstage

### Working Directory
A repository has been created for you at ```\\nasbox\FILL_IN_THE_PATH\NameRepo```, open a git bash shell in your repo.

## Detaching your HEAD
Detaching the HEAD pointer can be quite useful.
```
git checkout --detach
```
Will checkout the current commit by using its hash. The above command is equivalent to
```
git checkout current_commit_hash
```
Try it! Using the predefined alias ```git checkout --detach``` is equivalent to ```git detach```. 

Now that you're in a detached head state, create a file ```detached_head_file.txt``` with contents ```detached...```

Add the file and commit it
```
git sadd detached_head_file.txt
git scommit -m "detached 0"
```
Repeat the above with different files a couple of times to generate new objects in the repository.

Now have a look at the results using the following command 
```
git glog
```
and check that all objects are accounted for with
```
git objects
```
The above is equivalent to ```git rev-list --objects --all```. However, this command will only list objects that are reachable from the current commit. To see all objects in a git repository you can use the script ```all-objects``` you copied in the setup section. 
```
all-objects
```

Now run
```
git previous
```
This is equivalent to ```git checkout -``` which in this case is also equivalent to ```git checkout master```.

Run again 
```
all-objects
```
Git periodically executes its garbage collection mechanism so all objects marked as ```Loose``` are liable to be garbage collected at some time or another. Instead of waiting for this to happen automatically let's speed up things a litte: 
```
git gc
```
This triggers the git garbage collector. Try running ```all-objects``` again! This time around we've lost our commits blobs trees etc., why? 

### Tags to the rescue
Tags have many use cases, one of these is to keep track of experiments in your local repo without polluting the main repository. Tags come in two flavours, annotated and lightweight. Personally I prefer using annotated tags as they're much easier to track in the git object database. That said, functionally both are virtually equivalent. 

Let's see how we can leverage them. 

* Detach the HEAD
* Create a file along with a new commit
* Create a tag
```
git tag -a <tag_name> -m "Here goes the message you'd like to include with the tag"
```

Now run
```
git previous
```
Check what ```all-objects``` has to say.
Then
```
git gc
```
Check ```all-objects``` once more.

Suppose you no longer need the changes that the tag points to
```
git tag -d <tag_name>
```
Check ```all-objects```, then run ```git super-gc``` and check again... everything is squeaky clean!

* Remember ```git detach``` with no arguments will make ```HEAD``` point to the current commit, however you can also use a commit hash, like so ```git detach baadf00d``` a branch ```git detach DEV-001``` or even a tag... you get the picture.

## Moving Things in the Index, Working and Git Repo Areas


## Remotes 
* Pick a pair 

Add their repository using 
```
git remote add <remote_name> <git_remote_URL>
```
Make sure you include the full path to the repository.

For reference all the generated repositories are: 
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

Create a file with your name + ".txt" and add some text to it (anything).
Stage it and commit it.
Push this to the origin repo.

>> git fetch from all repos except origin.
>> git merge with all repositories (in one command) (add --allow-unrelated-repositories)
Once successful check the number of parents in the merge commit. 

