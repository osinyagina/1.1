-- Названия браузеров
insert into dds.browsers (browser_name)
select 
	distinct 
	browser_name
from 
	stg.events e 
where 
--	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days'
	browser_name not in (
		select 
			browser_name
		from
			dds.browsers t 
	);
	
