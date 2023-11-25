-- Заполнить дати с часами
insert into dds.timestamps 
(
	ts_timestamp, 
	ts_year, 
	ts_month,
	ts_day,
	ts_hour	
)
select 
	distinct 
	DATE_TRUNC('HOUR', event_timestamp) ts_timestamp, 
	EXTRACT(YEAR from event_timestamp) ts_year, 
	EXTRACT(MONTH from event_timestamp) ts_month,
	EXTRACT(DAY from event_timestamp) ts_day,
	EXTRACT(HOUR from event_timestamp) ts_hour	
from 
	stg.events e 
where 
--	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days'
	DATE_TRUNC('HOUR', event_timestamp) not in (
		select 
			ts_timestamp
		from
			dds.timestamps t 
	);
