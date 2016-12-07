use ztepsicc_jarvis;
go

create table dbo.SensorValueTypes (
	Id int identity(1, 1)
		constraint PK_SensorValueTypes_Id primary key
,	TypeId int not null
,	ValueName nvarchar(30) not null
,	UnitOfMeasurement nvarchar(30) not null
,	Symbol nvarchar(10) not null
,	PowersOfTen smallint not null default 0
,	constraint FK_SensorValueTypes_TypeId
		foreign key (TypeId) references dbo.SensorTypes(Id)
			on delete no action
			on update cascade
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains sensor value types',
								@level1type=N'TABLE', @level1name=N'SensorValueTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'Sensor value type identifier',
								@level1type=N'TABLE', @level1name=N'SensorValueTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'TypeId',
								@name=N'MS_Description', @value=N'Sensor type identifier',
								@level1type=N'TABLE', @level1name=N'SensorTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'ValueName',
								@name=N'MS_Description', @value=N'Sensor value type name',
								@level1type=N'TABLE', @level1name=N'SensorValueTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'UnitOfMeasurement',
								@name=N'MS_Description', @value=N'Unit of measurement',
								@level1type=N'TABLE', @level1name=N'SensorValueTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Symbol',
								@name=N'MS_Description', @value=N'Symbol of value',
								@level1type=N'TABLE', @level1name=N'SensorValueTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'PowersOfTen',
								@name=N'MS_Description', @value=N'Exponent of powers of ten',
								@level1type=N'TABLE', @level1name=N'SensorValueTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'



go
