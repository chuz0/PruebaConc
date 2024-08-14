USE [Articulos]
GO
/****** Object:  StoredProcedure [dbo].[ListarEmpleado]    Script Date: 8/8/2024 11:19:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--
--  Lista todos los empleados en orden alfabetico ascendente, todos los atributos excepto la PK
  
--  Descripcion de parametros: 

--  @outResultCode: codigo de resultado de ejecucion. 0 Corrio sin errores, 
--  codigos de errores entre 0 y 50000 son errores reservados, mayores a 50000 son definidos por el programador.
--
ALTER PROCEDURE [dbo].[ListarEmpleado]
	@OutResulTCode INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;
	BEGIN TRY
	-- ejemplo de ejecucion del SP

	-- DECLARE @OutResulTCode int
	-- EXECUTE @RC = [dbo].[ListarEmpleado] @OutResulTCode OUTPUT
	--SELECT @OutResulTCode

	-- se hacen declaraciones

	-- se hacen inicializacion
	SET @OutResulTCode=0;

	-- se hacaen validaciones
	-- Data sets se especifican al final y todos juntos
	SELECT @OutResulTCode AS OutResulTCode;  -- Este codigo se agrega solo si hay problemas para obtener este  valor como parametros

	SELECT E.[Id]   -- En interfaces a usuario final no se muestra, ni en apis
		, E.[Nombre]
		, E.[Salario]
	FROM dbo.Empleado E 
	ORDER BY E.Nombre;

	END TRY
	BEGIN CATCH
		INSERT INTO dbo.DBErrors	VALUES (
			SUSER_SNAME(),
			ERROR_NUMBER(),
			ERROR_STATE(),
			ERROR_SEVERITY(),
			ERROR_LINE(),
			ERROR_PROCEDURE(),
			ERROR_MESSAGE(),
			GETDATE()
		);

		SET @OutResulTCode=50005  ;  -- Codigo de error standar del profe para informar de un error capturado en el catch

	END CATCH;

	SET NOCOUNT Off;
END;