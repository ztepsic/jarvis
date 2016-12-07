use ztepsicc_jarvis;
go

create table dbo.SensorTypes (
	Id int identity(1, 1)
		constraint PK_SensorType_Id primary key
,	Name nvarchar(30) not null
,	Description ntext
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains sensor types',
								@level1type=N'TABLE', @level1name=N'SensorTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'Sensor type identifier',
								@level1type=N'TABLE', @level1name=N'SensorTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Name',
								@name=N'MS_Description', @value=N'Sensor type name',
								@level1type=N'TABLE', @level1name=N'SensorTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Description',
								@name=N'MS_Description', @value=N'Sensor type description',
								@level1type=N'TABLE', @level1name=N'SensorTypes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go
