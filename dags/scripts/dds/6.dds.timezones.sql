--- На самом деле не нужная таблица
insert into dds.timezones
(
	timezone
)
select 
	timezone
from
	(
	select
		distinct os_timezone  timezone
	from 
		stg.events e  
	--where
	--	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days'
	union 
	select
		distinct geo_timezone timezone
	from 
		stg.events e  	
	--where
	--	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days'
	) a 
where 
	a.timezone not in (select timezone from dds.timezones);
	
