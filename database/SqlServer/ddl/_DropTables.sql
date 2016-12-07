use ztepsicc_jarvis;
go

if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'SensorReadings')
)
	drop table SensorReadings;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'DeviceSensors')
)
	drop table DeviceSensors;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'Sensors')
)
	drop table Sensors;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'SensorModelCapabilities')
)
	drop table SensorModelCapabilities;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'SensorModels')
)
	drop table SensorModels;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'SensorValueTypes')
)
	drop table SensorValueTypes;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'SensorTypes')
)
	drop table SensorTypes;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'RoomDevices')
)
	drop table RoomDevices;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'Devices')
)
	drop table Devices;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'Rooms')
)
	drop table Rooms;


if(exists(select table_name
		  from INFORMATION_SCHEMA.TABLES
		  where TABLE_SCHEMA = 'dbo'
		  and	TABLE_NAME = 'Homes')
)
	drop table Homes;

go