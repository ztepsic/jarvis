use ztepsicc_jarvis;
go

create table dbo.SensorModels (
	Id int identity(1, 1)
		constraint PK_SensorModel_Id primary key
,	Model nvarchar(30) not null
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains sensor models',
								@level1type=N'TABLE', @level1name=N'SensorModels',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'Sensor model identifier',
								@level1type=N'TABLE', @level1name=N'SensorModels',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Model',
								@name=N'MS_Description', @value=N'Sensor model',
								@level1type=N'TABLE', @level1name=N'SensorModels',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go
