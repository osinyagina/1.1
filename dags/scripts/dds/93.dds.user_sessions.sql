-- Сейссии пользователей
insert into dds.user_sessions  
(
	user_id,
	user_domain_id,
	click_id,
	geo_location_id,
	browser_id,
	ip_address,
	os_id,
	timezone_id,
	device_type_id
)

select 
	u.user_id,
	user_domain_id,
	click_id,
	gl.geo_location_id,
	b.browser_id,
	ip_address,
	o.os_id,
	t.timezone_id,
	dd.device_id
from 
	(
		select
			distinct 
			e.user_custom_id,
			e.user_domain_id,
			click_id,
			geo_latitude,
			geo_longitude,
			coalesce(geo_timezone, os_timezone) geo_timezone,
			device_type,
			browser_name,
			os_name,
			ip_address
		from 
			stg.events e  			
		where 
			e.user_domain_id not in (select user_domain_id from dds.user_sessions)
			-- and	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days'

	) as  a
	left join dds.users u 
		on a.user_custom_id = u.user_custom_id 
	 left join dds.geo_locations gl 
	 	on a.geo_longitude = gl.geo_longitude and 
		   a.geo_latitude = gl.geo_latitude 
	left join dds.browsers b
		on a.browser_name = b.browser_name
	left join dds.oss o
		on a.os_name = o.os_name
	left join dds.timezones t  
		on a.geo_timezone = t.timezone
	left join dds.device_types dd 
		on a.device_type = dd.device_type 
;



