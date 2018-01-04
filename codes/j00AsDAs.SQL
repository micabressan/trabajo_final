drop table Ship;
drop table Port;
DROP SEQUENCE position_sequence;
DROP SEQUENCE id_sequence; 

CREATE SEQUENCE position_sequence 
    MINVALUE 111
    MAXVALUE 999
    INCREMENT BY 1;
    
CREATE SEQUENCE id_sequence 
    MINVALUE 1
    NOMAXVALUE
    INCREMENT BY 1;

create table Port (
    region INT PRIMARY KEY, 
    port_position INT,
    port_name VARCHAR(255) NOT NULL
);

INSERT INTO Port VALUES (1, 111, 'Minsk');
INSERT INTO Port VALUES (2, 122, 'Moscow');

create table Ship (
    ship_number INT PRIMARY KEY,
    ship_name VARCHAR(255) NOT NULL,
    year_of INT NOT NULL,
    displacement INT NOT NULL,
    port_region INT NOT NULL,
    FOREIGN KEY (port_region) references Port(region)
);


/
CREATE OR REPLACE PROCEDURE add_ship (ship_name VARCHAR, cur_name VARCHAR, year_of INT, displacement INT) AS
    number_of_ships INTEGER;
BEGIN
    INSERT INTO Ship values (id_sequence.NEXTVAL, ship_name, year_of, displacement, (SELECT region FROM Port where port_name = cur_name));
    SELECT COUNT(*) INTO number_of_ships FROM Ship;
    DBMS_OUTPUT.put_line('The number of ships is ' || number_of_ships);
END add_ship;
/
CREATE OR REPLACE FUNCTION get_distance (name1 VARCHAR, name2 VARCHAR) RETURN FLOAT AS
	first_port INT;
	second_port INT;
	x1 INT;
	x2 INT;
	y1 INT;
    y2 INT;
BEGIN
    select port_position INTO first_port from Port where port_name = name1;
    select port_position INTO second_port from Port where port_name = name2;
    y1 := mod(first_port, 10);
    y2 := mod(second_port, 10);
    x1 := mod(first_port, 100) / 10;
    x2 := mod(second_port, 100) / 10;
    RETURN sqrt(power(abs(x1-x2), 2) + power(abs(y1-y2), 2));
END get_distance;
/

declare ret float; 

BEGIN
    add_ship('Boat', 'Minsk', 1989, 100);
    ret := get_distance('Minsk', 'Moscow');
    DBMS_OUTPUT.put_line('The distance is: ' || ret);
END;