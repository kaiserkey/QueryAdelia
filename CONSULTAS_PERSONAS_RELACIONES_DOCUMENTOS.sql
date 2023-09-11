--RELACIONES FAMILIARES CON DOCUMENTOS REPETIDOS Y CAMBIOS DE SEXO
--COUNT: 5995
WITH Mapeo_Vinculo AS (
  SELECT '1063' AS Codigo, 'ATENCION FAMILIAR' AS Valor FROM DUAL
  UNION ALL
  SELECT '0150', 'HIJO/A' FROM DUAL
  UNION ALL
  SELECT '015A', 'OTRO' FROM DUAL
  UNION ALL
  SELECT '0151', 'PADRE/MADRE' FROM DUAL
  UNION ALL
  SELECT '014F', 'C�NYUGUE' FROM DUAL
  UNION ALL
  SELECT '4F91', 'REPRESENTANTE' FROM DUAL
), Mapeo_Agente AS (
    SELECT A.OBJECTID AGID, P.NRO_DOCUMENTO, TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE) NOMBRE_COMPLETO
    FROM ADELIA.PERSONA P
    INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID
), Mapeo_Repetidos AS (
    SELECT TRIM(P.NRO_DOCUMENTO) NRO_DOCUMENTO
    FROM ADELIA.PERSONA P
    HAVING COUNT(TRIM(P.NRO_DOCUMENTO)) > 1
    GROUP BY TRIM(P.NRO_DOCUMENTO)
)
SELECT TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE) NOMBRE_COMPLETO_PERSONA, 
       TRIM(P.NRO_DOCUMENTO) DOCUMENTO_PERSONA,
       TRIM(TD.DESCRIPTION) TIPO_DOCUMENTO_PERSONA,
       P.CUIT_CUIL CUIT_CUIL_PERSONA, 
       P.SEXO SEXO_PERSONA, 
       P.FECHA_NACIMIENTO FECHA_NACIMIENTO_PERSONA, 
       P.FECHA_DEFUNCION FECHA_DEFUNCION_PERSONA,
       TRIM(AGENTE.NRO_DOCUMENTO) DOCUMENTO_AGENTE,
       AGENTE.NOMBRE_COMPLETO NOMBRE_COMPLETO_AGENTE,
       NVL2(MV.Valor, MV.Valor, 'Otro') VINCULO
FROM ADELIA.PERSONA P
INNER JOIN ADELIA.TIPO_DOCUMENTO TD ON TD.OBJECTID = P.TIPO_DOCUMENTO
INNER JOIN ADELIA.RELACION_AGENTE_PERSONA RAP ON RAP.PERSONA = P.OBJECTID
INNER JOIN Mapeo_Agente AGENTE ON AGENTE.AGID = RAP.AGENTE
LEFT JOIN Mapeo_Vinculo MV ON SUBSTR(RAP.OBJECTID,1,4) = MV.Codigo
WHERE TRIM(P.NRO_DOCUMENTO) IN (SELECT TRIM(P.NRO_DOCUMENTO)
                                FROM ADELIA.PERSONA P
                                INNER JOIN ADELIA.TIPO_DOCUMENTO TD ON TD.OBJECTID = P.TIPO_DOCUMENTO
                                INNER JOIN Mapeo_Repetidos REPETIDOS ON REPETIDOS.NRO_DOCUMENTO = TRIM(P.NRO_DOCUMENTO)
                                WHERE REGEXP_LIKE(TD.DESCRIPTION, 'DOCUMENTO UNICO')
)
ORDER BY TRIM(P.NRO_DOCUMENTO);

;

--PERSONAS CON DOCUMENTOS REPETIDOS QUE NO SON AGENTES
SELECT TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE) NOMBRE_COMPLETO, P.NRO_DOCUMENTO DOCUMENTO, TRIM(TD.DESCRIPTION) TIPO_DOCUMENTO, P.CUIT_CUIL, P.SEXO, P.FECHA_NACIMIENTO, P.FECHA_DEFUNCION
FROM ADELIA.PERSONA P
INNER JOIN ADELIA.TIPO_DOCUMENTO TD ON TD.OBJECTID = P.TIPO_DOCUMENTO
INNER JOIN (SELECT TRIM(P.NRO_DOCUMENTO) NRO_DOCUMENTO
                                FROM ADELIA.PERSONA P
                                HAVING COUNT(TRIM(P.NRO_DOCUMENTO)) > 1
                                GROUP BY TRIM(P.NRO_DOCUMENTO)) REPETIDOS ON REPETIDOS.NRO_DOCUMENTO = TRIM(P.NRO_DOCUMENTO)
WHERE REGEXP_LIKE(TD.DESCRIPTION, 'DOCUMENTO UNICO')
AND TRIM(P.NRO_DOCUMENTO) NOT IN (
SELECT TRIM(P.NRO_DOCUMENTO)
FROM ADELIA.PERSONA P
INNER JOIN ADELIA.TIPO_DOCUMENTO TD ON TD.OBJECTID = P.TIPO_DOCUMENTO
INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID
INNER JOIN ADELIA.RELACION_AGENTE_PERSONA RAP ON RAP.AGENTE = A.OBJECTID
INNER JOIN (SELECT TRIM(P.NRO_DOCUMENTO) NRO_DOCUMENTO
                                FROM ADELIA.PERSONA P
                                HAVING COUNT(TRIM(P.NRO_DOCUMENTO)) > 1
                                GROUP BY TRIM(P.NRO_DOCUMENTO)) REPETIDOS ON REPETIDOS.NRO_DOCUMENTO = TRIM(P.NRO_DOCUMENTO)
WHERE REGEXP_LIKE(TD.DESCRIPTION, 'DOCUMENTO UNICO')
)

