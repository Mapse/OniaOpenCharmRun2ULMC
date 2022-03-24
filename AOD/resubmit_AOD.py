import time, os, subprocess, sys

ndays = 5
nhours = ndays * 24
nminutes = nhours * 60
nsecs = nminutes * 60

def resub():
    for project in subprocess.check_output("ls crab_projects/", shell=True).decode("utf-8").splitlines():
        os.system("crab status -d crab_projects/" + project)
        os.system("crab resubmit -d crab_projects/" + project)


for i in range(0, nsecs):
    resub()
    time.sleep(3600)


