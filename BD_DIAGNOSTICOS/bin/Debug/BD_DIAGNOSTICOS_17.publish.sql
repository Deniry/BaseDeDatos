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
Se está quitando la columna [dbo].[CUIDADOS].[CactusId]; puede que se pierdan datos.

Se está quitando la columna [dbo].[CUIDADOS].[NombreSintoma]; puede que se pierdan datos.

Se está quitando la columna [dbo].[CUIDADOS].[SuculentasId]; puede que se pierdan datos.

Debe agregarse la columna [dbo].[CUIDADOS].[EnfermedadId] de la tabla [dbo].[CUIDADOS], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[CUIDADOS])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
/*
Se está quitando la columna [dbo].[ENFERMEDADES].[CactusId]; puede que se pierdan datos.

Se está quitando la columna [dbo].[ENFERMEDADES].[DescripcionLarga]; puede que se pierdan datos.

Se está quitando la columna [dbo].[ENFERMEDADES].[Imagen]; puede que se pierdan datos.

Se está quitando la columna [dbo].[ENFERMEDADES].[NombreEnfermedad]; puede que se pierdan datos.

Se está quitando la columna [dbo].[ENFERMEDADES].[SuculentasId]; puede que se pierdan datos.

Debe agregarse la columna [dbo].[ENFERMEDADES].[Nombre] de la tabla [dbo].[ENFERMEDADES], pero esta columna no tiene un valor predeterminado y no admite valores NULL. Si la tabla contiene datos, el script ALTER no funcionará. Para evitar esta incidencia, agregue un valor predeterminado a la columna, márquela de modo que permita valores NULL o habilite la generación de valores predeterminados inteligentes como opción de implementación.
*/

IF EXISTS (select top 1 1 from [dbo].[ENFERMEDADES])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Quitando Restricción DEFAULT restricción sin nombre en [dbo].[CUIDADOS]...';


GO
ALTER TABLE [dbo].[CUIDADOS] DROP CONSTRAINT [DF__CUIDADOS__Cuidad__4316F928];


GO
PRINT N'Quitando Restricción DEFAULT restricción sin nombre en [dbo].[ENFERMEDADES]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES] DROP CONSTRAINT [DF__tmp_ms_xx__Enfer__36B12243];


GO
PRINT N'Quitando Clave externa [dbo].[CUIDADOS_FK0]...';


GO
ALTER TABLE [dbo].[CUIDADOS] DROP CONSTRAINT [CUIDADOS_FK0];


GO
PRINT N'Quitando Clave externa [dbo].[CUIDADOS_FK1]...';


GO
ALTER TABLE [dbo].[CUIDADOS] DROP CONSTRAINT [CUIDADOS_FK1];


GO
PRINT N'Quitando Clave externa [dbo].[ENFERMEDADES_FK0]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES] DROP CONSTRAINT [ENFERMEDADES_FK0];


GO
PRINT N'Quitando Clave externa [dbo].[ENFERMEDADES_FK1]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES] DROP CONSTRAINT [ENFERMEDADES_FK1];


GO
PRINT N'Quitando Clave externa [dbo].[SINTOMAS_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMAS] DROP CONSTRAINT [SINTOMAS_FK0];


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[CUIDADOS]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_CUIDADOS] (
    [CuidadosId]   UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
    [EnfermedadId] UNIQUEIDENTIFIER NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    CONSTRAINT [tmp_ms_xx_constraint_CUIDADOS_PK1] PRIMARY KEY CLUSTERED ([CuidadosId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[CUIDADOS])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_CUIDADOS] ([CuidadosId], [Descripcion])
        SELECT   [CuidadosId],
                 [Descripcion]
        FROM     [dbo].[CUIDADOS]
        ORDER BY [CuidadosId] ASC;
    END

DROP TABLE [dbo].[CUIDADOS];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_CUIDADOS]', N'CUIDADOS';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_CUIDADOS_PK1]', N'CUIDADOS_PK', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Iniciando recompilación de la tabla [dbo].[ENFERMEDADES]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ENFERMEDADES] (
    [EnfermedadId] UNIQUEIDENTIFIER DEFAULT NEWID() NOT NULL,
    [Nombre]       VARCHAR (200)    NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    CONSTRAINT [tmp_ms_xx_constraint_ENFERMEDADES_PK1] PRIMARY KEY CLUSTERED ([EnfermedadId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ENFERMEDADES])
    BEGIN
        INSERT INTO [dbo].[tmp_ms_xx_ENFERMEDADES] ([EnfermedadId], [Descripcion])
        SELECT   [EnfermedadId],
                 [Descripcion]
        FROM     [dbo].[ENFERMEDADES]
        ORDER BY [EnfermedadId] ASC;
    END

DROP TABLE [dbo].[ENFERMEDADES];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ENFERMEDADES]', N'ENFERMEDADES';

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_constraint_ENFERMEDADES_PK1]', N'ENFERMEDADES_PK', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Tabla [dbo].[SINTOMASCAC]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[SINTOMASCAC] (
    [SintomaCacId] UNIQUEIDENTIFIER NOT NULL,
    [EnfermedadId] UNIQUEIDENTIFIER NOT NULL,
    [Nombre]       VARCHAR (200)    NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    CONSTRAINT [SINTOMASCAC_PK] PRIMARY KEY CLUSTERED ([SintomaCacId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Tabla [dbo].[SINTOMASSUCU]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[SINTOMASSUCU] (
    [SintomaSucuId] UNIQUEIDENTIFIER NOT NULL,
    [EnfermedadId]  UNIQUEIDENTIFIER NOT NULL,
    [Nombre]        VARCHAR (200)    NOT NULL,
    [Descripcion]   VARCHAR (MAX)    NULL,
    CONSTRAINT [SINTOMASSUCU_PK] PRIMARY KEY CLUSTERED ([SintomaSucuId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[SINTOMASCAC]...';


GO
ALTER TABLE [dbo].[SINTOMASCAC]
    ADD DEFAULT NEWID() FOR [SintomaCacId];


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[SINTOMASSUCU]...';


GO
ALTER TABLE [dbo].[SINTOMASSUCU]
    ADD DEFAULT NEWID() FOR [SintomaSucuId];


GO
PRINT N'Creando Clave externa [dbo].[CUIDADOS_FK0]...';


GO
ALTER TABLE [dbo].[CUIDADOS] WITH NOCHECK
    ADD CONSTRAINT [CUIDADOS_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Creando Clave externa [dbo].[SINTOMASCAC_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMASCAC] WITH NOCHECK
    ADD CONSTRAINT [SINTOMASCAC_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Creando Clave externa [dbo].[SINTOMASSUCU_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMASSUCU] WITH NOCHECK
    ADD CONSTRAINT [SINTOMASSUCU_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[CUIDADOS] WITH CHECK CHECK CONSTRAINT [CUIDADOS_FK0];

ALTER TABLE [dbo].[SINTOMASCAC] WITH CHECK CHECK CONSTRAINT [SINTOMASCAC_FK0];

ALTER TABLE [dbo].[SINTOMASSUCU] WITH CHECK CHECK CONSTRAINT [SINTOMASSUCU_FK0];


GO
PRINT N'Actualización completada.';


GO
