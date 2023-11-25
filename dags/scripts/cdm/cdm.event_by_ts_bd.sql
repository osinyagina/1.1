insert into cdm.event_by_ts_bd (
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day, 
	ts_hour ,
	browser_name,
	device_type,
	device_is_mobile, 
	event_num,
    purchase_num
)


(select 
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day, 
	ts_hour ,
	b.browser_name,
	dd.device_type,
	dd.device_is_mobile, 
	count(event_id) event_num,
	count(case when p.is_confirmation = true then 1 end) purchase_num
from
	dds.site_events se 
	inner join dds.timestamps t 
		on se.event_timestamp_id = t.timestamp_id 
	inner join dds.pages p
		on se.page_id = p.page_id  and p.is_confirmation = true
	inner join dds.user_sessions us  
		on us.session_id  = se.session_id 
	inner join dds.browsers b 
		on us.browser_id = b.browser_id 
	inner join dds.device_types dd   
		on us.device_type_id  = dd.device_id 
group by 
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day, 
	ts_hour,
	b.browser_name,
	dd.device_type,
	dd.device_is_mobile
)
on conflict (ts_timestamp, browser_name, device_type, device_is_mobile) 
do update 
set
	event_num = excluded.event_num,
	purchase_num = excluded.purchase_num;


