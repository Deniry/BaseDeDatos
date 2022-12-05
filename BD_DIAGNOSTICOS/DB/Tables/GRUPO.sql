CREATE TABLE [dbo].[GRUPO]
(
	[GrupoId]			UNIQUEIDENTIFIER DEFAULT NEWID()    NOT NULL,
	[Nombre]            VARCHAR (200)                       NOT NULL,
    [Descripcion]       VARCHAR(MAX)                        NULL,
)
WITH (DATA_COMPRESSION = NONE);
GO

ALTER TABLE [dbo].[GRUPO] ADD CONSTRAINT [GRUPO_PK] PRIMARY KEY ([GrupoId] asc);
GO
