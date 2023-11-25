-- пользователи
insert into dds.users 
(
	user_custom_id	
)
	select
		distinct 
		user_custom_id
	from 
		stg.events e  
	--where
	--	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days' 
 
where 	
	user_custom_id not in (select 	user_custom_id from dds.users)
;
