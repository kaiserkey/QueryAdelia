--DEPENDENCIAS PAGADORAS EN SUPERHA QUE NO ESTAN CONFIGURADAS EN ADELIA
SELECT 
    T.CODIGO_DEPENDENCIA CODIGO,
    T.TIPO_DEPENDENCIA TIPO_DEPE, 
    T.DESCRIPCION, 
    T.CODIGO_DEPENDENCIA_DEPE DEPENDENCIA, 
    T.CODIGO_DEPENDENCIA_PAGADORA PAGADORA,
    T.jurisd_codigo MINISTERIO, 
    T.INSTITUCIONAL||'-'||T.CENCOS_CODIGO||'-'||T.PROGRAMA||'-'||T.SUBPROGRAMA||'-'||T.PROYECTO||'-'||T.ACTIVIDAD||'-'||T.FUENTE_FINANCIAMIENTO||'-'||T.FUENTE_FINANCIAMIENTO2 CONTABLE
    FROM tbdepend@sica_produccion T
WHERE T.CODIGO_DEPENDENCIA IN (
                            SELECT DISTINCT S.CODIGO_DEPENDENCIA_PAGADORA
                            FROM tbmesleg@sica_produccion LC
                            INNER JOIN tbdepend@sica_produccion S ON S.CODIGO_DEPENDENCIA = LC.DEPENDENCIA_REVISTA
                            LEFT JOIN ADELIA.POF_SAF_CONTABLE POFC ON POFC.ID = S.CODIGO_DEPENDENCIA 
                            WHERE 1=1
                            AND LC.PERIODO_LIQ = 202307
                            AND LC.NRO_LIQUIDACION IN (2842,2843)
                            AND LC.NRO_CATEGORIA IN (20,21,22,23,24,25)
                            AND LC.CUADRO = 07
                            AND POFC.ID IS NULL
)
AND T.CODIGO_DEPENDENCIA = T.CODIGO_DEPENDENCIA_PAGADORA



--BUSCA DEPENDENCIA EN SUPERHA CON SU MINISTERIO
SELECT T.CODIGO_DEPENDENCIA DEPENDENCIA, T.JURISD_CODIGO MINISTERIO
FROM tbdepend@sica_produccion T
WHERE T.CODIGO_DEPENDENCIA = '12355'


--COMPARA DEPENDENCIA PAGADORA ACTUALES EN CONTABLE SUPERHA CON CONTABLE ADELIA (DIFERENCIAS ENTRE NODOS PRESUPUESTARIOS)
SELECT *
FROM
    (SELECT DISTINCT T.CODIGO_DEPENDENCIA, T.INSTITUCIONAL||'-'||T.CENCOS_CODIGO||'-'||T.PROGRAMA||'-'||T.SUBPROGRAMA||'-'||T.PROYECTO||'-'||T.ACTIVIDAD||'-'||T.FUENTE_FINANCIAMIENTO||'-'||T.FUENTE_FINANCIAMIENTO2 CONTABLE
    FROM tbmesleg@sica_produccion LC
    INNER JOIN tbdepend@sica_produccion D ON D.CODIGO_DEPENDENCIA = LC.DEPENDENCIA_REVISTA
    INNER JOIN tbdepend@sica_produccion T ON T.CODIGO_DEPENDENCIA = D.CODIGO_DEPENDENCIA_PAGADORA
    WHERE LC.PERIODO_LIQ = 202307
    AND LC.NRO_LIQUIDACION IN (2842, 2843)
    AND LC.NRO_CATEGORIA IN (20, 21, 22, 23, 24, 25)
    AND LC.CUADRO = 07) SUPERHA       
    INNER JOIN (SELECT DISTINCT LC.DEPENDENCIA_REVISTA, POFC.CONTABLE, POFC.ID_PAG
                  FROM tbmesleg@sica_produccion LC
                  LEFT JOIN ADELIA.POF_SAF_CONTABLE POFC ON LC.DEPENDENCIA_REVISTA = POFC.ID
                  WHERE LC.PERIODO_LIQ = 202307
                  AND LC.NRO_LIQUIDACION IN (2842, 2843)
                  AND LC.NRO_CATEGORIA IN (20, 21, 22, 23, 24, 25)
                  AND LC.CUADRO = 07 ) ADELIA  ON ADELIA.DEPENDENCIA_REVISTA = SUPERHA.CODIGO_DEPENDENCIA
WHERE SUPERHA.CONTABLE != ADELIA.CONTABLE            
  
  
  
--DEPENDENCIAS QUE NO ESTAN CONFIGURADAS
SELECT DISTINCT DEPENDENCIA_REVISTA, DEPENDENCIA_PAGADORA
FROM tbmesleg@sica_produccion LC
LEFT JOIN ADELIA.POF_SAF_CONTABLE POFC ON POFC.ID = LC.DEPENDENCIA_REVISTA        
WHERE LC.PERIODO_LIQ = 202307
AND LC.NRO_LIQUIDACION IN (2842,2843)
AND LC.NRO_CATEGORIA IN (20,21,22,23,24,25)
AND LC.CUADRO = 07
AND POFC.ID IS NULL



--DEPENDENCIAS ADELIA CONFIGURADAS
SELECT
    POFC.ID, 
    POFC.DESCRIPTION,
    POFC.ID_PAG,
    POFC.DESC_PAG,
    POFC.CONTABLE 
FROM ADELIA.POF_SAF_CONTABLE POFC
--WHERE POFC.ID = '11979';


--DEPENDENCIAS EN ADELIA NO CONFIGURADAS
SELECT 
    POF.ID,
    POF.DESCRIPTION,
    POF.INSTITUCIONAL||'-'||POF.CENCOS||'-'||POF.COD_SAF_PAGADOR||'-'||POF.FUENTE1||'-'||POF.FUENTE2 CONTABLE
