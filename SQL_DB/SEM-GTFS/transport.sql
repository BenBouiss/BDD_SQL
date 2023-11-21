DROP TABLE IF EXISTS agency ;
DROP TABLE IF EXISTS routes ;
DROP TABLE IF EXISTS trips ;
DROP TABLE IF EXISTS stop_times ;
DROP TABLE IF EXISTS stops ;

CREATE TABLE agency (
	agency_id varchar(255) NOT NULL,
	agency_name varchar(255) NOT NULL,
	
	agency_url varchar(255) NOT NULL,
	agency_timezone varchar(255) NOT NULL,
	agency_lang varchar(255) NOT NULL,
	agency_phone varchar(255) NOT NULL,
	agency_fare_url varchar(255) NOT NULL,
	agency_email varchar(255) NOT NULL,
	
	CONSTRAINT agency_pkey PRIMARY KEY (agency_id)
);

CREATE TABLE routes (
	route_id varchar(255) NOT NULL,
	uid varchar(255) NOT NULL,
	agency_id varchar(255) NOT NULL,
	trip_id varchar(255) NOT NULL,
	
	route_short_name varchar(255) NOT NULL,
	route_long_name varchar(255) NOT NULL,
	route_desc varchar(255) NOT NULL,
	route_url varchar(255) NOT NULL,
	route_color varchar(255) NOT NULL,
	route_text_color varchar(255) NOT NULL,
	
	route_sort_order int4 NULL,
	continuous_pickup int4 NULL,
	continuous_drop_off int4 NULL,
	
	CONSTRAINT route_pk PRIMARY KEY (route_id),
	CONSTRAINT route_agency_fk FOREIGN KEY (agency_id) REFERENCES agency(agency_id)

);

CREATE UNIQUE INDEX route_id_idx ON routes(route_id) ;

CREATE TABLE trips(
	trip_id varchar(255) NOT NULL,
	route_id varchar(255) NOT NULL,
	service_id varchar(255) NOT NULL,
	trip_headsign varchar(255) NOT NULL,
	trip_short_name varchar(255) NOT NULL,
	block_id varchar(255) NOT NULL,
	shape_id varchar(255) NOT NULL,
	
	direction_id int4 NULL,
	continuous_drop_off int4 NULL,
	wheelchair_accessible int4 NULL,
	bikes_allowed int4 NULL,
	
	CONSTRAINT trip_pk PRIMARY KEY (trip_id),
	CONSTRAINT trip_route_fk FOREIGN KEY (route_id) REFERENCES routes(route_id)
);
CREATE UNIQUE INDEX trip_id_idx ON trips(trip_id) ;

CREATE TABLE stop_times(
	trip_id varchar(255) NOT NULL,
	stop_times_id varchar(255) NOT NULL,
	stop_headsign varchar(255) NOT NULL,

	departure_time time NOT NULL,
	arrival_time time NOT NULL,
	
	stop_sequence int4 NULL,
	pickup_type int4 NULL,
	drop_off_type int4 NULL,
	continuous_pickup int4 NULL,
	continuous_drop_off int4 NULL,
	timepoint int4 NULL,
	
	shape_dist_traveled float4 NULL,
	
	CONSTRAINT stop_times_pk PRIMARY KEY (stop_times_id),
	CONSTRAINT stop_times_trips_fk FOREIGN KEY (trip_id) REFERENCES trips(trip_id)
);
CREATE UNIQUE INDEX stop_times_id_idx ON stop_times(stop_times_id) ;

CREATE TABLE stops(
	stop_times_id varchar(255) NOT NULL,
	stops_id varchar(255) NOT NULL,
	
	stop_code varchar(255) NOT NULL,
	stop_name varchar(255) NOT NULL,
	stop_desc varchar(255) NOT NULL,
	zone_id varchar(255) NOT NULL,
	stop_url varchar(255) NOT NULL,
	platform_code varchar(255) NOT NULL,
	parent_station varchar(255) NOT NULL,
	
	stop_lat float4 NULL,
	stop_lon float4 NULL,
	location_type int4 NULL,
	wheelchair_boarding int4 NULL,
	level_id int4 NULL,
	
	stop_timezone time NOT NULL,
	
	CONSTRAINT stop_pk PRIMARY KEY (stops_id),
	CONSTRAINT stops_stoptimes_fk FOREIGN KEY (stop_times_id) REFERENCES trips(stop_times_id)
);
CREATE UNIQUE INDEX stops_id_idx ON stops(stops_id) ;