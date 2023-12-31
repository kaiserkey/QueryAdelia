--de una agente de enero mostras, neto de cada ordinaria desde enero a junio.

dni,     nombre, apellido, 1, 2 , 3 , 4 ,5 ,6
12345678 juancito         80214 , 90214, 



select mes1.dni, mes1.c, mes2.c
from (select 12345678 dni, 1 c
        from dual) mes1
inner join ( select 12345678 dni, 2 c 
            from dual) mes2 on mes1.dni = mes2.dni


---16447781  
--2797,2807,2814,2824,2833        
            
SELECT P.NRO_DOCUMENTO, P.NOMBRE, P.APELLIDO, MES1.NETO_ENERO, MES2.NETO_FEBRERO, MES3.NETO_MARZO, MES4.NETO_ABRIL, MES5.NETO_MAYO, MES6.NETO_JUNIO
FROM ADELIA.AGENTE A
INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
--ENERO
INNER JOIN (SELECT P.NRO_DOCUMENTO DNI, NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) NETO_ENERO
            FROM ADELIA.AGENTE A
            INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
            INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON LC.CARGO = C.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION L ON L.OBJECTID = LC.LIQUIDACION
            WHERE L.NUMERO_LIQ = 2792) MES1 ON P.NRO_DOCUMENTO = MES1.DNI
--FEBRERO              
INNER JOIN (SELECT P.NRO_DOCUMENTO DNI, NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) NETO_FEBRERO
            FROM ADELIA.AGENTE A
            INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
            INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON LC.CARGO = C.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION L ON L.OBJECTID = LC.LIQUIDACION
            WHERE L.NUMERO_LIQ = 2797) MES2 ON P.NRO_DOCUMENTO = MES2.DNI
--MARZO            
INNER JOIN (SELECT P.NRO_DOCUMENTO DNI, NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) NETO_MARZO
            FROM ADELIA.AGENTE A
            INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
            INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON LC.CARGO = C.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION L ON L.OBJECTID = LC.LIQUIDACION
            WHERE L.NUMERO_LIQ = 2807) MES3 ON P.NRO_DOCUMENTO = MES3.DNI
--ABRIL            
INNER JOIN (SELECT P.NRO_DOCUMENTO DNI, NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) NETO_ABRIL
            FROM ADELIA.AGENTE A
            INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
            INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON LC.CARGO = C.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION L ON L.OBJECTID = LC.LIQUIDACION
            WHERE L.NUMERO_LIQ = 2814) MES4 ON P.NRO_DOCUMENTO = MES4.DNI
--MAYO            
INNER JOIN (SELECT P.NRO_DOCUMENTO DNI, NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) NETO_MAYO
            FROM ADELIA.AGENTE A
            INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
            INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON LC.CARGO = C.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION L ON L.OBJECTID = LC.LIQUIDACION
            WHERE L.NUMERO_LIQ = 2824) MES5 ON P.NRO_DOCUMENTO = MES5.DNI
--JUNIO
INNER JOIN (SELECT P.NRO_DOCUMENTO DNI, NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) NETO_JUNIO
            FROM ADELIA.AGENTE A
            INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
            INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON LC.CARGO = C.OBJECTID
            INNER JOIN ADELIA.LIQUIDACION L ON L.OBJECTID = LC.LIQUIDACION
            WHERE L.NUMERO_LIQ = 2833) MES6 ON P.NRO_DOCUMENTO = MES6.DNI     
          
                             



SELECT P.NRO_DOCUMENTO DNI, 
       TRIM(P.APELLIDO)||' '||TRIM(P.NOMBRE) NOMBRE_COMPLETO,
       SUM(CASE WHEN L.NUMERO_LIQ = 2792 
            THEN NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) 
            ELSE 0 END) ENERO,
       SUM(CASE WHEN L.NUMERO_LIQ = 2797 
            THEN NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) 
            ELSE 0 END) FEBRERO,
       SUM(CASE WHEN L.NUMERO_LIQ = 2807 
            THEN NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) 
            ELSE 0 END) MARZO,
       SUM(CASE WHEN L.NUMERO_LIQ = 2814 
            THEN NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) 
            ELSE 0 END) ABRIL,
       SUM(CASE WHEN L.NUMERO_LIQ = 2824 
            THEN NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0) 
            ELSE 0 END) MAYO,
       SUM(CASE WHEN L.NUMERO_LIQ = 2833 
            THEN NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0)
            ELSE 0 END) JUNIO     
FROM ADELIA.AGENTE A
INNER JOIN ADELIA.PERSONA P ON P.OBJECTID = A.PERSONA
INNER JOIN ADELIA.CARGO C ON C.AGENTE = A.OBJECTID
INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON LC.CARGO = C.OBJECTID
INNER JOIN ADELIA.LIQUIDACION L ON L.OBJECTID = LC.LIQUIDACION
WHERE L.NUMERO_LIQ IN (2792, 2797, 2807, 2814, 2824, 2833) 
GROUP BY P.NRO_DOCUMENTO, P.APELLIDO, P.NOMBRE