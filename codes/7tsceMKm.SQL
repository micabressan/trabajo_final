/*---------------------DROP_TABLES--------------------------*/
DROP TABLE best_path_algorithm CASCADE CONSTRAINT;
DROP TABLE section_direction CASCADE CONSTRAINT;
DROP TABLE road_typology CASCADE CONSTRAINT;
DROP TABLE toll_fare CASCADE CONSTRAINT;
DROP TABLE vehicle_motorization CASCADE CONSTRAINT;
DROP TABLE vehicle_type CASCADE CONSTRAINT;
DROP TABLE vehicle_toll_class CASCADE CONSTRAINT;
DROP TABLE vehicle CASCADE CONSTRAINT;
DROP TABLE road_network CASCADE CONSTRAINT;
DROP TABLE network_analysis CASCADE CONSTRAINT;
DROP TABLE road CASCADE CONSTRAINT;
DROP TABLE node CASCADE CONSTRAINT;
DROP TABLE section CASCADE CONSTRAINT;
DROP TABLE segment CASCADE CONSTRAINT;
DROP TABLE throttle_id CASCADE CONSTRAINT;
DROP TABLE fuel_type CASCADE CONSTRAINT;
DROP TABLE gear CASCADE CONSTRAINT;
DROP TABLE vehicle_velocity_limit CASCADE CONSTRAINT;
DROP TABLE regime CASCADE CONSTRAINT;
DROP TABLE gear_ratio CASCADE CONSTRAINT;

DROP SEQUENCE seq_section_id;

/*---------------------CREATE_SEQUENCES--------------------------*/
CREATE SEQUENCE seq_section_id
 START WITH     1
 INCREMENT BY   1
 MINVALUE      1
 MAXVALUE      9999999999
 ;
/*---------------------CREATE_TABLES--------------------------*/
CREATE TABLE best_path_algorithm (
	best_path_algorithm varchar(40),
	constraint pk_best_path_algorithm primary key (best_path_algorithm)
);

CREATE TABLE section_direction(
    direction varchar(30),
    constraint pk_section_direction primary key(direction)
);

CREATE TABLE road_typology(
    typology varchar(30),
    constraint pk_road_typology primary key(typology)
);

CREATE TABLE road_network(
	name varchar(20),
	description varchar(255),
    constraint pk_road_network primary key(name)
);

CREATE TABLE vehicle_toll_class(
	toll_class number(10),
	constraint pk_vehicle_toll_class primary key(toll_class)
);

CREATE TABLE throttle_id (
	id number(3),
	constraint pk_throttle_id primary key(id)
);


CREATE TABLE vehicle_motorization (
	motorization varchar(20), 
	constraint pk_vehicle_motorization primary key(motorization)
);

CREATE TABLE vehicle_type (
	type varchar(20),
	constraint pk_vehicle_type primary key(type)
);

CREATE TABLE fuel_type (
	type varchar(20),
	constraint pk_fuel_type primary key(type)
);

CREATE TABLE vehicle (
	name varchar(20),
	type varchar(20),
	toll_class number(10),
	motorization varchar(20),
	road_network_name varchar(20),
	fuel_type varchar(20),
	mass number(4,2) NOT NULL,
	load number(4, 1) NOT NULL, 
	drag_coeficient number(4, 2) NOT NULL,
	rolling_resistence_coefficient number(4,2) NOT NULL, 
	wheel_size number(4,2) NOT NULL, 
	braking_energy_regeneration number(4, 2),
    frontal_area number(4, 2) NOT NULL,
    min_rpm number(4, 2) NOT NULL,
	max_rpm number(4, 2) NOT NULL,
	final_drive_ratio number(4, 2) NOT NULL,
	constraint pk_vehicle primary key(name),
	constraint fk_vehicle_road_network foreign key(road_network_name) references road_network(name), 
	constraint fk_vehicle_vehicle_motorization foreign key(motorization) references vehicle_motorization(motorization), 
	constraint fk_vehicle_vehicle_toll_class foreign key(toll_class) references vehicle_toll_class(toll_class),
	constraint fk_vehicle_vehicle_type foreign key(type) references vehicle_type(type),
	constraint fk_vehicle_fuel_type foreign key(fuel_type) references fuel_type(type)
);

CREATE TABLE regime (
	throttle_id number(3),
	vehicle_name varchar(20),
	rpm_high number(4, 2),
	rpm_low number(4, 2),
	torque number(4, 2) NOT NULL, 
	sfc number(10),
	constraint pk_regime primary key(throttle_id, vehicle_name, rpm_high, rpm_low),
	constraint fk_regime_throttle_id foreign key(throttle_id) references throttle_id(id),
	constraint fk_regime_vehicle foreign key(vehicle_name) references vehicle(name)
);

CREATE TABLE network_analysis (
	vehicle_name varchar(20),
	best_path_algorithm varchar(40),
	toll_costs number(4, 2) NOT NULL,
	travelling_time varchar(8),
	energy_consumption number(5, 2) NOT NULL,
	sections_list varchar(200),
	constraint fk_network_analysis_best_path_algorithm foreign key(best_path_algorithm) references best_path_algorithm(best_path_algorithm),
	constraint fk_netword_analysis_vehicle foreign key(vehicle_name) references vehicle(name),
    constraint pk_network_analysis primary key(vehicle_name, best_path_algorithm)
);


