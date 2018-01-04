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
DROP TABLE SECTION CASCADE CONSTRAINT;
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
    best_path_algorithm VARCHAR(40),
    CONSTRAINT pk_best_path_algorithm PRIMARY KEY (best_path_algorithm)
);
 
CREATE TABLE section_direction(
    direction VARCHAR(30),
    CONSTRAINT pk_section_direction PRIMARY KEY(direction)
);
 
CREATE TABLE road_typology(
    typology VARCHAR(30),
    CONSTRAINT pk_road_typology PRIMARY KEY(typology)
);
 
CREATE TABLE road_network(
    name VARCHAR(20),
    description VARCHAR(255),
    CONSTRAINT pk_road_network PRIMARY KEY(name)
);
 
CREATE TABLE vehicle_toll_class(
    toll_class NUMBER(10),
    CONSTRAINT pk_vehicle_toll_class PRIMARY KEY(toll_class)
);
 
CREATE TABLE throttle_id (
    id NUMBER(3),
    CONSTRAINT pk_throttle_id PRIMARY KEY(id)
);
 
 
CREATE TABLE vehicle_motorization (
    motorization VARCHAR(20),
    CONSTRAINT pk_vehicle_motorization PRIMARY KEY(motorization)
);
 
CREATE TABLE vehicle_type (
    TYPE VARCHAR(20),
    CONSTRAINT pk_vehicle_type PRIMARY KEY(TYPE)
);
 
CREATE TABLE fuel_type (
    TYPE VARCHAR(20),
    CONSTRAINT pk_fuel_type PRIMARY KEY(TYPE)
);
 
CREATE TABLE vehicle (
    name VARCHAR(20),
    description VARCHAR(255),
    TYPE VARCHAR(20),
    toll_class NUMBER(10),
    motorization VARCHAR(20),
    road_network_name VARCHAR(20),
    fuel_type VARCHAR(20),
    mass NUMBER(4,2) NOT NULL,
    LOAD NUMBER(4, 1) NOT NULL,
    drag_coeficient NUMBER(4, 2) NOT NULL,
    rolling_resistence_coefficient NUMBER(4,2) NOT NULL,
    wheel_size NUMBER(4,2) NOT NULL,
    braking_energy_regeneration NUMBER(4, 2),
    frontal_area NUMBER(4, 2) NOT NULL,
    min_rpm NUMBER(4, 2) NOT NULL,
    max_rpm NUMBER(4, 2) NOT NULL,
    final_drive_ratio NUMBER(4, 2) NOT NULL,
    CONSTRAINT pk_vehicle PRIMARY KEY(name),
    CONSTRAINT fk_vehicle_road_network FOREIGN KEY(road_network_name) REFERENCES road_network(name),
    CONSTRAINT fk_vehicle_vehicle_motorization FOREIGN KEY(motorization) REFERENCES vehicle_motorization(motorization),
    CONSTRAINT fk_vehicle_vehicle_toll_class FOREIGN KEY(toll_class) REFERENCES vehicle_toll_class(toll_class),
    CONSTRAINT fk_vehicle_vehicle_type FOREIGN KEY(TYPE) REFERENCES vehicle_type(TYPE),
    CONSTRAINT fk_vehicle_fuel_type FOREIGN KEY(fuel_type) REFERENCES fuel_type(TYPE)
);
 
CREATE TABLE regime (
    throttle_id NUMBER(3),
    vehicle_name VARCHAR(20),
    rpm_high NUMBER(4, 2),
    rpm_low NUMBER(4, 2),
    torque NUMBER(4, 2) NOT NULL,
    sfc NUMBER(4,2),
    CONSTRAINT pk_regime PRIMARY KEY(throttle_id, vehicle_name, rpm_high, rpm_low),
    CONSTRAINT fk_regime_throttle_id FOREIGN KEY(throttle_id) REFERENCES throttle_id(id),
    CONSTRAINT fk_regime_vehicle FOREIGN KEY(vehicle_name) REFERENCES vehicle(name)
);
 
