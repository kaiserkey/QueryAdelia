/*Categorias de log a implementar*/
/*'Gestión de Empleados',
'Ausencias y Licencias',
'Declaraciones Juradas',
'Descuentos Judiciales',
'Discapacidad y Tenencia',
'Documentos y Datos Personales',
'Liquidación de Sueldos',
'Reclutamiento y Selección',
'Entidades Externas',
'Educación y Capacitación',
'Circuitos Administrativos',
'Estructuras Organizacionales',
'Salud Laboral',
'Herramientas y Consultas',
'Sistema y Administración'*/


--CASOS DE DOS LOGS QUE SE GRABAN SIN HABERLOS TOCADO, SOLO POR ENTRAR EN LA VENTANA EN LA QUE ESTA LA VARIABLE Y MODIFICAR ALGUN OTRO CAMPO FIGURA COMO MODIFICADO
SELECT *
FROM ADELIA.HL_LOG@TESTING HL
WHERE HL.HLL_TIMESTAMP >= TO_DATE('01-09-2023','DD-MM-YYYY')
      AND HL.OBJECTID IN ('3216273E2105107D999F', '3216273E20DF2353A84A')
ORDER BY HL.HLL_TIMESTAMP DESC
;
SELECT *
FROM ADELIA.HL_LOG_CATEGORY
;


INSERT INTO ADELIA.HL_LOG_CATEGORY HLC (HLC.CODE, 
                                        HLC.DESCRIPTION, 
                                        HLC.OBJECTID, 
                                        HLC.OLMARK )
SELECT LT.CODIGO, LT.CATEGORIA, ADELIA.NEWOID('44E8'), TO_CHAR(SYSDATE, 'DDMMYYYY')
FROM (
SELECT 'GE' AS CODIGO, UPPER('Gestión de Empleados') AS CATEGORIA FROM DUAL
    UNION ALL
    SELECT 'AL', UPPER('Ausencias y Licencias') FROM DUAL
    UNION ALL
    SELECT 'DJ', UPPER('Declaraciones Juradas') FROM DUAL
    UNION ALL
    SELECT 'DJ', UPPER('Descuentos Judiciales') FROM DUAL
    UNION ALL
    SELECT 'DT', UPPER('Discapacidad y Tenencia') FROM DUAL
    UNION ALL
    SELECT 'DDP', UPPER('Documentos y Datos Personales') FROM DUAL
    UNION ALL
    SELECT 'LS', UPPER('Liquidación de Sueldos') FROM DUAL
    UNION ALL
    SELECT 'RS', UPPER('Reclutamiento y Selección') FROM DUAL
    UNION ALL
    SELECT 'EE', UPPER('Entidades Externas') FROM DUAL
    UNION ALL
    SELECT 'EC', UPPER('Educación y Capacitación') FROM DUAL
    UNION ALL
    SELECT 'CA', UPPER('Circuitos Administrativos') FROM DUAL
    UNION ALL
    SELECT 'EO', UPPER('Estructuras Organizacionales') FROM DUAL
    UNION ALL
    SELECT 'SL', UPPER('Salud Laboral') FROM DUAL
    UNION ALL
    SELECT 'HC', UPPER('Herramientas y Consultas') FROM DUAL
    UNION ALL
    SELECT 'SA', UPPER('Sistema y Administración') FROM DUAL
) LT

