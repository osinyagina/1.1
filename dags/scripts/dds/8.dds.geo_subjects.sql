-- Страны и регионы
insert into dds.geo_subjects 
(
	geo_country,
	geo_region_name 
)
	select
		distinct 
		e.geo_country,
		e.geo_region_name 
	from 
		stg.events e  
		left join dds.geo_subjects s	
			on e.geo_country = s.geo_country  and e.geo_region_name = s.geo_region_name 
	where
		s.geo_subject_id is null
	--	and event_timestamp between DATE_TRUNC('DAY','{ds}') and DATE_TRUNC('DAY','{ds}') + interval '1 days' 
 

;