CREATE TABLE road(
    name varchar(10),
    road_network_name varchar(20),
    typology varchar(20),
    constraint fk_road_road_network foreign key(road_network_name) references road_network(name),
    constraint pk_road primary key(name),
    constraint fk_road_road_typology foreign key(typology) references road_typology(typology)
);

CREATE TABLE node(
    id varchar(5), 
    road_network_name varchar(10), 
    has_toll char(1),
    constraint pk_node primary key(id),
    constraint fk_node_road_network foreign key(road_network_name) references road_network(name)
);

CREATE TABLE vehicle_velocity_limit (
	velocity_limit number(4, 2) NOT NULL, 
	vehicle_name varchar(20),
	road_typology varchar(30),
	constraint pk_vehicle_velocity_limit primary key(vehicle_name, road_typology),
	constraint fk_vehicle_velocity_limit_vehicle foreign key(vehicle_name) references vehicle(name),
	constraint fk_vehicle_velocity_limit_road_typology foreign key(road_typology) references road_typology(typology)
);


CREATE TABLE section(
    id number(10) default seq_section_id.nextval,
    road_name varchar(10),
    direction varchar(30),
    ending_node varchar(5),
    begining_node varchar(5),
    constraint pk_section primary key(id),
    constraint fk_section_road foreign key(road_name) references road(name),
    constraint fk_section_section_direction foreign key(direction) references section_direction(direction),
    constraint fk_section_ending_node foreign key(ending_node) references node(id),
    constraint fk_section_begining_node foreign key(begining_node) references node(id)
);

CREATE TABLE segment(
    order_in_section number(10),
    section_id number(10), 
    has_toll char(1),
    initial_height number(10) NOT NULL,
    slope number(4,2) NOT NULL,
    length number(10) NOT NULL,
    wind_direction number(4,2) NOT NULL,
    wind_speed number(4,2) NOT NULL,
    maximum_velocity number(5) NOT NULL,
    minimum_velocity number(5) NOT NULL,
    final_height number(10) NOT NULL,
    constraint pk_segment primary key(order_in_section, section_id),		
    constraint fk_segment_section foreign key(section_id) references section(id)
);

CREATE TABLE toll_fare (
    vehicle_toll_class number(10),
    road_name varchar(10),
    price number(4, 2) NOT NULL,
    constraint fk_toll_fare_vehicle_toll_class foreign key(vehicle_toll_class) references vehicle_toll_class(toll_class), 
    constraint fk_toll_fare_road foreign key(road_name) references road(name),
    constraint pk_toll_fare primary key(vehicle_toll_class, road_name)
);

CREATE TABLE gear (
    id number(10),
    constraint pk_gear primary key(id)
);

CREATE TABLE gear_ratio (
    gear_id number(10),
    vehicle_name varchar(20),
    ratio number(4, 2) NOT NULL,
    constraint pk_gear_ratio primary key(gear_id, vehicle_name),
    constraint fk_gear_ratio_gear foreign key(gear_id) references gear(id),
    constraint fk_gear_ratio_vehicle foreign key(vehicle_name) references vehicle(name)
);

/*------------------CREATE_INSERTS-----------------------*/
INSERT INTO section_direction VALUES('bidirectional');
INSERT INTO section_direction VALUES('direct'); -- begin to end
INSERT INTO section_direction VALUES('reverse'); -- end to begin
INSERT INTO vehicle_motorization VALUES('combustion');
INSERT INTO vehicle_motorization VALUES('electric');
INSERT INTO vehicle_motorization VALUES('hybrid');
INSERT INTO road_typology VALUES('regular');
INSERT INTO road_typology VALUES('urban');
INSERT INTO road_typology VALUES('highway');
INSERT INTO road_typology VALUES('express');
INSERT INTO vehicle_type VALUES('car');
INSERT INTO vehicle_type VALUES('motorcycle');
INSERT INTO vehicle_type VALUES('truck');
INSERT INTO vehicle_type VALUES('tractor');
INSERT INTO fuel_type VALUES('gasoline');
INSERT INTO fuel_type VALUES('diesel');
INSERT INTO fuel_type VALUES('electric');
INSERT INTO throttle_id VALUES(25);
INSERT INTO throttle_id VALUES(50);
INSERT INTO throttle_id VALUES(100);
INSERT INTO gear VALUES(1);
INSERT INTO gear VALUES(2);
INSERT INTO gear VALUES(3);
INSERT INTO gear VALUES(4);
INSERT INTO gear VALUES(5);
INSERT INTO gear VALUES(6);
INSERT INTO vehicle_toll_class VALUES(1);
INSERT INTO vehicle_toll_class VALUES(2);
INSERT INTO vehicle_toll_class VALUES(3);
INSERT INTO vehicle_toll_class VALUES(4);