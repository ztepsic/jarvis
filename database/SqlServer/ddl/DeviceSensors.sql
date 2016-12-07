use ztepsicc_jarvis;
go

create table dbo.DeviceSensors (
	Id int identity(1, 1)
		constraint PK_DeviceSensor_Id primary key
,	DeviceId int not null
,	SensorId int not null
,	SensorAssignedFrom datetime2 not null
,	SensorAssignedTill datetime2
,	constraint FK_DeviceSensors_DeviceId
		foreign key (DeviceId) references dbo.Devices(Id)
			on delete cascade
			on update cascade
,	constraint FK_DeviceSensors_SensorId
		foreign key (SensorId) references dbo.Sensors(Id)
			on delete cascade
			on update cascade
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains device sensors',
								@level1type=N'TABLE', @level1name=N'DeviceSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'DeviceSensor identifier',
								@level1type=N'TABLE', @level1name=N'DeviceSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'DeviceId',
								@name=N'MS_Description', @value=N'Device identifier',
								@level1type=N'TABLE', @level1name=N'DeviceSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorId',
								@name=N'MS_Description', @value=N'Sensor identifier',
								@level1type=N'TABLE', @level1name=N'DeviceSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorAssignedFrom',
								@name=N'MS_Description', @value=N'Sensor assigned to device from date',
								@level1type=N'TABLE', @level1name=N'DeviceSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorAssignedTill',
								@name=N'MS_Description', @value=N'Sensor assigned to device till date',
								@level1type=N'TABLE', @level1name=N'DeviceSensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


go
