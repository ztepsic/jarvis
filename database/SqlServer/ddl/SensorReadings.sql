use ztepsicc_jarvis;
go

create table dbo.SensorReadings (
	Id int identity(1, 1)
		constraint PK_SensorReadings_Id primary key
,	RoomId int not null
,	DeviceId int not null
,	SensorId int not null
,	ReadingDateTime datetime2 not null
,	ValueTypeId int not null
,	Value decimal
,	constraint FK_SensorReadings_RoomId
		foreign key (RoomId) references dbo.Rooms(Id)
			on delete no action
			on update cascade
,	constraint FK_SensorReadings_DeviceId
		foreign key (DeviceId) references dbo.Devices(Id)
			on delete no action
			on update cascade
,	constraint FK_SensorReadings_SensorId
		foreign key (SensorId) references dbo.Sensors(Id)
			on delete no action
			on update cascade
,	constraint FK_SensorReadings_ValueTypeId
		foreign key (ValueTypeId) references dbo.SensorValueTypes(Id)
			on delete no action
			on update cascade
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains sensor readings',
								@level1type=N'TABLE', @level1name=N'SensorReadings',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'RoomId',
								@name=N'MS_Description', @value=N'Room identifier',
								@level1type=N'TABLE', @level1name=N'SensorReadings',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'DeviceId',
								@name=N'MS_Description', @value=N'Device identifier',
								@level1type=N'TABLE', @level1name=N'SensorReadings',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorId',
								@name=N'MS_Description', @value=N'Sensor identifier',
								@level1type=N'TABLE', @level1name=N'SensorReadings',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'ReadingDateTime',
								@name=N'MS_Description', @value=N'Entry date and time - reading date and time',
								@level1type=N'TABLE', @level1name=N'SensorReadings',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Value',
								@name=N'MS_Description', @value=N'Sensor value',
								@level1type=N'TABLE', @level1name=N'SensorReadings',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go

alter table dbo.SensorReadings
	add constraint IX_SensorReadings_RoomIdValueTypeIdReadingDateTime unique(RoomId, ValueTypeId, ReadingDateTime);
go
