CREATE TABLE if not exists cdm.event_by_ts_bd (
	id serial4 NOT NULL,
	ts_timestamp timestamp NULL,
	ts_year int2 NULL,
	ts_month int2 NULL,
	ts_day int2 NULL,
	ts_hour int2 NULL,
	browser_name varchar(32),
	device_type varchar(16),
	device_is_mobile boolean,
	event_num int4 NULL,
	purchase_num int4 NULL,
	CONSTRAINT event_by_ts_bd_pkey PRIMARY KEY (id),
	CONSTRAINT event_by_ts_bd_un UNIQUE (ts_timestamp, browser_name, device_type, device_is_mobile)
);


CREATE TABLE if not exists cdm.utm_source_share (
	ts_timestamp timestamp NOT NULL,
	ts_year int2 NULL,
	ts_month int2 NULL,
	ts_day int2 NULL,
	ts_hour int2 NULL,
	utm_source varchar(128) NOT NULL,
	user_count int4 NULL,
	CONSTRAINT utm_source_share_pk PRIMARY KEY (ts_timestamp, utm_source)
);


create table if not exists cdm.top_page_by_sale (
	page_url varchar(128),
	purchase_num int
)

create table  if not exists top_page_by_sale_ts (
	ts_timestamp timestamp,
	ts_year int2,
	ts_month int2,
	ts_day int2,
	ts_hour int2,
	page_url varchar(128),  
	purchase_num int
);


CREATE TABLE if not exists cdm.event_by_ts (
	id serial4 NOT NULL,
	ts_timestamp timestamp NULL,
	ts_year int2 NULL,
	ts_month int2 NULL,
	ts_day int2 NULL,
	ts_hour int2 NULL,
	event_num int4 NULL,
	purchase_num int4 NULL,
	CONSTRAINT event_by_ts_pkey PRIMARY KEY (id),
	CONSTRAINT event_by_ts_un UNIQUE (ts_timestamp)
);

CREATE TABLE if not exists cdm.event_by_ts_bd (
	id serial4 NOT NULL,
	ts_timestamp timestamp NULL,
	ts_year int2 NULL,
	ts_month int2 NULL,
	ts_day int2 NULL,
	ts_hour int2 NULL,
	browser_name varchar(32),
	device_type varchar(16),
	device_is_mobile boolean,
	event_num int4 NULL,
	purchase_num int4 NULL,
	CONSTRAINT event_by_ts_bd_pkey PRIMARY KEY (id),
	CONSTRAINT event_by_ts_bd_un UNIQUE (ts_timestamp, browser_name, device_type, device_is_mobile)
);


