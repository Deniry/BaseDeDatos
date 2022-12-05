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
PRINT N'Creando Tabla [dbo].[CUIDADOS]...';


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER OFF;


GO
CREATE TABLE [dbo].[CUIDADOS] (
    [CuidadosId]    UNIQUEIDENTIFIER NOT NULL,
    [SuculentasId]  UNIQUEIDENTIFIER NOT NULL,
    [CactusId]      UNIQUEIDENTIFIER NOT NULL,
    [NombreSintoma] VARCHAR (200)    NOT NULL,
    [Descripcion]   VARCHAR (MAX)    NULL,
    CONSTRAINT [CUIDADOS_PK] PRIMARY KEY CLUSTERED ([CuidadosId] ASC)
);


GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON;


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[CUIDADOS]...';


GO
ALTER TABLE [dbo].[CUIDADOS]
    ADD DEFAULT NEWID() FOR [CuidadosId];


GO
PRINT N'Creando Clave externa [dbo].[CUIDADOS_FK0]...';


GO
ALTER TABLE [dbo].[CUIDADOS] WITH NOCHECK
    ADD CONSTRAINT [CUIDADOS_FK0] FOREIGN KEY ([SuculentasId]) REFERENCES [dbo].[SUCULENTAS] ([SuculentasId]);


GO
PRINT N'Creando Clave externa [dbo].[CUIDADOS_FK1]...';


GO
ALTER TABLE [dbo].[CUIDADOS] WITH NOCHECK
    ADD CONSTRAINT [CUIDADOS_FK1] FOREIGN KEY ([CactusId]) REFERENCES [dbo].[CACTUS] ([CactusId]);


GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[CUIDADOS] WITH CHECK CHECK CONSTRAINT [CUIDADOS_FK0];

ALTER TABLE [dbo].[CUIDADOS] WITH CHECK CHECK CONSTRAINT [CUIDADOS_FK1];


GO
PRINT N'Actualización completada.';


GO
