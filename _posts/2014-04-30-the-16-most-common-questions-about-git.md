---
layout: post
title: "The 16 most commonly asked questions about Git"
cover_image:

category: articles
tags: [tech]

author:
  name: Gonzalo Rodríguez-Baltanás Díaz
  twitter: iCodeErgoExist
  bio: 'Founder'
  image: avatar.png

excerpt: "Git is the best source version control ever tool made. It is also a complex tool, but learning it doesn't need to be painful. This selection of the most common questions regarding Git will teach you how to share code with confidence."
---

### How to edit an incorrect commit message in Git

If the commit is the last one:
{% highlight bash %}
git commit --amend -m "New commit message"
{% endhighlight %}

You can also use rebase to edit the commit messages – choose 'reword' for the commits you wish to edit.
{% highlight bash %}
git rebase -i HEAD~5  # Rebase the last 5 commits
{% endhighlight %}

__Warning__: Doing a rebase does change the commit history – it changes the SHA of commits – so do not rebase a commit that has already been published otherwise you will end up with duplicated commits when your team merges your branch with their own branch.

__Protip:__ You can ignore that rule if you are working on a feature branch and you are about to merge your work with `master` and you just want to clean up things. Since you are going to be merging to master and then deleting the feature branch nobody is going to be affected. It is actually a good practice to do that in such a case.

__Trivia__: You can't rebase the first commit of a repository, unless you pass the `--root` option.

### How to undo the last Git commit

{% highlight bash %}
git reset --soft 'HEAD^'

Protip:
git config --global alias.undo-commit 'reset --soft HEAD^'
git undo-commit
{% endhighlight %}


### How to delete a git branch both locally and remotely:
{% highlight bash %}
git push origin --delete <branchName>
{% endhighlight %}

### What is the difference between 'git pull' and 'git fetch'

* `git fetch`: Updates your local repository with the data from remote.
* `git pull`: Updates your working copy with the changes in the remote.

