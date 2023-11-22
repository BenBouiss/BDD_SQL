DROP TABLE IF EXISTS agency ;
DROP TABLE IF EXISTS routes ;
DROP TABLE IF EXISTS trips ;
DROP TABLE IF EXISTS stop_times ;
DROP TABLE IF EXISTS stops ;

CREATE TABLE agency (
	agency_id varchar(255) ,
	agency_name varchar(255) ,
	
	agency_url varchar(255) ,
	agency_timezone varchar(255) ,
	agency_lang varchar(255) ,
	agency_phone varchar(255) ,
	agency_fare_url varchar(255) ,
	agency_email varchar(255) ,

	PRIMARY KEY (agency_id)
);

CREATE TABLE routes (
	route_id varchar(255) ,
	uid varchar(255) ,
	agency_id varchar(255) ,
	trip_id varchar(255) ,
	
	route_short_name varchar(255) ,
	route_long_name varchar(255) ,
	route_type varchar(255) ,
	route_url varchar(255) ,
	route_color varchar(255) ,
	route_text_color varchar(255) ,
	
	route_sort_order int4 NULL,
	continuous_pickup int4 NULL,
	continuous_drop_off int4 NULL,
	
	CONSTRAINT route_pk PRIMARY KEY (route_id),
	CONSTRAINT route_agency_fk FOREIGN KEY (agency_id) REFERENCES agency(agency_id)

);

CREATE UNIQUE INDEX route_id_idx ON routes(route_id) ;

CREATE TABLE trips(
	trip_id varchar(255) ,
	route_id varchar(255) ,
	service_id varchar(255) ,
	trip_headsign varchar(255) ,
	trip_short_name varchar(255) ,
	block_id varchar(255) ,
	shape_id varchar(255) ,
	
	direction_id int4 NULL,
	continuous_drop_off int4 NULL,
	wheelchair_accessible int4 NULL,
	bikes_allowed int4 NULL,
	
	CONSTRAINT trip_pk PRIMARY KEY (trip_id),
	CONSTRAINT trip_route_fk FOREIGN KEY (route_id) REFERENCES routes(route_id)
);
CREATE UNIQUE INDEX trip_id_idx ON trips(trip_id) ;

CREATE TABLE stop_times(
	trip_id varchar(255) ,
	stop_times_id varchar(255) ,
	stop_headsign varchar(255) ,
	stop_id varchar(255) ,

	departure_time time ,
	arrival_time time ,
	
	stop_sequence int4 NULL,
	pickup_type int4 NULL,
	drop_off_type int4 NULL,
	continuous_pickup int4 NULL,
	continuous_drop_off int4 NULL,
	timepoint int4 NULL,
	
	shape_dist_traveled float4 NULL,
	
	CONSTRAINT stop_times_pk PRIMARY KEY (stop_times_id),
	CONSTRAINT stop_times_trips_fk FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
	CONSTRAINT stops_stoptimes_fk FOREIGN KEY (stop_id) REFERENCES stops(stop_id)
);
CREATE UNIQUE INDEX stop_times_id_idx ON stop_times(stop_times_id) ;

CREATE TABLE stops(
	stop_times_id varchar(255) ,
	stop_id varchar(255) ,
	
	stop_code varchar(255) ,
	stop_name varchar(255) ,
	stop_desc varchar(255) ,
	zone_id varchar(255) ,
	stop_url varchar(255) ,
	platform_code varchar(255) ,
	parent_station varchar(255) ,
	
	stop_lat float4 NULL,
	stop_lon float4 NULL,
	location_type int4 NULL,
	wheelchair_boarding int4 NULL,
	level_id int4 NULL,
	
	stop_timezone time ,
	
	CONSTRAINT stop_pk PRIMARY KEY (stop_id)
);
CREATE UNIQUE INDEX stops_id_idx ON stops(stop_id) ;