--Listar agentes que tengan inasistencias desde Enero a julio, y verificar si esa inasistencia esta comprendida en el rango de alguna licencia

--dni, apellido y nombre, escalafon, dependencia, dia inasistencia, cod inasistencia, justificada, cod licencia, desde, hasta.

--12345678, escalafon gral, programa informatico, 01/07/2023, 404-lic por razon salud, SI, 404-lic por razon salud, 15/06/2023, 30/07/2023
--12345678, escalafon gral, programa informatico, 01/07/2023, 404-lic por razon salud, SI, 0, 0,   0

--017A -> INASISTENCIAS
--017B -> LICENCIAS

SELECT P.NRO_DOCUMENTO DNI,
       TRIM(P.APELLIDO || ' ' || P.NOMBRE) NOMBRE_COMPLETO,
       E.DESCRIPTION ESCALAFON,
       PF.ID || ' - ' || PF.DESCRIPTION DEPENDENCIA,
       TO_CHAR(AC.FECHA, 'DD-MM-YYYY') FECHA,
       TRIM(TAC.CODE) || '-' || TAC.DESCRIPTION CODIGO,
       CASE WHEN AC.IS_JUSTIFICADA = 1 THEN 'SI' ELSE 'NO' END JUSTIFICADA,
       LIC.CODIGO Codigo_Lic,
       LIC.FECHA_DESDE,
       LIC.FECHA_HASTA
FROM ADELIA.PERSONA P
INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID
INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
INNER JOIN ADELIA.DEFINICION_CARGO DC ON DC.OBJECTID = C.DEFINICION_CARGO
INNER JOIN ADELIA.POF_SAF PF ON PF.NODO_ESTRUCTURA = C.NODOPOF_ACTUAL
INNER JOIN ADELIA.ESCALAFON E ON C.ESCALAFON = E.OBJECTID
INNER JOIN ADELIA.AUSENCIA_CARGO AC ON AC.CARGO = C.OBJECTID
INNER JOIN ADELIA.TIPO_AUSENCIA_CARGO TAC ON TAC.OBJECTID = AC.TIPO_AUSENCIA
LEFT JOIN (
            SELECT P.NRO_DOCUMENTO, 
                   TRIM(TAC.CODE) || '-' || TAC.DESCRIPTION CODIGO, 
                   AC.FECHA FECHA_DESDE, 
                   AC.FECHA_HASTA
            FROM ADELIA.PERSONA P
            INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID
            INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
            INNER JOIN ADELIA.AUSENCIA_CARGO AC ON AC.CARGO = C.OBJECTID
            INNER JOIN ADELIA.TIPO_AUSENCIA_CARGO TAC ON TAC.OBJECTID = AC.TIPO_AUSENCIA
            WHERE 1=1
                  AND AC.OBJECTID LIKE '017B%'
                  AND AC.FECHA BETWEEN TO_DATE('01-01-2023','DD-MM-YYYY') AND SYSDATE) LIC ON LIC.NRO_DOCUMENTO = P.NRO_DOCUMENTO AND AC.FECHA BETWEEN LIC.FECHA_DESDE AND LIC.FECHA_HASTA 
WHERE 1=1
      --AND P.NRO_DOCUMENTO = '21383850'
      AND AC.OBJECTID LIKE '017A%'
      AND AC.FECHA BETWEEN TO_DATE('01-01-2023','DD-MM-YYYY') AND SYSDATE
      --AND NVL(AC.IS_JUSTIFICADA, 0) = 1
      AND LIC.NRO_DOCUMENTO IS NULL
      
      
      
SELECT P.NRO_DOCUMENTO, 
       TRIM(TAC.CODE) || '-' || TAC.DESCRIPTION CODIGO, 
       AC.FECHA FECHA_DESDE, 
       AC.FECHA_HASTA
FROM ADELIA.PERSONA P
INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID
INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
INNER JOIN ADELIA.AUSENCIA_CARGO AC ON AC.CARGO = C.OBJECTID
INNER JOIN ADELIA.TIPO_AUSENCIA_CARGO TAC ON TAC.OBJECTID = AC.TIPO_AUSENCIA
WHERE 1=1
      AND AC.OBJECTID LIKE '017B%'
      AND AC.FECHA BETWEEN TO_DATE('01-01-2023','DD-MM-YYYY') AND SYSDATE