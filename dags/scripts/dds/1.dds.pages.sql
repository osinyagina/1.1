-- Названия страницы
insert into dds.pages  (
 	page_url,
	page_url_path,
	is_payment,
	is_confirmation,
	is_cart
	)


select 
	distinct 
 	page_url,
	page_url_path,
	case when page_url_path = '/payment' then true else false end is_payment,
	case when page_url_path = '/confirmation' then true else false end is_confirmation,
	case when page_url_path = '/cart' then true else false end is_cart	
  
from 
	stg.events e 

where 
	page_url not in (select page_url from  dds.pages )
--	and event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days';

	

	
	