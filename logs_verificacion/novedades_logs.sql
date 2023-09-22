--CONTAR LA CANTIDAD DE LOGS INSERTADOS EN LA FECHA 4092023 - LOGS DE NOVEDAD
SELECT COUNT(*)
FROM ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD
WHERE 1=1
      AND HLOD.OLMARK = '22092023'

;

--CONTAR LA CANTIDAD DE LOGS CREADOS EN ADELIA
SELECT COUNT(*)
FROM ADELIA.HL_LOG_USE HL

;

--INSERTAR LAS NOVEDADES PARA CADA LOG CREADO EN ADELIA
INSERT INTO ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD (HLOD.OBJECTID,
                                                   HLOD.OLMARK,
                                                   HLOD.DESCRIPTION,
                                                   HLOD.DEFINITION_KEY,
                                                   HLOD.HLL_USE,
                                                   HLOD.HLL_DEFINITION_SOURCE)
VALUES (ADELIA.NEWOID('204C'), TO_CHAR(SYSDATE, 'DDMMYYYY'), 'NOVEDAD', 'NOVEDAD', '768557B9F51A0A70084D', '[ :receiver :args | receiver ]')
;
INSERT INTO ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD (HLOD.OBJECTID,
                                                   HLOD.HLL_USE, 
                                                   HLOD.DEFINITION_KEY, 
                                                   HLOD.DESCRIPTION, 
                                                   HLOD.HLL_DEFINITION_SOURCE,
                                                   HLOD.OLMARK)
SELECT ADELIA.NEWOID('204C'), HLU.OBJECTID, 'NOVEDAD', 'NOVEDAD', '[ :receiver :args | receiver ]', TO_CHAR(SYSDATE, 'DDMMYYYY')
FROM ADELIA.HL_LOG_USE HLU
WHERE 1=1 --FILTRAR LOS LOGS QUE NO TIENEN NOVEDAD CREADA
      AND HLU.OBJECTID NOT IN (SELECT HLOD.HLL_USE
                               FROM ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD
                               WHERE 1=1
                                     AND LOWER(TRIM(HLOD.DESCRIPTION)) = 'novedad' AND LOWER(TRIM(HLOD.DEFINITION_KEY)) = 'novedad'
                                     AND HLOD.OLMARK IN ('4092023', '22092023')
                                     AND HLOD.HLL_DEFINITION_SOURCE = '[ :receiver :args | receiver ]') 

--SELECT TO_CHAR(SYSDATE, 'DDMMYYYY') from dual;
--delete from ADELIA.HLL_LOG_OBJECT_DEFINITION hlod
--where hlod.OLMARK = '22092023'
--LOGS A LOS QUE LE FALTA AGREGAR LA NOVEDAD   
;   
SELECT *
FROM ADELIA.HL_LOG_USE HLU
WHERE 1=1
      AND HLU.OBJECTID NOT IN (SELECT HLOD.HLL_USE
                            FROM ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD
                            WHERE 1=1
                                  AND LOWER(TRIM(HLOD.DESCRIPTION)) = 'novedad' AND LOWER(TRIM(HLOD.DEFINITION_KEY)) = 'novedad'
                                  AND HLOD.OLMARK = '4092023'
                                  AND HLOD.HLL_DEFINITION_SOURCE = '[ :receiver :args | receiver ]'
                            )


--LISTAR LOS LOGS QUE TIENEN MAS DE UNA NOVEDAD
;

SELECT HLOD.HLL_USE
FROM ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD
WHERE 1=1
      AND LOWER(TRIM(HLOD.DESCRIPTION)) = 'novedad' AND LOWER(TRIM(HLOD.DEFINITION_KEY)) = 'novedad'
      HAVING COUNT(HLOD.HLL_USE) > 1
      GROUP BY HLOD.HLL_USE
;

--LISTAR LOS LOGS QUE TIENEN MAS DE UNA NOVEDAD
SELECT *
FROM ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD
INNER JOIN (SELECT HLOD.HLL_USE
            FROM ADELIA.HLL_LOG_OBJECT_DEFINITION HLOD
            WHERE 1=1
                  AND LOWER(TRIM(HLOD.DESCRIPTION)) = 'novedad' AND LOWER(TRIM(HLOD.DEFINITION_KEY)) = 'novedad'
                  HAVING COUNT(HLOD.HLL_USE) > 1
                  GROUP BY HLOD.HLL_USE
) DUPLICADOS ON DUPLICADOS.HLL_USE = HLOD.HLL_USE AND LOWER(TRIM(HLOD.DESCRIPTION)) = 'novedad' AND LOWER(TRIM(HLOD.DEFINITION_KEY)) = 'novedad'
WHERE HLOD.OLMARK != '4092023'
      AND HLOD.HLL_DEFINITION_SOURCE = '[ :receiver :args | receiver ]'
      
;
