#! /usr/bin/python
#
# Hacked together script to delete RAW photo files from the 
# OSX Photo Library that have not been set as favorites.
# The idea being that if you care enough to edit the image as RAW,
# then you will have set it as a favorite.
# 
# A favorites.csv file that contains a list of file names that are 
# favorites is required and passed in via the --favorites param.
# To generate a new favorites.csv file you can open the photos.db file
# in the OSX Photos library / database directory. Using something like 
# "DB Browser for SQLite", run something like the following query to 
# get a list of favorite files which can then be exported to CSV.
#
# select fileName, isFavorite
# from RKVersion
# where isFavorite=1
#
# Note: It would have been great if the favorite metadata was actually stored 
# in the file's EXIF or IPTC metadata, but of course it is not and only exists
# in the database mentioned above.
#

import sys
import os
import csv

def get_optval(opt, default=None):
    if opt not in sys.argv:
        return default
    pos = sys.argv.index(opt)
    sys.argv.pop(pos)
    return sys.argv.pop(pos)

def get_required_optval(opt, default=None):
    val = get_optval(opt, default)
    if val is None:
        print("Please add a %s" %opt)
        sys.exit()
    return val

def walk(dir, favfiles):
    
    for name in os.listdir(dir):
        path = os.path.join(dir, name)

        if(os.path.isfile(path)):
            filename = os.path.basename(path)
            noext = filename.split(".")[0]
            
            if not filename.endswith(".ORF"):
                continue # Only operate on RAW files
            
            if noext in [f.split(".")[0] for f in favfiles]:
                continue # Don't touch favorites
            
            print("Deleting " + filename)
            os.remove(path)
            # print filename + " " + noext
        else:
            walk(path, favfiles)


PHOTODIR = get_required_optval("--srcdir")
FAVORITES = get_required_optval("--favorites")

csvf = open(FAVORITES, 'rb');
reader = csv.reader(csvf)
favfiles = [row[0] for row in reader]

walk(PHOTODIR, favfiles)
# print len(favfiles)
