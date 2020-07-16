if __name__ == '__main__':
    from CRABAPI.RawCommand import crabCommand
    from CRABClient.ClientExceptions import ClientException
    from httplib import HTTPException

from multiprocessing import Process

import importlib

import argparse
parser = argparse.ArgumentParser(description='Send MC jobs via CRAB3')
parser.add_argument('-s', '--site', help='site to store the output', type=str)
parser.add_argument('-j', '--jobs', help='number of jobs', type=int, default=10)
parser.add_argument('-n', '--nevt', help='number of events per job', type=int, default=100000)
parser.add_argument('-c', '--config', help='config to be used in submition', type=str)

args = parser.parse_args()

# import module with crab configuration
mdl = importlib.import_module(args.config)
# is there an __all__?  if so respect it
if "__all__" in mdl.__dict__:
    names = mdl.__dict__["__all__"]
else:
    # otherwise we import all names that don't begin with _
    names = [x for x in mdl.__dict__ if not x.startswith("_")]
# now drag them in
globals().update({k: getattr(mdl, k) for k in names})

config.Data.unitsPerJob = args.nevt
NJOBS = args.jobs  # This is not a configuration parameter, but an auxiliary variable that we use in the next line.
config.Data.totalUnits = config.Data.unitsPerJob * NJOBS

config.Site.storageSite = args.site

try:
    crabCommand('submit', config = config)
except HTTPException as hte:
    print "Failed submitting task: %s" % (hte.headers)
except ClientException as cle:
    print "Failed submitting task: %s" % (cle)


