drop database credite;
create database credite;

USE credite;

CREATE TABLE users (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'Идентификатор строки', -- искуственный ключ
	first_name VARCHAR(100) NOT NULL COMMENT 'Имя Клиента',
    last_name VARCHAR(100) NOT NULL COMMENT 'Фамилия Клиента',
    birthday DATE NOT NULL COMMENT 'Дата рождения',
    id_nr VARCHAR(13) NOT NULL COMMENT 'фискальный код Клиента',
    gender ENUM('M', 'F') NOT NULL COMMENT 'Пол',
    email VARCHAR(100) NOT NULL UNIQUE COMMENT 'Email Клиента',  -- email + phone - натуральный ключ
    phone VARCHAR(11) NOT NULL UNIQUE COMMENT 'Номер телефона Клиента',    
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки'
) COMMENT 'Таблица Клиента';

CREATE TABLE profiles (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
	city VARCHAR(100) COMMENT 'Город проживания',
    activiti ENUM ('smalholders', 'startap', 'youth', 'employee') NOT NULL COMMENT 'род занятия',
    country VARCHAR(100) COMMENT 'Страна проживания', 
    marital_status ENUM( 'married', 'unmarried') COMMENT 'Статус',
    studies ENUM('scool', 'university') COMMENT ' знания',
	created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время создания строки',    
    updated_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время обновленния строки'
) COMMENT "Таблица профилей";

CREATE TABLE employees (
    user_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
	posture VARCHAR(100) COMMENT 'Долженость',
    filial VARCHAR(100) COMMENT 'филиал служащего',    
    `status` ENUM('Online', 'Offline', 'Inactive') NOT NULL,
	created_at  DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата трудоустройства',    
    phone VARCHAR(11) NOT NULL UNIQUE COMMENT 'Номер телефона служишего'
) COMMENT "Таблица служишего";

CREATE TABLE fidejusors (
	fid_id INT UNSIGNED NOT NULL PRIMARY KEY COMMENT 'Идентификатор строки',
	user_id INT UNSIGNED NOT NULL COMMENT 'Ссылка на Клиента',
        orders_products_id INT UNSIGNED NOT NULL COMMENT 'Кредитное заявление'
    );

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  suma_cred INT UNSIGNED NOT NULL COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, id) COMMENT 'Составной первичный ключ'
) COMMENT = 'кредитное заевление';

CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name ENUM( 'ipoteca', 'agro', 'business') COMMENT 'Название',
  desription TEXT COMMENT 'Описание',
  interest DECIMAL (11,2) COMMENT 'Проценнтнная ставка',
  comission DECIMAL (11,2) COMMENT 'Комиссия',
  penalty DECIMAL (11,2) COMMENT 'Пеня',
  order_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) COMMENT = 'кредитные продукты';

