#!/usr/bin/env python

import os, sys, subprocess

def startenv ():
    prompt = "Enter new virtualenv's name: "
    env_name = str(raw_input(prompt))
    print "Setting up new virtualenv named %s..." % env_name 
    subprocess.call( ["scripts/mkenv.sh %s" % env_name], shell=True)
    return env_name

startenv()
