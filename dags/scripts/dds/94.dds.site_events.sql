insert into dds.site_events 
(event_id, event_timestamp, event_timestamp_id, session_id, page_id, referer_id, utm_id)
(select 
	
	event_id,
	event_timestamp event_timestamp_id,
	t.timestamp_id,
	us.session_id,
	p.page_id,
	r.referer_id,
	u.utm_id
	
	
	
from 
	stg.events e 
	left join dds.timestamps t 
		on DATE_TRUNC('HOUR', event_timestamp) = t.ts_timestamp 
	left join dds.user_sessions us 
		on e.user_domain_id = us.user_domain_id 
	left join dds.pages p
		on e.page_url = p.page_url
	left join dds.referers r
		on e.referer_url = r.referer_url 
		   and e.referer_url_port = r.referer_url_port
		   and e.referer_medium = r.referer_medium
	left join dds.utms u 
		on e.utm_campaign = u.utm_campaign 
			and e.utm_content  = u.utm_content 
			and e.utm_source  = u.utm_source 
			and e.utm_medium  = u.utm_medium 
)		  
on conflict (event_id) do update 
set 
	event_timestamp = excluded.event_timestamp,
	event_timestamp_id = excluded.event_timestamp_id,
	session_id = excluded.session_id,
	page_id = excluded.page_id,
	referer_id = excluded.referer_id,
	utm_id = excluded.utm_id
	;