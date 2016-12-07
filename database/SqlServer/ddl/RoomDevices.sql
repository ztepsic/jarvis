use ztepsicc_jarvis;
go

create table dbo.RoomDevices (
	Id int identity(1, 1)
		constraint PK_RoomDevice_Id primary key
,	RoomId int not null
,	DeviceId int not null
,	DeviceAssignedFrom datetime2 not null
,	DeviceAssignedTill datetime2
,	constraint FK_RoomDevices_RoomId
		foreign key (RoomId) references dbo.Rooms(Id)
			on delete cascade
			on update cascade
,	constraint FK_RoomDevices_DeviceId
		foreign key (DeviceId) references dbo.Devices(Id)
			on delete cascade
			on update cascade
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains room devices',
								@level1type=N'TABLE', @level1name=N'RoomDevices',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'RoomDevice identifier',
								@level1type=N'TABLE', @level1name=N'RoomDevices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'RoomId',
								@name=N'MS_Description', @value=N'Room identifier',
								@level1type=N'TABLE', @level1name=N'RoomDevices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'DeviceId',
								@name=N'MS_Description', @value=N'Device identifier',
								@level1type=N'TABLE', @level1name=N'RoomDevices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'DeviceAssignedFrom',
								@name=N'MS_Description', @value=N'Device assigned to room from date',
								@level1type=N'TABLE', @level1name=N'RoomDevices',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'DeviceAssignedTill',
								@name=N'MS_Description', @value=N'Device assigned to room till date',
								@level1type=N'TABLE', @level1name=N'RoomDevices',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go

alter table dbo.RoomDevices
	add constraint UX_RoomDevices_RoomIdDeviceId unique(RoomId, DeviceId);
go