FROM ADELIA.POF_SAF POF
LEFT JOIN ADELIA.POF_SAF_CONTABLE POFC ON POFC.ID = POF.ID
WHERE POFC.ID IS NULL



--DEPENDENCIAS ACTUALES SUPERHA
SELECT DISTINCT DEPENDENCIA_REVISTA, DEPENDENCIA_PAGADORA, t.JURISD_CODIGo ministerio, T.INSTITUCIONAL||'-'||T.CENCOS_CODIGO||'-'||T.PROGRAMA||'-'||T.SUBPROGRAMA||'-'||T.PROYECTO||'-'||T.ACTIVIDAD||'-'||T.FUENTE_FINANCIAMIENTO||'-'||T.FUENTE_FINANCIAMIENTO2 CONTABLE
FROM tbmesleg@sica_produccion lc
INNER JOIN tbdepend@sica_produccion t on t.codigo_dependencia = dependencia_revista
WHERE LC.PERIODO_LIQ = 202307
AND LC.NRO_LIQUIDACION in (2842,2843)
AND LC.NRO_CATEGORIA in (20,21,22,23,24,25)
AND LC.CUADRO = 07
/*AND LC.DEPENDENCIA_REVISTA IN (
                                '11987', 
                                '11989',
                                '12035',
                                '12109',
                                '12253',
                                '12256',
                                '12270',
                                '12330',
                                '12335',
                                '12380',
                                '12785',
                                '12856',
                                '12879',
                                '12980',
                                '12991',
                                '34082',
                                '10399',
                                '10423',
                                '10449',
                                '10576',
                                '10588',
                                '10596',
                                '11052',
                                '11986'
)*/

        


--TODAS LAS DEPENDENCIAS SUPERHA
SELECT CODIGO_DEPENDENCIA, 
       DESCRIPCION, 
       CODIGO_DEPENDENCIA_DEPE, 
       CODIGO_DEPENDENCIA_PAGADORA, 
       INSTITUCIONAL||'-'||CENCOS_CODIGO||'-'||PROGRAMA||'-'||SUBPROGRAMA||'-'||PROYECTO||'-'||ACTIVIDAD||'-'||FUENTE_FINANCIAMIENTO||'-'||FUENTE_FINANCIAMIENTO2 CONTABLE
FROM tbdepend@sica_produccion
--WHERE CODIGO_DEPENDENCIA = '12355'
  

--DEPENDENCIAS ADELIA
SELECT COUNT(*)
FROM ADELIA.POF_SAF POF
ORDER BY POF.COD_SAF_PAGADOR



--DEPENDENCIAS HISTORICAS A CREAR SI NO TENEMOS
SELECT COUNT(DISTINCT CODIGO_DEPENDENCIA)
FROM (
    SELECT PC.CODIGO_DEPENDENCIA, 
    CASE WHEN PC.CODIGO_CUADRO = '07' THEN 'O'||SUBSTR(PC.CODIGO_FUNCION,2,3)||LPAD(NUMERO_CATEGORIA,2,'0') 
         WHEN PC.CODIGO_CUADRO = '01' AND PC.CODIGO_FUNCION = '032' THEN 'O03201'
         WHEN PC.CODIGO_CUADRO = '01' AND PC.CODIGO_FUNCION = '003' THEN 'O00301'
         WHEN PC.CODIGO_CUADRO = '01' AND PC.CODIGO_FUNCION = '004' THEN 'O00401'
         WHEN PC.CODIGO_CUADRO = '01' AND PC.CODIGO_FUNCION = '010' THEN 'O01001' 
         WHEN PC.CODIGO_CUADRO IN ( 1, 3 ) AND LENGTH(TRIM(PC.CODIGO_FUNCION))<4 THEN 'O'||RTRIM(PC.CODIGO_FUNCION)||'01'     
         ELSE  PC.CODIGO_FUNCION||LPAD(NUMERO_CATEGORIA,2,'0')
    END DEFINICION_CARGO,
    RANK() OVER (PARTITION BY PC.NRO_LEGAJO, FECHA_MOVIMIENTO ORDER BY  PC.FECHA_ALTA DESC ) ORDEN 
    FROM tbpercat@sica_produccion PC
    LEFT JOIN TBFUNCIO@SICA_PRODUCCION F ON F.CODIGO_FUNCION = PC.CODIGO_FUNCION
    LEFT JOIN TBTIPDES@SICA_PRODUCCION TD ON TD.TIPO_DESIGNACION = PC.TIPO_DESIGNACION 
    LEFT JOIN tblegajo@sica_produccion L ON L.NRO_LEGAJO = PC.NRO_LEGAJO
    LEFT JOIN (SELECT SUBSTR(RV_LOW_VALUE,1,1) CODIGO ,
               SUBSTR(RV_MEANING,1,25) DESCRIPCION
               FROM CG_REF_CODES@SICA_PRODUCCION
               WHERE RV_DOMAIN = 'ACTO') TACT ON TACT.CODIGO = PC.TIPO_ACTO 
    INNER JOIN (
                SELECT *
                FROM tbmesleg@sica_produccion LC
                WHERE LC.PERIODO_LIQ = 202307
                AND LC.NRO_LIQUIDACION IN (2842,2843)
                AND LC.NRO_CATEGORIA IN (20,21,22,23,24,25)
                AND LC.CUADRO = 07) LIQ ON LIQ.NRO_LEGAJO = PC.NRO_LEGAJO
                WHERE 1=1
) 
WHERE ORDEN = 1
AND TRIM(DEFINICION_CARGO) IN (
                                SELECT TRIM(CODE)
                                FROM ADELIA.DEFINICION_CARGO DC
)