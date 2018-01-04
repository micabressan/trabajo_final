create table node(
	id integer primary key);

create table client(
	id integer primary key);

create table owner(
	node_id integer,
	client_id integer,
	foreign key(node_id) references node(id) on delete restrict on update cascade,
	foreign key(client_id) references client(id) on delete cascade on update cascade);