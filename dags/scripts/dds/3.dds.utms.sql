-- Названия рекламные кампании
 insert into dds.utms (utm_medium,
	utm_source,
	utm_content,
	utm_campaign
	)
select 
	distinct 
	e.utm_medium,
	e.utm_source,
	e.utm_content,
	e.utm_campaign 
from 
	stg.events e 
	left join dds.utms u 
		on e.utm_medium = u.utm_medium and
		   e.utm_source = u.utm_source and
		   e.utm_content = u.utm_content and
		   e.utm_campaign  = u.utm_campaign
where 
	u.utm_id is null
--	and event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days';

	
