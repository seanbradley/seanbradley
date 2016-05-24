"""

{
    "applicationId": "2d038737-1e00-43fd-80c3-7217b60afd44"
}

Swaps project name throughout repo.

These files incl. a capitalized tag or title of the project name...
They must be updated manually, or this script must be run twice.
scripts/create_deployment.sh
scripts/create_deployment_group.sh
scripts/create_tags.sh
README.md

"""
import os, fnmatch

prompt = "Enter name of old project: "
old_project = str(raw_input(prompt))
prompt = "Enter name of new project: "
new_project = str(raw_input(prompt))
print = "Limit project name replacement to certain file types?"
print = "If--for example--only BASH scripts, then enter '*.sh' (no quotes);"
print = "if only Python scripts--then *.py; if only PHP--then *.php, etc."
print = "But to search and replace project name in all files, then *.*."
sleep(3)
prompt = "Enter file type in which swap is preferred; enter *.* for all files: "
filetype = str(raw_input(prompt))
print "Setting up new project named %s..." % replace 

def findReplace(directory, old_project, new_project, filetype):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filetype):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(old_project, new_project)
            with open(filepath, "w") as f:
                f.write(s)
                
findReplace();
