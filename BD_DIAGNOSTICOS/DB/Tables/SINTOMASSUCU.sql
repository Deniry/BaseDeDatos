CREATE TABLE [dbo].[SINTOMASSUCU]
(
	[SintomaSucuId]     UNIQUEIDENTIFIER DEFAULT NEWID()    NOT NULL,
    [EnfermedadId]      UNIQUEIDENTIFIER                    NOT NULL,
    [Nombre]            VARCHAR (200)                       NOT NULL,
    [Descripcion]       VARCHAR(MAX)                        NULL,
    [GrupoId]           UNIQUEIDENTIFIER                    NULL,
)
WITH (DATA_COMPRESSION = NONE);
GO

ALTER TABLE [dbo].[SINTOMASSUCU] ADD CONSTRAINT [SINTOMASSUCU_PK] PRIMARY KEY ([SintomaSucuId] asc);
GO

ALTER TABLE [dbo].[SINTOMASSUCU] ADD CONSTRAINT [SINTOMASSUCU_FK0] FOREIGN KEY ([EnfermedadId])
    REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO

ALTER TABLE [dbo].[SINTOMASSUCU] ADD CONSTRAINT [SINTOMASSUCU_FK1] FOREIGN KEY ([GrupoId])
    REFERENCES [dbo].[GRUPO] ([GrupoId])
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
GO