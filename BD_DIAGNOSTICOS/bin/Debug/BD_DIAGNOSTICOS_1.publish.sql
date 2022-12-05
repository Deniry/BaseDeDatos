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
El tipo de la columna EnfermedadId de la tabla [dbo].[ENFERMEDADES] es actualmente  INT NOT NULL pero se está cambiando a  UNIQUEIDENTIFIER NOT NULL. No hay conversión implícita ni explícita.
*/

IF EXISTS (select top 1 1 from [dbo].[ENFERMEDADES])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'La operación de refactorización Cambiar nombre con la clave 1ff58b4c-4041-42b0-b382-7c90202b108f se ha omitido; no se cambiará el nombre del elemento [dbo].[SUCULENTAS].[Id] (SqlSimpleColumn) a SuculentasId';


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[ENFERMEDADES]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ENFERMEDADES] (
    [EnfermedadId] UNIQUEIDENTIFIER NOT NULL,
    [Nombre]       VARCHAR (200)    NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    [Imagen]       IMAGE            NULL,
    PRIMARY KEY CLUSTERED ([EnfermedadId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ENFERMEDADES])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_ENFERMEDADES] ([EnfermedadId], [Nombre], [Descripcion], [Imagen])
        SELECT   [EnfermedadId],
                 [Nombre],
                 [Descripcion],
                 [Imagen]
        FROM     [dbo].[ENFERMEDADES]
        ORDER BY [EnfermedadId] ASC;
    END

DROP TABLE [dbo].[ENFERMEDADES];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ENFERMEDADES]', N'ENFERMEDADES';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Tabla [dbo].[SUCULENTAS]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[SUCULENTAS] (
    [SuculentasId] UNIQUEIDENTIFIER NOT NULL,
    [Nombre]       VARCHAR (50)     NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    [Imagen]       IMAGE            NULL,
    PRIMARY KEY CLUSTERED ([SuculentasId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
-- Paso de refactorización para actualizar el servidor de destino con los registros de transacciones implementadas

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '1ff58b4c-4041-42b0-b382-7c90202b108f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('1ff58b4c-4041-42b0-b382-7c90202b108f')

GO

GO
PRINT N'Actualización completada.';


GO
