use ztepsicc_jarvis;
go

create table dbo.SensorModelCapabilities (
	Id int identity(1, 1)
		constraint PK_SensorCapabilities_Id primary key
,	SensorModelId int not null
,	SensorTypeId int not null
,	SensorValueTypeId int not null
,	MeasurementPrecision decimal not null default 0
,	MeasurementLowerRange decimal not null default 0
,	MeasurementUpperRange decimal not null default 0
,	constraint FK_SensorCapabilities_SensorId
		foreign key (SensorModelId) references dbo.SensorModels(Id)
			on delete cascade
			on update cascade
,	constraint FK_SensorCapabilities_SensorTypeid
		foreign key (SensorTypeId) references dbo.SensorTypes(Id)
			on delete no action
			on update no action
,	constraint FK_SensorCapabilities_SensorValueTypeid
		foreign key (SensorValueTypeId) references dbo.SensorValueTypes(Id)
			on delete no action
			on update no action
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains sensor capabilities',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'SensorModelCapability identifier',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorModelId',
								@name=N'MS_Description', @value=N'Sensor model id',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorTypeId',
								@name=N'MS_Description', @value=N'Sensor type id',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'SensorValueTypeId',
								@name=N'MS_Description', @value=N'Sensor value type id',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'MeasurementPrecision',
								@name=N'MS_Description', @value=N'Sensor measurement precision',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'MeasurementLowerRange',
								@name=N'MS_Description', @value=N'Sensor measurement lower range',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'MeasurementUpperRange',
								@name=N'MS_Description', @value=N'Sensor measurement upper range',
								@level1type=N'TABLE', @level1name=N'SensorModelCapabilities',
								@level0type=N'SCHEMA', @level0name=N'dbo'


go

alter table dbo.SensorModelCapabilities
	add constraint UX_SensorModelCapabilities_SensorIdSensorTypeId unique(SensorModelId, SensorTypeId, SensorValueTypeId);
go