;

--AGENTES CON DOCUMENTOS REPETIDOS
SELECT TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE) NOMBRE_COMPLETO, P.NRO_DOCUMENTO DOCUMENTO, TRIM(TD.DESCRIPTION) TIPO_DOCUMENTO, P.CUIT_CUIL, P.SEXO, P.FECHA_NACIMIENTO, P.FECHA_DEFUNCION
FROM ADELIA.PERSONA P
INNER JOIN ADELIA.TIPO_DOCUMENTO TD ON TD.OBJECTID = P.TIPO_DOCUMENTO
INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID
INNER JOIN (SELECT TRIM(P.NRO_DOCUMENTO) NRO_DOCUMENTO
                                FROM ADELIA.PERSONA P
                                HAVING COUNT(TRIM(P.NRO_DOCUMENTO)) > 1
                                GROUP BY TRIM(P.NRO_DOCUMENTO)) REPETIDOS ON REPETIDOS.NRO_DOCUMENTO = TRIM(P.NRO_DOCUMENTO)
WHERE REGEXP_LIKE(TD.DESCRIPTION, 'DOCUMENTO UNICO')
ORDER BY TRIM(P.NRO_DOCUMENTO)
--COUNT = 269
  
;

--DOCUMENTOS REPETIDOS
SELECT TRIM(P.NRO_DOCUMENTO) NRO_DOCUMENTO
FROM ADELIA.PERSONA P
HAVING COUNT(TRIM(P.NRO_DOCUMENTO)) > 1
GROUP BY TRIM(P.NRO_DOCUMENTO)

;

--BUSCAR DOCUMENTO
SELECT *
FROM ADELIA.PERSONA P
WHERE TRIM(P.NRO_DOCUMENTO) = '48354061'

;

--BUSCAR DOCUEMNTOS CON CAMPOS NO NUMERICOS
SELECT *
FROM ADELIA.PERSONA P
WHERE NOT REGEXP_LIKE(TRIM(P.NRO_DOCUMENTO), '^[0-9]+$');

;

--OBTENER LA RELACION CON EL AGENTE DE UNA PERSONA
WITH Mapeo_Vinculo AS (
  SELECT '1063' AS Codigo, 'ATENCION FAMILIAR' AS Valor FROM DUAL
  UNION ALL
  SELECT '0150', 'HIJO/A' FROM DUAL
  UNION ALL
  SELECT '015A', 'OTRO' FROM DUAL
  UNION ALL
  SELECT '0151', 'PADRE/MADRE' FROM DUAL
  UNION ALL
  SELECT '014F', 'C�NYUGUE' FROM DUAL
  UNION ALL
  SELECT '4F91', 'REPRESENTANTE' FROM DUAL
), Mapeo_Agente AS (
    SELECT A.OBJECTID AGID, P.NRO_DOCUMENTO, TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE) NOMBRE_COMPLETO
    FROM ADELIA.PERSONA P
    INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID
)
SELECT TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE) NOMBRE_COMPLETO_PERSONA, 
       TRIM(P.NRO_DOCUMENTO) DOCUMENTO_PERSONA,
       TRIM(TD.DESCRIPTION) TIPO_DOCUMENTO_PERSONA,
       P.CUIT_CUIL CUIT_CUIL_PERSONA, 
       P.SEXO SEXO_PERSONA, 
       P.FECHA_NACIMIENTO FECHA_NACIMIENTO_PERSONA, 
       P.FECHA_DEFUNCION FECHA_DEFUNCION_PERSONA,
       TRIM(AGENTE.NRO_DOCUMENTO) DOCUMENTO_AGENTE,
       AGENTE.NOMBRE_COMPLETO NOMBRE_COMPLETO_AGENTE,
       NVL2(MV.Valor, MV.Valor, 'Otro') VINCULO
FROM ADELIA.PERSONA P
INNER JOIN ADELIA.TIPO_DOCUMENTO TD ON TD.OBJECTID = P.TIPO_DOCUMENTO
INNER JOIN ADELIA.RELACION_AGENTE_PERSONA RAP ON RAP.PERSONA = P.OBJECTID
INNER JOIN Mapeo_Agente AGENTE ON AGENTE.AGID = RAP.AGENTE
LEFT JOIN Mapeo_Vinculo MV ON SUBSTR(RAP.OBJECTID,1,4) = MV.Codigo
WHERE 1=1
      AND (TRIM(P.NRO_DOCUMENTO) IN ('00000000')--DNI
      OR TRIM(AGENTE.NRO_DOCUMENTO) IN ('00000000'))--DNI
ORDER BY TRIM(P.NRO_DOCUMENTO);