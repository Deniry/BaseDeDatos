CREATE TABLE [dbo].[ENFERMEDADES]
(
	[EnfermedadId]      UNIQUEIDENTIFIER DEFAULT NEWID()    NOT NULL,
    [Nombre]            VARCHAR (200)                       NOT NULL, 
    [Descripcion]       VARCHAR(MAX)                        NULL, 
)
WITH (DATA_COMPRESSION = NONE);
GO

ALTER TABLE [dbo].[ENFERMEDADES] ADD CONSTRAINT [ENFERMEDADES_PK] PRIMARY KEY ([EnfermedadId] asc);
GO
