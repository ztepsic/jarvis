use ztepsicc_jarvis;
go

create table dbo.Homes (
	Id int identity(1, 1)
		constraint PK_Home_Id primary key
,	Name nvarchar(30) not null
,	Description ntext
);
go


exec sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains homes',
								@level1type=N'TABLE', @level1name=N'Homes',
								@level0type=N'SCHEMA', @level0name=N'dbo'


exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Id',
								@name=N'MS_Description', @value=N'Home identifier',
								@level1type=N'TABLE', @level1name=N'Homes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Name',
								@name=N'MS_Description', @value=N'Home name',
								@level1type=N'TABLE', @level1name=N'Homes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

exec sys.sp_addextendedproperty @level2type=N'COLUMN', @level2name=N'Description',
								@name=N'MS_Description', @value=N'Home description',
								@level1type=N'TABLE', @level1name=N'Homes',
								@level0type=N'SCHEMA', @level0name=N'dbo'

go
