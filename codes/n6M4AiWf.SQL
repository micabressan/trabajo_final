CREATE DATABASE IF NOT EXISTS water_supply;
USE water_supply;

CREATE TABLE IF NOT EXISTS services # Таблица 1
(service_id INT NOT NULL auto_increment,
service_name VARCHAR (45),
service_pricends NUMERIC (5,2),
service_price NUMERIC (5,2),
PRIMARY KEY(service_id)
);
CREATE TABLE IF NOT EXISTS subscribers # Таблица 2 
(
subscriber_id INT NOT NULL auto_increment,
subscriber_surname VARCHAR (30),
subscriber_name VARCHAR (30),
subscriber_patronymic VARCHAR (30),
subscriber_homephone VARCHAR (6),
subscriber_cellphone VARCHAR(12),
subscriber_address VARCHAR (100),
subscriber_birthday DATE,
subscriber_balance NUMERIC (5,2),
PRIMARY KEY(subscriber_id)
);

CREATE TABLE IF NOT EXISTS rates # Тарифы # Табица 3
(
rate_id INT NOT NULL auto_increment,
rate_name VARCHAR (30),
rate_mothprice VARCHAR (30), # Месячная цена тарифа руб/м^3
rate_nds BOOLEAN,
rate_validity_begin DATE, # Период действия тарифов с начала
rate_validity_end DATE, # Период действия тарифа до конца

PRIMARY KEY (rate_id)
);
CREATE TABLE IF NOT EXISTS transactions # Таблица 4
(
transaction_id INT NOT NULL auto_increment,
transaction_value NUMERIC (5,2),
transaction_date DATE,
transaction_place VARCHAR (30),
transaction_status BOOLEAN,

PRIMARY KEY (transaction_id)
);

CREATE TABLE IF NOT EXISTS accounting_devices # Приборы учёта # Таблица 5
(
id_acc_dev INT NOT NULL auto_increment, # Уникальный ID для прибора
dev_name VARCHAR (30), # Название прибора
dev_type VARCHAR (30), # Тип счётчика
is_active BOOLEAN, # Активен ?
dev_mount_date DATE, # Дата установки счётчика
dev_unit VARCHAR (3), #Еденица измерения
dev_index NUMERIC (5,2), # Показатель счётчика
dev_accuracy_class NUMERIC (5,2), # Класс точности прибора
dev_callibration_interval NUMERIC (5), # Межповерочный интервал
dev_life_time NUMERIC (5), # Срок службы

PRIMARY KEY (id_acc_dev)
);

CREATE TABLE IF NOT EXISTS accident # Таблица 6
(
accident_id INT NOT NULL auto_increment,
accident_name VARCHAR (30),
begin_date_repair DATE,
end_date_repair DATE,
accident_location VARCHAR (35),
PRIMARY KEY (accident_id)
);

CREATE TABLE IF NOT EXISTS open_hatch # Таблица 7 Сообщения об открытых люках
(
declaration_id INT NOT NULL auto_increment,
declarant_name VARCHAR (30),
declarant_email VARCHAR (30),
declarant_phone VARCHAR (15),
hatch_address VARCHAR (30),
declarant_comment VARCHAR (500),
declarant_attachment VARCHAR (100),
PRIMARY KEY (declaration_id)
);

CREATE TABLE IF NOT EXISTS statements_entities  # Таблица 8 Заявление на подключение физических и юридических лиц
(
statement_id INT NOT NULL auto_increment,
customer_type VARCHAR (30),
chief_enginer VARCHAR (70),
building_info VARCHAR (300),
address VARCHAR (300),
usingplan VARCHAR (300),
planned_connectiondate DATE, # Дата подключения к сетям
planned_startdate DATE, # Дата начала эксплуатации
customer_surname VARCHAR (50),
customer_name VARCHAR (50),
customer_patronymic VARCHAR (50),
customer_phone VARCHAR (12),
aproved BOOLEAN,

PRIMARY KEY (statement_id)
);

CREATE TABLE IF NOT EXISTS