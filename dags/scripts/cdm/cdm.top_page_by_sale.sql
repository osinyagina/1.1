-- «адача по 3 количество продаж со страниц

insert into cdm.top_page_by_sale
(
	page_url,
	purchase_num
)
select 
	 page_url, count(*)
from (

select
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
where 
	a.is_confirmation =True
group by page_url

on conflict (page_url) do update
set
	purchase_num = excluded.purchase_num
;



-- «адача по 3   с разложением по времени



insert into cdm.top_page_by_sale_ts
(
	ts_timestamp, ts_year, ts_month, ts_day, ts_hour, page_url, purchase_num
)

select 
	 t.ts_timestamp,
	 t.ts_year,
	 t.ts_month,
	 t.ts_day,
	 t.ts_hour,
	 page_url, 
	 count(*) purchase_num
from (

select
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
where 
	a.is_confirmation =True
group by 	 
	 t.ts_timestamp,
	 t.ts_year,
	 t.ts_month,
	 t.ts_day,
	 t.ts_hour,
	 page_url

on conflict (page_url, ts_timestamp) do update
set
	purchase_num = excluded.purchase_num
;