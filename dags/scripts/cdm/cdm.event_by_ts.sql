-- Подсчет количества событий

insert into cdm.event_by_ts (
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day, 
	ts_hour ,
	event_num,
    purchase_num
)
(select 
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day, 
	ts_hour ,
	count(event_id) event_num,
	count(case when p.is_confirmation = true then 1 end) purchase_num
from
	dds.site_events se 
	inner join dds.timestamps t 
		on se.event_timestamp_id = t.timestamp_id 
	left join dds.pages p
		on se.page_id = p.page_id  and p.is_confirmation = true
group by 
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day, 
	ts_hour
) on conflict (ts_timestamp) do update 
set
	event_num = excluded.event_num,
	purchase_num = excluded.purchase_num

	;