In practice: If you want to get the changes from remote without immediately changing your working copy then use `git fetch`. Otherwise use `git pull`. `git pull` does a `git fetch` followed by a `git merge.

### How to undo 'git add' before having commited
{% highlight bash %}
git reset <file>
git reset # omit the file in order to reset all of them

Protip:
git config --global alias.unstage 'reset HEAD --'
git unstage <file>
{% endhighlight %}


### How to merge a Git conflict

A conflict in Git occurs when two branches happen to modify the same area of code. Say you have a branch A:

{% highlight ruby %}
# John renamed this method to:
def john_is_the_best
end
{% endhighlight %}

...while branch B have this code in the same line:
{% highlight ruby %}
# Jaime renamed this method to:
def jaime_is_the_best
end
{% endhighlight %}

In such case Git is not capable of merging both changes because Git can't possibly know which one to choose. Your manual intervention is necessary and that is what we call a Git conflict. Git merging tools will markup areas in your code with conflict markers.

After seeing a conflict, you can do two things:

* Decide not to merge. `git merge --abort` can be used for this.

* Resolve the conflicts. Git will mark the conflicts in the working tree. Edit the files into shape and `git add` them to the index. Use `git commit` to seal the deal.


{% highlight bash %}
Protip:
git config merge.conflictstyle diff3 # Uses diff3 conflict markers.
{% endhighlight %}

Anatomy of a conflict marker:

{% highlight diff %}
<<<<<<<
Changes made on the branch that is being merged into. In most cases,
this is the branch that I have currently checked out (i.e. HEAD).
|||||||
The common ancestor version. This is what the common ancestor looked like. This is useful because you can compare it to the top and bottom versions to get a better sense of what was changed on each branch, which gives you a better idea for what the purpose of each change was.
=======
Changes made on the branch that is being merged in. This is often a
feature/topic branch.
>>>>>>>
{% endhighlight %}

Following the example, if we try to merge John's branch in Jaime's branch we would have had:
{% highlight diff %}
<<<<<<< HEAD
def jaime_is_the_best
||||||| merged common ancestors
def who_is_the_best?
=======
def john_is_the_best
>>>>>>> john
{% endhighlight %}

Understanding the intention behind each diff block is generally very helpful for understanding where a conflict came from and how to handle it.

This shows all of the commits that touched that file, considering just changes in between the common ancestor and the two heads you are merging, so it doesn't include commits that already exist in both branches before merging. This helps you ignore diff blocks that clearly are not a factor in your current conflict.

{% highlight bash %}
git log --merge -p <name of file>
{% endhighlight %}

After resolving the conflicts, it is a very good practice to test that you didn't broke anything. Run your automated test suite.

The easiest conflicts to solve are the ones that never happened:

* Talk to your team and if you anticipate that some of you are going to be doing extensive modifications to a single file consider instead working sequentially – one of you make your changes first, and the other can work on the top of said changes. No conflicts.
* If working in parallel is a must, then merge assiduously; that way you will catch conflicts sooner than later – and so will be smaller and fresher in the memory of both parties involved.

If there is something worse than a difficult merge is a merge that went wrong but got commited anyways. If you find yourself unable to resolve the conflicts with confidence, do not merge, instead abort the merge with `git merge abort` and talk to your team on how to best tackle it.

### How to clone all remote branches with Git

{% highlight bash %}
git remote update
git pull --all
{% endhighlight %}

### How to remove all untracked files in Git

{% highlight bash %}
git clean -f # Remove all untracked files.

git clean -f -d # Remove all untracked files and directories.
git clean -f -X # Remove just ignored files.
git clean -f -x # Remove all untracked and ignored files.

Protip:
Use the --dry-run option in order to preview changes.
{% endhighlight %}

### How to remove a git submodule
{% highlight bash %}
git submodule deinit <name>
{% endhighlight %}

### How to make an existing Git branch track a remote branch

{% highlight bash %}
git branch -u upstream/foo foo # you can omit the last 'foo' if you are already in that branch.
{% endhighlight %}

### How to do a "git export" (like "svn export")
{% highlight bash %}
git archive --format zip --output name.zip master
{% endhighlight %}

### How to rename a local Git branch

{% highlight bash %}
git branch -m <oldname> <newname> # You can skip oldname if you want to rename the current branch.
{% endhighlight %}

### How to add an empty directory to a git repository

Currently the design of the git index (staging area) only permits files to be listed. Directories are added automatically when adding files inside them. That is, directories never have to be added to the repository, and are not tracked on their own.

If you really need a directory to exist in checkouts you should create a file in it. For example a `.gitignore` file; you can leave it empty.

### How to checkout a remote branch

Checkouts a branch named my_branch that exists in any of the remotes.
{% highlight bash %}
git checkout my_branch

If multiple remotes have branches with the same name you will get an error – in which case you need to use the next form.

Protip:
Use the next form to checkout a branch named my_branch that exists in the remote named 'origin'

git checkout origin/my_branch
{% endhighlight %}

### How to revert to previous Git commit

There are two cases:

* If you have published it already:

{% highlight bash %}
git revert commit_sha
git revert commit_sha1 commit_sha2 commit_sha3 # Three commits are reverted in 3 separate commits
git revert HEAD~2..HEAD # Revert a range of commits. Each commit will have is own revert commit.
{% endhighlight %}

* If you haven't publish it already

{% highlight bash %}
git reset commit_sha # The one you want to revert to.

Protip:
If you have staged changed and you don't want to keep them use the `--hard` option.
git reset --hard commit_sha
{% endhighlight %}

### How to force git to overwrite local files on pull

Update from remote.
{% highlight bash %}
git fetch --all
{% endhighlight %}

Reset the master branch to what you just fetched. The `--hard` option changes all the files in your working tree to match the files in origin/master, so if you have any local changes, they will be lost. With or without `--hard`, any local commits that haven't been pushed will be lost.
{% highlight bash %}
git reset --hard origin/master
{% endhighlight %}


### How to stash only one file out of multiple files that have changed

This will stash everything that you haven't previously added. Just git add the things you want to keep, then run it.

{% highlight bash %}
git stash --keep-index
{% endhighlight %}