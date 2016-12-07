use ztepsicc_jarvis;
go

create table dbo.Sensors (
	Id int identity(1, 1)
		constraint PK_Sensor_Id primary key
,	SensorModelId int not null
,	SerialNo nvarchar(50)
,	InUseFromDate datetime2 not null
,	constraint FK_Sensors_SensorModelId
		foreign key (SensorModelId) references dbo.SensorModels(Id)
			on delete cascade
			on update cascade
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains sensor instances',
								@level1type=N'TABLE', @level1name=N'Sensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'Sensor identifier',
								@level1type=N'TABLE', @level1name=N'Sensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorModelId',
								@name=N'MS_Description', @value=N'Sensor model',
								@level1type=N'TABLE', @level1name=N'Sensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SerialNo',
								@name=N'MS_Description', @value=N'Sensor serial number',
								@level1type=N'TABLE', @level1name=N'Sensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'InUseFromDate',
								@name=N'MS_Description', @value=N'Sensor in use from date',
								@level1type=N'TABLE', @level1name=N'Sensors',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go
