CREATE DATABASE IF NOT EXISTS water_supply;
USE water_supply;

CREATE TABLE IF NOT EXISTS services
(service_id INT NOT NULL auto_increment,
service_name VARCHAR (45),
service_price NUMERIC (5,2),
PRIMARY KEY(service_id)
);
CREATE TABLE IF NOT EXISTS subscribers
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
PRIMARY KEY(subsriber_id)
);

CREATE TABLE IF NOT EXISTS rates # Тарифы
(
rate_id INT NOT NULL auto_increment,

);
CREATE TABLE IF NOT EXISTS transactions
(
transaction_id INT NOT NULL auto_increment,
transaction_value NUMERIC (5,2),
transaction_date DATE,
transaction_place VARCHAR (30),
transaction_status BOOLEAN,

PRIMARY KEY (transaction_id)
);

CREATE TABLE IF NOT EXISTS accounting_devices # Приборы учёта
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