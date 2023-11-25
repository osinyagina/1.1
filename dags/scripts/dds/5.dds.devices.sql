--- под вопросом
insert into dds.devices 
(
	device_type,
	device_is_mobile
)
	select
		distinct 
		device_type,
		device_is_mobile
	from 
		stg.events e  
	--where
	--	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days' 
 
where 
	device_type not in (select device_type from dds.devices)
	;
