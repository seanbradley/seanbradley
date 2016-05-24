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
#cd ~/Projects/$1
   
create_env(){
    mv wolfskill/* ..
    sudo rm -r wolfskill
    #cd $1
    source /usr/local/bin/virtualenvwrapper.sh
    echo "Project's virtualenv name will be "$1"."
    mkvirtualenv $1
    setvirtualenvproject
    #git clone https://github.com/seanbradley/wolfskill.git
    #mkdir scripts
    #pip install -r requirements.txt
    #cd scripts
    #python swap_project_name.py
    #./deploy.sh
    deactivate
} 

#See https://www.viget.comhttps://github.com/settings/tokens/new/articles/create-a-github-repo-from-the-command-line  
#Get token from https://github.com/settings/tokens/new
#Need to git flow init                      
create_repo() {
    repo_name=$1

    #dir_name=`basename $(pwd)`

    if [ "$repo_name" = "" ]; 
    then echo "Repo name? (Hit enter to use $1)"
    read repo_name
    fi

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

    echo -n "Creating Github repository '$repo_name' ..."
    curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
    echo " done."

    echo -n "Pushing local code to remote ..."
    git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
    git push -u origin master > /dev/null 2>&1
    echo " done."
}

create_env $1
create_repo $1

exit
