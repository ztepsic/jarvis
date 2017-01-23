use ztepsicc_jarvis;
go

create table dbo.RoomSensors (
	Id int identity(1, 1)
		constraint PK_RoomSensor_Id primary key
,	RoomId int not null
,	SensorId int not null
,	SensorAssignedFrom datetime2 not null
,	SensorAssignedTill datetime2
,	constraint FK_RoomSensors_RoomId
		foreign key (RoomId) references dbo.Rooms(Id)
			on delete cascade
			on update cascade
,	constraint FK_RoomSensors_SensorId
		foreign key (SensorId) references dbo.Sensors(Id)
			on delete cascade
			on update cascade
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains room sensors',
								@level1type=N'TABLE', @level1name=N'RoomSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'RoomSensor identifier',
								@level1type=N'TABLE', @level1name=N'RoomSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'RoomId',
								@name=N'MS_Description', @value=N'Room identifier',
								@level1type=N'TABLE', @level1name=N'RoomSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorId',
								@name=N'MS_Description', @value=N'Sensor identifier',
								@level1type=N'TABLE', @level1name=N'RoomSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorAssignedFrom',
								@name=N'MS_Description', @value=N'Sensor assigned to room from date',
								@level1type=N'TABLE', @level1name=N'RoomSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorAssignedTill',
								@name=N'MS_Description', @value=N'Sensor assigned to room till date',
								@level1type=N'TABLE', @level1name=N'RoomSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go

alter table dbo.RoomSensors
	add constraint UX_RoomSensors_RoomIdSensorId unique(RoomId, SensorId);
go