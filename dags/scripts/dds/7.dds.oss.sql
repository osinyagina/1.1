-- Названия операционок
insert into dds.oss (os_name)
select 
	distinct 
	os_name
from 
	stg.events e 
where 
--	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days'
	os_name not in (
		select 
			os_name
		from
			dds.oss t 
	);