/*
Script de implementación para BD_DIAGNOSTICOS

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BD_DIAGNOSTICOS"
:setvar DefaultFilePrefix "BD_DIAGNOSTICOS"
:setvar DefaultDataPath "C:\Users\drago\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\drago\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
El tipo de la columna GrupoId de la tabla [dbo].[SINTOMASCAC] es actualmente  INT NULL pero se está cambiando a  UNIQUEIDENTIFIER NULL. No hay conversión implícita ni explícita.
*/

IF EXISTS (select top 1 1 from [dbo].[SINTOMASCAC])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'La siguiente operación se generó a partir de un archivo de registro de refactorización 304f4660-22fe-48b1-b82e-00f7fa63660a';

PRINT N'Cambiar el nombre de [dbo].[SINTOMASCAC].[Grupos] a GrupoId';


GO
EXECUTE sp_rename @objname = N'[dbo].[SINTOMASCAC].[Grupos]', @newname = N'GrupoId', @objtype = N'COLUMN';


GO
PRINT N'Quitando Restricción DEFAULT restricción sin nombre en [dbo].[SINTOMASCAC]...';


GO
ALTER TABLE [dbo].[SINTOMASCAC] DROP CONSTRAINT [DF__SINTOMASC__Sinto__2F10007B];


GO
PRINT N'Quitando Clave externa [dbo].[SINTOMASCAC_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMASCAC] DROP CONSTRAINT [SINTOMASCAC_FK0];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[SINTOMASCAC]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_SINTOMASCAC] (
    [SintomaCacId] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
    [EnfermedadId] UNIQUEIDENTIFIER NOT NULL,
    [Nombre]       VARCHAR (200)    NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    [GrupoId]      UNIQUEIDENTIFIER NULL,
    CONSTRAINT [tmp_ms_xx_constraint_SINTOMASCAC_PK1] PRIMARY KEY CLUSTERED ([SintomaCacId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[SINTOMASCAC])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_SINTOMASCAC] ([SintomaCacId], [EnfermedadId], [Nombre], [Descripcion], [GrupoId])
        SELECT   [SintomaCacId],
                 [EnfermedadId],
                 [Nombre],
                 [Descripcion],
                 [GrupoId]
        FROM     [dbo].[SINTOMASCAC]
        ORDER BY [SintomaCacId] ASC;
    END

DROP TABLE [dbo].[SINTOMASCAC];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_SINTOMASCAC]', N'SINTOMASCAC';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_SINTOMASCAC_PK1]', N'SINTOMASCAC_PK', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Clave externa [dbo].[SINTOMASCAC_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMASCAC] WITH NOCHECK
    ADD CONSTRAINT [SINTOMASCAC_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Creando Clave externa [dbo].[SINTOMASCAC_FK1]...';


GO
ALTER TABLE [dbo].[SINTOMASCAC] WITH NOCHECK
    ADD CONSTRAINT [SINTOMASCAC_FK1] FOREIGN KEY ([GrupoId]) REFERENCES [dbo].[GRUPO] ([GrupoId]);


GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '304f4660-22fe-48b1-b82e-00f7fa63660a')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('304f4660-22fe-48b1-b82e-00f7fa63660a')

GO

GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[SINTOMASCAC] WITH CHECK CHECK CONSTRAINT [SINTOMASCAC_FK0];

ALTER TABLE [dbo].[SINTOMASCAC] WITH CHECK CHECK CONSTRAINT [SINTOMASCAC_FK1];


GO
PRINT N'Actualización completada.';


GO
