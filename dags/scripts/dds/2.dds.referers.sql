-- Названия рекламные кампании
 insert into dds.referers  (
 	referer_url,
	referer_url_port,
	referer_medium 
	)
select 
	distinct 
	e.referer_url,
	e.referer_url_port,
	e.referer_medium  
from 
	stg.events e 
	left join dds.referers r 
		on  	
			e.referer_url = r.referer_url and
			e.referer_url_port = r.referer_url_port and
			e.referer_medium  = r.referer_medium
where 
	r.referer_id  is null
--	and event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days';
