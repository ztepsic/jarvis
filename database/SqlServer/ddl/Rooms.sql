use ztepsicc_jarvis;
go

create table dbo.Rooms (
	Id int identity(1, 1)
		constraint PK_Room_Id primary key
,	HomeId int not null
,	Name nvarchar(30) not null
,	Description ntext
,	constraint FK_Room_HomeId
		foreign key (HomeId) references dbo.Homes(Id)
			on delete cascade
			on update cascade
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains rooms for particular home',
								@level1type=N'TABLE', @level1name=N'Rooms',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'Room identifier',
								@level1type=N'TABLE', @level1name=N'Rooms',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'HomeId',
								@name=N'MS_Description', @value=N'Home identifier to whom room belongs',
								@level1type=N'TABLE', @level1name=N'Rooms',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Name',
								@name=N'MS_Description', @value=N'Room name',
								@level1type=N'TABLE', @level1name=N'Rooms',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Description',
								@name=N'MS_Description', @value=N'Romm description',
								@level1type=N'TABLE', @level1name=N'Rooms',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go
