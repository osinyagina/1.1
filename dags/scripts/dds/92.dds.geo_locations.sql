insert into dds.geo_locations 
(
	geo_latitude,
	geo_longitude,
	geo_subject_id
)

select 
	geo_latitude,
	geo_longitude,
	s.geo_subject_id 
from 
	(
		select
			distinct 
			e.geo_latitude,
			e.geo_longitude,
			e.geo_country,
			e.geo_region_name
		from 
			stg.events e  
			left join dds.geo_locations s	
				 on e.geo_latitude  = s.geo_latitude 
				 and e.geo_longitude = s.geo_longitude 
		where 
			s.geo_location_id is null
			-- and	event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days'

	) a left join dds.geo_subjects s
		on a.geo_country = s.geo_country  and a.geo_region_name = s.geo_region_name 
	

;


