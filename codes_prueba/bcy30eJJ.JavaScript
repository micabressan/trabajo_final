// code for group settings

// play private games
tagpro.group.socket.emit("pug");

// set public group to false
tagpro.group.socket.emit('publicGroup', false);

// set map
tagpro.group.socket.emit("setting", {name: "map", value: "EMERALD"});

// disable self assignment
tagpro.group.socket.emit("setting", {name: "selfAssignment", value: false});

// enable noScript
tagpro.group.socket.emit("setting", {name: "noScript", value: true});

// disable respawn warnings
tagpro.group.socket.emit("setting", {name: "respawnWarnings", value: false});

// time limit to 10 minutes
tagpro.group.socket.emit("setting", {name: "time", value: 10});

// cap limit to unlimited
tagpro.group.socket.emit("setting", {name: "caps", value: 0});

// set red Team Name to "Team RED"
tagpro.group.socket.emit("setting", {name: "redTeamName", value: "Team RED"});

// move a player to a certain team or spec
// this requires a player Id, which is sent in "member" events from server to client
// that "member" event has fields like the following:
/** 
    id: "the player id",
    lastSeen: 1513529722226,
    leader: true,
    location: "page",
    name: "the player display name",
    spectator: false,
    team: 1
**/
// teams are  1: red
//            2: blue
//            3: spec
tagpro.group.socket.emit("team", {id: "player id goes here", team: 1});

// swap teams
tagpro.group.socket.emit("swapTeams");

// randomize teams
tagpro.group.socket.emit("randomTeams");