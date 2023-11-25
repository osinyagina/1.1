create table if not exists dds.oss (
	os_id serial primary key,	
	os_name varchar(32)
);

create table if not exists dds.browsers (
	browser_id serial primary key,	
	browser_name varchar(32)
);

create table if not exists dds.geo_subjects (
	geo_subject serial primary key,	
	geo_country varchar(2),	
	geo_region_name varchar(32)
);

create table if not exists dds.utms (
	utm_id serial2 primary key,	
	utm_medium varchar(16),	
	utm_source varchar(128),
	utm_content varchar(32),
	utm_campaign varchar(32)
);

create table if not exists dds.referers (
	referer_id serial2 primary key,		
	referer_url varchar(32),
	referer_url_port int2,
	referer_medium varchar(16)
);

create table if not exists dds.pages (
	page_id serial primary key,
	page_url varchar(128),
	page_url_path varchar(128),
	is_payment boolean default false,
    is_confirmation boolean default false,
    is_cart boolean default false
);


create table if not exists dds.users (
	user_id serial primary key,
	user_custom_id varchar(128)

);

create table if not exists dds.locations (
	geo_location_id serial primary key,	
	geo_latitude float,
	geo_longitude float,	
	geo_subject_id int
);

create table if not exists dds.timezones (
	timezone_id serial primary key,	
	timezone varchar(32)	
);

create table if not exists dds.devices (
	device_id serial primary key,	
	device_type varchar(16),
	device_is_mobile boolean	
);

create table if not exists dds.user_sessions (
	session_id serial primary key,
	user_id int,
	user_domain_id UUID,
	click_id UUID,	
	geo_location_id int2,
	browser_id int2,
	ip_address varchar(16),
	os_id int2,	
	timezone_id int2,
	device_type_id int2	

);

create table if not exists dds.timestamps (
	timestamp_id serial primary key,
	timestamp_ts timestamp,
	year int2,
	month int2,
	day int2,
	hour int2
);

create table if not exists dds.site_events (
	site_event_id serial primary key,
	event_id UUID,
	event_timestamp timestamp,
	event_timestamp_id int,
	session_id int,
	page_id int2,
	referer_id int2,
	utm_id int2	

);



