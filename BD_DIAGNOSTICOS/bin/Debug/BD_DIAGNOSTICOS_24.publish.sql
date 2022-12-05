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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS OFF,
                ANSI_PADDING OFF,
                ANSI_WARNINGS OFF,
                ARITHABORT OFF,
                CONCAT_NULL_YIELDS_NULL OFF,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER OFF,
                ANSI_NULL_DEFAULT OFF,
                CURSOR_DEFAULT GLOBAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY CHECKSUM,
                DATE_CORRELATION_OPTIMIZATION OFF,
                ENABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 60 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = AUTO, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), MAX_STORAGE_SIZE_MB = 1000) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Tabla [dbo].[CUIDADOS]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[CUIDADOS] (
    [CuidadosId]   UNIQUEIDENTIFIER NOT NULL,
    [EnfermedadId] UNIQUEIDENTIFIER NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    CONSTRAINT [CUIDADOS_PK] PRIMARY KEY CLUSTERED ([CuidadosId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Tabla [dbo].[ENFERMEDADES]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[ENFERMEDADES] (
    [EnfermedadId] UNIQUEIDENTIFIER NOT NULL,
    [Nombre]       VARCHAR (200)    NOT NULL,
    [Descripcion]  VARCHAR (MAX)    NULL,
    CONSTRAINT [ENFERMEDADES_PK] PRIMARY KEY CLUSTERED ([EnfermedadId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Tabla [dbo].[GRUPO]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[GRUPO] (
    [GrupoId]     UNIQUEIDENTIFIER NOT NULL,
    [Nombre]      VARCHAR (200)    NOT NULL,
    [Descripcion] VARCHAR (MAX)    NULL,
    CONSTRAINT [GRUPO_PK] PRIMARY KEY CLUSTERED ([GrupoId] ASC)
);


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
    [Grupos]       INT              NULL,
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
    [GrupoId]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [SINTOMASSUCU_PK] PRIMARY KEY CLUSTERED ([SintomaSucuId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[CUIDADOS]...';


GO
ALTER TABLE [dbo].[CUIDADOS]
    ADD DEFAULT NEWID() FOR [CuidadosId];


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[ENFERMEDADES]...';


GO
ALTER TABLE [dbo].[ENFERMEDADES]
    ADD DEFAULT NEWID() FOR [EnfermedadId];


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[GRUPO]...';


GO
ALTER TABLE [dbo].[GRUPO]
    ADD DEFAULT NEWID() FOR [GrupoId];


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
ALTER TABLE [dbo].[CUIDADOS]
    ADD CONSTRAINT [CUIDADOS_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Creando Clave externa [dbo].[SINTOMASCAC_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMASCAC]
    ADD CONSTRAINT [SINTOMASCAC_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Creando Clave externa [dbo].[SINTOMASSUCU_FK0]...';


GO
ALTER TABLE [dbo].[SINTOMASSUCU]
    ADD CONSTRAINT [SINTOMASSUCU_FK0] FOREIGN KEY ([EnfermedadId]) REFERENCES [dbo].[ENFERMEDADES] ([EnfermedadId]);


GO
PRINT N'Creando Clave externa [dbo].[SINTOMASSUCU_FK1]...';


GO
ALTER TABLE [dbo].[SINTOMASSUCU]
    ADD CONSTRAINT [SINTOMASSUCU_FK1] FOREIGN KEY ([GrupoId]) REFERENCES [dbo].[GRUPO] ([GrupoId]);


GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
