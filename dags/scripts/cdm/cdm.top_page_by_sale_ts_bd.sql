insert into cdm.top_page_by_sale_ts_bd 
(
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day,
	ts_hour,
    browser_name,
	device_type,
	device_is_mobile, 
	page_url, 
	purchase_num
)
(
select 
	 t.ts_timestamp,
	 t.ts_year,
	 t.ts_month,
	 t.ts_day,
	 t.ts_hour,
     browser_name,
	 device_type,
	 device_is_mobile, 
	 page_url, 
	 count(*) purchase_num
from (

select
	session_id,
	DATE_TRUNC('HOUR', event_timestamp) event_timestamp,
	is_confirmation,
	case when (is_confirmation = true) then
	
	LAST_VALUE 
		(
		case when is_cart =false
		and is_payment = false then 
		page_url		
		end
	) over (
		partition by session_id 
		order by extract(epoch from event_timestamp)
		RANGE BETWEEN UNBOUNDED PRECEDING and 1 PRECEDING 
	)
	end page_url	

from 	
	(select 
		distinct session_id,site_event_id, event_timestamp, is_confirmation, page_url, is_cart, is_payment
	 from 
		dds.site_events se 
		inner join dds.pages p 
			on se.page_id = p.page_id 
	where 
		is_cart=false
		and is_payment = false
	) a 
) a
	inner join dds.timestamps t 
		on a.event_timestamp = t.ts_timestamp 
	inner join dds.user_sessions us  
		on us.session_id  = a.session_id 
	inner join dds.browsers b 
		on us.browser_id = b.browser_id 
	inner join dds.device_types dd   
		on us.device_type_id  = dd.device_id	
	
where 
	a.is_confirmation =True
group by 	 
	 t.ts_timestamp,
	 t.ts_year,
	 t.ts_month,
	 t.ts_day,
	 t.ts_hour,
     browser_name,
	 device_type,
	 device_is_mobile, 
	 page_url
)
on conflict  (ts_timestamp, browser_name, device_type, device_is_mobile, page_url)
do update 
set purchase_num = excluded.purchase_num;