CREATE TABLE network_analysis (
    vehicle_name VARCHAR(20),
    best_path_algorithm VARCHAR(40),
    toll_costs NUMBER(4, 2) NOT NULL,
    travelling_time VARCHAR(8),
    energy_consumption NUMBER(5, 2) NOT NULL,
    sections_list VARCHAR(200),
    CONSTRAINT fk_network_analysis_best_path_algorithm FOREIGN KEY(best_path_algorithm) REFERENCES best_path_algorithm(best_path_algorithm),
    CONSTRAINT fk_netword_analysis_vehicle FOREIGN KEY(vehicle_name) REFERENCES vehicle(name),
    CONSTRAINT pk_network_analysis PRIMARY KEY(vehicle_name, best_path_algorithm)
);
 
 
CREATE TABLE road(
    name VARCHAR(10),
    road_network_name VARCHAR(20),
    typology VARCHAR(20),
    CONSTRAINT fk_road_road_network FOREIGN KEY(road_network_name) REFERENCES road_network(name),
    CONSTRAINT pk_road PRIMARY KEY(name),
    CONSTRAINT fk_road_road_typology FOREIGN KEY(typology) REFERENCES road_typology(typology)
);
 
CREATE TABLE node(
    id VARCHAR(5),
    road_network_name VARCHAR(10),
    has_toll CHAR(1),
    CONSTRAINT pk_node PRIMARY KEY(id),
    CONSTRAINT fk_node_road_network FOREIGN KEY(road_network_name) REFERENCES road_network(name)
);
 
CREATE TABLE vehicle_velocity_limit (
    velocity_limit NUMBER(4, 2) NOT NULL,
    vehicle_name VARCHAR(20),
    road_typology VARCHAR(30),
    CONSTRAINT pk_vehicle_velocity_limit PRIMARY KEY(vehicle_name, road_typology),
    CONSTRAINT fk_vehicle_velocity_limit_vehicle FOREIGN KEY(vehicle_name) REFERENCES vehicle(name),
    CONSTRAINT fk_vehicle_velocity_limit_road_typology FOREIGN KEY(road_typology) REFERENCES road_typology(typology)
);
 
 
CREATE TABLE SECTION(
    id NUMBER(10) DEFAULT seq_section_id.NEXTVAL,
    road_name VARCHAR(10),
    direction VARCHAR(30),
    ending_node VARCHAR(5),
    begining_node VARCHAR(5),
    CONSTRAINT pk_section PRIMARY KEY(id),
    CONSTRAINT fk_section_road FOREIGN KEY(road_name) REFERENCES road(name),
    CONSTRAINT fk_section_section_direction FOREIGN KEY(direction) REFERENCES section_direction(direction),
    CONSTRAINT fk_section_ending_node FOREIGN KEY(ending_node) REFERENCES node(id),
    CONSTRAINT fk_section_begining_node FOREIGN KEY(begining_node) REFERENCES node(id)
);
 
CREATE TABLE segment(
    order_in_section NUMBER(10),
    section_id NUMBER(10),
    has_toll CHAR(1),
    initial_height NUMBER(4,2) NOT NULL,
    slope NUMBER(4,2) NOT NULL,
    LENGTH NUMBER(4,2) NOT NULL,
    wind_direction NUMBER(4,2) NOT NULL,
    wind_speed NUMBER(4,2) NOT NULL,
    maximum_velocity NUMBER(4,2) NOT NULL,
    minimum_velocity NUMBER(4,2) NOT NULL,
    final_height NUMBER(4,2) NOT NULL,
    CONSTRAINT pk_segment PRIMARY KEY(order_in_section, section_id),       
    CONSTRAINT fk_segment_section FOREIGN KEY(section_id) REFERENCES SECTION(id)
);
 
CREATE TABLE toll_fare (
    vehicle_toll_class NUMBER(10),
    road_name VARCHAR(10),
    price NUMBER(4, 2) NOT NULL,
    CONSTRAINT fk_toll_fare_vehicle_toll_class FOREIGN KEY(vehicle_toll_class) REFERENCES vehicle_toll_class(toll_class),
    CONSTRAINT fk_toll_fare_road FOREIGN KEY(road_name) REFERENCES road(name),
    CONSTRAINT pk_toll_fare PRIMARY KEY(vehicle_toll_class, road_name)
);
 
CREATE TABLE gear (
    id NUMBER(10),
    CONSTRAINT pk_gear PRIMARY KEY(id)
);
 
CREATE TABLE gear_ratio (
    gear_id NUMBER(10),
    vehicle_name VARCHAR(20),
    ratio NUMBER(4, 2) NOT NULL,
    CONSTRAINT pk_gear_ratio PRIMARY KEY(gear_id, vehicle_name),
    CONSTRAINT fk_gear_ratio_gear FOREIGN KEY(gear_id) REFERENCES gear(id),
    CONSTRAINT fk_gear_ratio_vehicle FOREIGN KEY(vehicle_name) REFERENCES vehicle(name)
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