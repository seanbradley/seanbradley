#!/usr/bin/env python

import os, sys, subprocess

def startenv ():
    prompt = "Enter new project name: "
    projectname = str(raw_input(prompt))
    print "Setting up new project named %s..." % projectname 
    subprocess.call( ["./mkenv.sh %s" % projectname], shell=True)
    return projectname

startenv()
