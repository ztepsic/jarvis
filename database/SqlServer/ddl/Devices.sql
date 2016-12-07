use ztepsicc_jarvis;
go

create table dbo.Devices (
	Id int identity(1, 1)
		constraint PK_Device_Id primary key
,	DeviceExtId nvarchar(30) not null
,	Name nvarchar(30) not null
,	Host nvarchar(30) not null
,	Description ntext
,	Active bit not null default 0
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains devices for home automation',
								@level1type=N'TABLE', @level1name=N'Devices',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'Device identifier',
								@level1type=N'TABLE', @level1name=N'Devices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'DeviceExtId',
								@name=N'MS_Description', @value=N'External device Id - e.g serial number',
								@level1type=N'TABLE', @level1name=N'Devices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Name',
								@name=N'MS_Description', @value=N'Device name',
								@level1type=N'TABLE', @level1name=N'Devices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Description',
								@name=N'MS_Description', @value=N'Device description',
								@level1type=N'TABLE', @level1name=N'Devices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Active',
								@name=N'MS_Description', @value=N'Is device active, 0 not active, 1 active. Default 0.',
								@level1type=N'TABLE', @level1name=N'Devices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go

alter table dbo.Devices
	add constraint UX_Devices_HostDeviceExtId unique(Host, DeviceExtId);
go

alter table dbo.Devices
	add constraint UX_Devices_DeviceExtId unique(DeviceExtId);
go
