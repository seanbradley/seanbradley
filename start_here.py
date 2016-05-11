"""

{
    "applicationId": "2d038737-1e00-43fd-80c3-7217b60afd44"
}


This allows you to do something like:
findReplace("some_dir", "find this", "replace with this", "*.txt")

"""

#input what is the old project or variable name?
#input what is the new project or variable name?
#to what file types should swap be restricted?


import os, fnmatch
def findReplace(directory, find, replace, filePattern):
    for path, dirs, files in os.walk(os.path.abspath(directory)):
        for filename in fnmatch.filter(files, filePattern):
            filepath = os.path.join(path, filename)
            with open(filepath) as f:
                s = f.read()
            s = s.replace(find, replace)
            with open(filepath, "w") as f:
                f.write(s)
                
findReplace();
