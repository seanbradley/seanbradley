#!/bin/bash

#receives projectname from startenv.py as 
#a positional string argument $1
#creates a new virtualenv and sets the virtualenv 
#project directory

####################
#DO NOT PLACE PASSWORDS OR GITHUB TOKEN IN THIS FILE
#Keep secret keys out of version control
####################

#mkdir ~/Projects/$1
#cd ~/Projects/$
   
create_env(){
    echo "Present working directory is..." 
    pwd
    #mv ./wolfskill/* .
    #cd .
    #rm -rf wolfskill
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects
    source /usr/local/bin/virtualenvwrapper.sh
    mkvirtualenv $1
    setvirtualenvproject
    echo "Setting up Git Flow..."
    git flow init
} 

#See https://www.viget.com/articles/create-a-github-repo-from-the-command-line  
#Get token from https://github.com/settings/tokens/new
#Need to git flow init                      
create_repo() {
    repo_name=$1

    #dir_name=`basename $(pwd)`

    #if [ "$repo_name" = "" ]; 
    #then echo "Repo name? (Hit enter to use $1)"
    #read repo_name
    #fi

    #if [ "$repo_name" = "" ]; 
    #then repo_name=$dir_name
    #fi

    username=`git config github.user`
    if [ "$username" = "" ]; 
    then echo "Could not find GitHub username, run 'git config --global github.user <username>'"
    invalid_credentials=1
    fi

    token=`git config github.token`
    if [ "$token" = "" ]; 
    then echo "Could not find token, run 'git config --global github.token <token>'"
    invalid_credentials=1
    fi

    if [ "$invalid_credentials" == "1" ]; 
    then return 1
    fi

    echo "Creating Github repository '$repo_name' ..."
    curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
    echo " done."
    echo "Swapping remote origin for a new one..."
    git remote rm origin
    git remote add origin https://github.com/$username/$repo_name.git
    #git config master.remote origin
    #git config master.merge refs/heads/master
    echo "Pushing local code to new remote ..."
    git push -u origin master
    echo " done."
}

create_env $1
create_repo $1

exit
