user "theuser";
password "passw0rd";

task "one", "server1", sub {
    # do something
};

# solution one, every task below this will use the new authentication
below {
    user "root";
    password "f00b4r";
};

task "two", "server1", sub {
   # do something
};


#
# or, an other way
#

task "three", "server1", sub {
    # do something
};

# solution 2. set a special authentication for task "three"

set auth => "three", sub {
    user "r00t";
    password "passw0rd";
};