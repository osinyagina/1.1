insert into cdm.utm_source_share (
	ts_timestamp,
	ts_year,
	ts_month,
	ts_day,
	ts_hour, 
	utm_source, 
	user_count
)

(select 
	t.ts_timestamp,
	t.ts_year,
	t.ts_month,
	t.ts_day,
	t.ts_hour, 
	utm_source, 
	count(distinct user_id) user_count
from 
	dds.site_events se 
	inner join dds.utms u 
		on se.utm_id = u.utm_id 
	inner join dds.user_sessions us 
		on se.session_id  = us.session_id 
	inner join dds.timestamps t 
		on se.event_timestamp_id = t.timestamp_id 
group by 
	t.ts_timestamp,
	t.ts_year,
	t.ts_month,
	t.ts_day,
	t.ts_hour, 
	utm_source
)
on conflict (ts_timestamp, utm_source) do update 
set
	user_count = excluded.user_count
;