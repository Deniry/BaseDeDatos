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
Debe agregarse la columna [dbo].[ENFERMEDADES].[CactusId] de la tabla [dbo].[ENFERMEDADES], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[ENFERMEDADES])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Restricción DEFAULT restricción sin nombre en [dbo].[ENFERMEDADES]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES] DROP CONSTRAINT [DF__ENFERMEDA__Enfer__267ABA7A];


GO
PRINT N'Quitando Clave externa [dbo].[ENFERMEDADES_FK0]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES] DROP CONSTRAINT [ENFERMEDADES_FK0];


GO
PRINT N'Quitando Clave principal [dbo].[SUCULENTAS_PK]...';


GO
ALTER TABLE [dbo].[SUCULENTAS] DROP CONSTRAINT [SUCULENTAS_PK];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[ENFERMEDADES]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ENFERMEDADES] (
    [EnfermedadId]     UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
    [SuculentasId]     UNIQUEIDENTIFIER NOT NULL,
    [CactusId]         UNIQUEIDENTIFIER NOT NULL,
    [NombreEnfermedad] VARCHAR (200)    NOT NULL,
    [Descripcion]      VARCHAR (MAX)    NULL,
    [DescripcionLarga] VARCHAR (MAX)    NULL,
    [Imagen]           IMAGE            NULL,
    CONSTRAINT [tmp_ms_xx_constraint_ENFERMEDADES_PK1] PRIMARY KEY CLUSTERED ([EnfermedadId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ENFERMEDADES])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_ENFERMEDADES] ([EnfermedadId], [SuculentasId], [NombreEnfermedad], [Descripcion], [DescripcionLarga], [Imagen])
        SELECT   [EnfermedadId],
                 [SuculentasId],
                 [NombreEnfermedad],
                 [Descripcion],
                 [DescripcionLarga],
                 [Imagen]
        FROM     [dbo].[ENFERMEDADES]
        ORDER BY [EnfermedadId] ASC;
    END

DROP TABLE [dbo].[ENFERMEDADES];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ENFERMEDADES]', N'ENFERMEDADES';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_ENFERMEDADES_PK1]', N'ENFERMEDADES_PK', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creando Tabla [dbo].[CACTUS]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[CACTUS] (
    [CactusId]     UNIQUEIDENTIFIER NOT NULL,
    [NombreCactus] VARCHAR (200)    NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    [Imagen]       IMAGE            NULL,
    CONSTRAINT [CACTUS_PK] PRIMARY KEY CLUSTERED ([CactusId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Tabla [dbo].[SINTOMAS]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[SINTOMAS] (
    [SintomasId]    UNIQUEIDENTIFIER NOT NULL,
    [EnfermedadId]  UNIQUEIDENTIFIER NOT NULL,
    [NombreSintoma] VARCHAR (200)    NOT NULL,
    [Descripcion]   VARCHAR (MAX)    NULL,
    CONSTRAINT [SINTOMAS_PK] PRIMARY KEY CLUSTERED ([SintomasId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Clave principal [dbo].[SUCULENTAS_PK]...';


GO
ALTER TABLE [dbo].[SUCULENTAS]
    ADD CONSTRAINT [SUCULENTAS_PK] PRIMARY KEY CLUSTERED ([SuculentasId] ASC);


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[CACTUS]...';


GO
ALTER TABLE [dbo].[CACTUS]
    ADD DEFAULT NEWID() FOR [CactusId];


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[SINTOMAS]...';


GO
ALTER TABLE [dbo].[SINTOMAS]
    ADD DEFAULT NEWID() FOR [SintomasId];


GO
PRINT N'Creando Clave externa [dbo].[ENFERMEDADES_FK0]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES] WITH NOCHECK
    ADD CONSTRAINT [ENFERMEDADES_FK0] FOREIGN KEY ([SuculentasId]) REFERENCES [dbo].[SUCULENTAS] ([SuculentasId]);


GO
PRINT N'Creando Clave externa [dbo].[ENFERMEDADES_FK1]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES] WITH NOCHECK
    ADD CONSTRAINT [ENFERMEDADES_FK1] FOREIGN KEY ([CactusId]) REFERENCES [dbo].[CACTUS] ([CactusId]);


GO
PRINT N'Creando Clave externa [dbo].[SINTOMAS_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMAS] WITH NOCHECK
    ADD CONSTRAINT [SINTOMAS_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[ENFERMEDADES] WITH CHECK CHECK CONSTRAINT [ENFERMEDADES_FK0];

ALTER TABLE [dbo].[ENFERMEDADES] WITH CHECK CHECK CONSTRAINT [ENFERMEDADES_FK1];

ALTER TABLE [dbo].[SINTOMAS] WITH CHECK CHECK CONSTRAINT [SINTOMAS_FK0];


GO
PRINT N'Actualización completada.';


GO
