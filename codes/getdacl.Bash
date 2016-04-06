#!/bin/sh

# awk one-liner to mimic getfacl output
dpkg -c $1|awk '{gsub("/"," ",$2); print}'|awk '{print "# file: "substr($7,2)"\n# owner: "$2"\n# group: "$3"\nuser::"substr($1,2,3)"\ngroup::"substr($1,5,3)"\nothers::"substr($1,8,3)"\n"}'