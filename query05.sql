select 
P.CUIT_CUIL CUIL,
trim(p.APELLIDO)||' '||trim(p.NOMBRE) nombre,
case when ant.antiguedad_pagada is null then 'No cobro antiguedad en el periodo' else ANT.ANTIGUEDAD_PAGADA end ANTIGUEDAD,
pledezma.GET_EDAD_A_FECHA(to_date(P.fecha_nacimiento,'DD/MM/YYYY'), to_date('30/06/2023','DD/MM/YYYY')) Edad,
TO_DATE(P.FECHA_NACIMIENTO),
A.FECHA_INGRESO_AP FECHA_ALTA_ORGANISMO,
P.SEXO,
PSM.ID||' - '||PSM.DESCRIPTION MINISTERIO,
PS.ID||' - '||PS.DESCRIPTION DEPENDENCIA,
SUBSTR(E.CODE,3,2)||' - '||E.DESCRIPTION CONVENIO,
dc.DESCRIPTION FUNCION, 
PLA.DESCRIPTION CARACTER,
case when rec.cuil is not null then 'S' ELSE '' END RECATEGORIZADO,
ac.FECHA alta, 
bc.FECHA baja,
case when pas.PORCENTAJE is null then '' else 'S' END  PASIVIDAD,
PAS.FECHA_DESDE,
PAS.FECHA_HASTA,
CASE WHEN sus.USUARIO is not null THEN 'S' ELSE '' end SUSPENDIDO,
sus.fecha_estado FECHA_DESDE_SUSP,
case when sus.usuario is not null then nvl(sus.OBSERVACIONES,'No registrado por: '|| sus.usuario) else '' end  MOTIVO_SUSPENSION,
CASE WHEN LIC.DESDE IS NULL THEN '' ELSE 'S' END AS LICENCIA,
LIC.TIPO_LICENCIA,
LIC.CON_GOCE,
LIC.DESDE,
LIC.HASTA,
lic.cant_dias,
lic.diagnostico,
case when art.fecha_accidente is null then '' else 'S' end accidente,
art.nro_exte expediente,
art.fecha_accidente,
art.fecha_alta_medica,
art.aseguradora,
art.reingreso,
trim(d.STREET_NUMBER)||' - '||d.STREET_NAME as direccion, 
ci.DESCRIPTION as localidad , 
dep.DESCRIPTION as departamento, 
prov.DESCRIPTION as provincia, 
ci.ZIP_CODE as cod_postal,
nvl(p.TELEFONO_CELULAR,'') as telefono1,
nvl(c.NRO_TELEFONO,'') as telefono2, 
nvl(d.PHONE_NUMBER, '') as telefono3,
tot.remu con_aportes,
tot.nore sin_aportes,
tot.asigs asignaciones_familaires,
tot.descuentos ,
tot.patr contribuciones_patronales,
tot.remu + tot.nore + tot.asigs - tot.descuentos neto
from adelia.cargo c 
inner join adelia.agente a on a.OBJECTID = c.AGENTE
inner join adelia.persona p on a.PERSONA = p.OBJECTID
inner join adelia.definicion_cargo dc on c.DEFINICION_CARGO = dc.OBJECTID
inner join adelia.escalafon e on e.OBJECTID = c.ESCALAFON
inner join adelia.area ar on c.area = ar.OBJECTID
inner join adelia.alta_cargo ac on c.alta = ac.OBJECTID
left join adelia.baja_cargo bc on bC.OBJECTID = c.BAJA
LEFT JOIN ADELIA.POF_SAF PS ON C.NODOPOF_ACTUAL = PS.NODO_ESTRUCTURA
LEFT JOIN ADELIA.POF_SAF PSM ON PS.MINISTERIO = PSM.NODO
INNER JOIN ADELIA.PLANTA PLA ON PLA.OBJECTID = C.PLANTA
left join adelia.address d on d.OBJECTID = a.DOMICILIO
left join adelia.city ci on ci.OBJECTID = d.CITY
left join adelia.departamento dep on ci.DEPARTAMENTO = dep.OBJECTID
left join adelia.province prov on ci.PROVINCE = prov.OBJECTID
left JOIN (
        SELECT P.NRO_DOCUMENTO AS DOCU, MAX(AC.CANTIDAD) AS ANTIGUEDAD_PAGADA FROM ADELIA.APLICACION_CONCEPTO_LIQ ac
        INNER JOIN ADELIA.CONCEPTO_LIQUIDACION cl ON AC.CONCEPTO_LIQ = CL.OBJECTID
        INNER JOIN ADELIA.LIQUIDACION_CARGO LC ON AC.LIQUIDACION_CARGO = LC.OBJECTID
        INNER JOIN ADELIA.LIQUIDACION L ON LC.LIQUIDACION = L.OBJECTID
        INNER JOIN ADELIA.TIPO_LIQUIDACION TL ON TL.OBJECTID = L.TIPO_LIQ
        INNER JOIN ADELIA.CARGO C ON C.OBJECTID = LC.CARGO
        INNER JOIN ADELIA.ESCALAFON E ON E.OBJECTID = C.ESCALAFON 
        INNER JOIN ADELIA.AGENTE A ON A.OBJECTID = C.AGENTE
        INNER JOIN ADELIA.PERSONA P ON A.PERSONA = P.OBJECTID
        INNER JOIN ADELIA.PROCESO_LIQUIDACION PL ON PL.OBJECTID = L.PROCESO_LIQ
        WHERE ac.periodo <= TO_DATE('01/06/2023','DD/MM/YYYY')
        AND ac.periodo >= TO_DATE('01/01/2023','DD/MM/YYYY')
        AND CL.CODE LIKE '102%'
        and tl.CODE = '0001'
        GROUP BY P.NRO_DOCUMENTO
    ) ANT ON ANT.DOCU = P.NRO_DOCUMENTO
left join (
select * from (
    SELECT p.NRO_DOCUMENTO as doc, AA.VALOR AS PORCENTAJE, AA.FECHA_DESDE, Aa.FECHA_HASTA,RANK() OVER (PARTITION BY P.NRO_DOCUMENTO ORDER BY aa.FECHA_DESDE desc) ORDEN
    FROM ADELIA.ASIGNACION_ADICIONAL AA
    INNER JOIN ADELIA.ADICIONAL A ON AA.ADICIONAL = A.OBJECTID
    INNER JOIN ADELIA.AGENTE AG ON AA.AGENTE = AG.OBJECTID
    INNER JOIN ADELIA.PERSONA P ON AG.PERSONA = P.OBJECTID
    and A.CODE like '380%'
    order by doc
    ) where orden = 1
) pas on pas.doc = P.NRO_DOCUMENTO
LEFT join (
      SELECT *
      FROM (
      select P.NRO_DOCUMENTO as doc, AC.FECHA AS DESDE, AC.FECHA_HASTA AS HASTA, d.DESCRIPTION diagnostico
      ,TAC.GOCE_HABERES, TAC.AFECTA_ANTIGUEDAD,
      case when TAC.AFECTA_ANTIGUEDAD = 1 then 'N' else 'S' end as con_goce, 
      trim(TAC.CODE)||' - '||TAC.DESCRIPTION as tipo_licencia, trunc(ac.fecha_hasta)-trunc( ac.fecha)+1 cant_dias,
      RANK() OVER (PARTITION BY p.NRO_DOCUMENTO ORDER BY ac.FECHA desc)  ORDEN
      from adelia.ausencia_cargo ac 
      inner join adelia.TIPO_AUSENCIA_CARGO tac on tac.objectid = ac.TIPO_AUSENCIA
      inner join adelia.cargo              c on c.objectid = ac.cargo
      INNER JOIN ADELIA.ESCALAFON E ON C.ESCALAFON = E.OBJECTID
      inner join adelia.agente             a on a.objectid = c.agente
      inner join adelia.area               ar on ar.objectid = c.area
      inner join adelia.persona          p on P.OBJECTID=a.persona        
      left join adelia.diagnostico_licencia d on ac.DIAGNOSTICO = d.OBJECTID                                       
      where  substr(ac.objectid,1,4)='017B' 
      AND AR.CODE = '000003'
      )
      WHERE (DESDE <= LAST_DAY(TO_DATE('01/06/2023','DD/MM/YYYY')) and nvl(HASTA,TO_DATE('01/06/2023','DD/MM/YYYY')) >= TO_DATE('01/06/2023','DD/MM/YYYY'))
      and orden = 1
) lic on lic.doc = P.NRO_DOCUMENTO
left join (
select  DOCU,
FECHA_ESTADO,
        OBSERVACIONES as observaciones,
        CODIGO_ESTADO_CARGO estado,
        USER_NAME as usuario
from(
select    p.nro_documento as docu,
          RANK() OVER (PARTITION BY P.NRO_DOCUMENTO ORDER BY ME.TIMESTAMP_MODIFICACION DESC) ORDEN,
        FECHA FECHA_ESTADO,
        OBSERVACIONES ,
        CODIGO_ESTADO_CARGO,
        USER_NAME
        from ADELIA.PERSONA p
        inner join ADELIA.AGENTE a on P.OBJECTID = A.PERSONA
        inner join ADELIA.CARGO c on C.AGENTE = A.OBJECTID
        INNER JOIN ADELIA.MODIFICACION_ESTADO_CARGO ME ON ME.CARGO = C.OBJECTID 
        inner join ADELIA.APPLICATION_USER au on ME.USUARIO_MODIFICACION = AU.OBJECTID 
        and c.estado IN (2)
       ) 
       where orden = 1 
       and CODIGO_ESTADO_CARGO  = 2
       and FECHA_ESTADO <= last_day(to_date('01/06/2023','dd/mm/yyyy'))
)sus on sus.docu = p.NRO_DOCUMENTO
left JOIN (  
    SELECT  P.NRO_DOCUMENTO as doc,
    ca.FECHA_PRESENTACION as fecha_presentacion, CA.FECHA as fecha_accidente, 
    CA.FECHA_HASTA as fecha_alta_medica, CA.NUMERO_EXPEDIENTE as nro_exte, 
    case when tc.code = 'FEDNEW' THEN 'FEDERACION - NUEVO' 
    when tc.code = 'FEDREI' THEN 'FEDERACION - REINGRESO' 
    ELSE 'OTRO - CONTROLAR' END aseguradora,
    case when upper(tc.CODE) like '%RE%' then 'S' ELSE '' END REINGRESO
    FROM ADELIA.CERTIFICADO_AGENTE CA
    INNER JOIN ADELIA.AGENTE A ON A.OBJECTID = CA.AGENTE
    INNER JOIN ADELIA.PERSONA P ON A.PERSONA = P.OBJECTID
    INNER JOIN ADELIA.TIPO_CERTIFICADO_AGENTE TC ON TC.OBJECTID = CA.TIPO_CERTIFICADO
    WHERE 1 = 1 
    aND tc.IS_CERTIFICADO_ACCIDENTE = 1
    and add_months(to_date('01/06/2023','dd/mm/yyyy'),-1) between ca.fecha and nvl(fecha_hasta,to_date('30/12/9999','dd/mm/yyyy'))
) ART ON ART.DOC = P.NRO_DOCUMENTO
left join (
select cuil from pledezma.cuils union select cuil from pledezma.cuils2  union select cuil from pledezma.cuils3 union select cuil from pledezma.cuils4 )
 rec on rec.cuil = p.CUIT_CUIL
left join (      
 SELECT P.NRO_DOCUMENTO AS DOCU,sum(lc.TOTAL_REM_CON_APORTES) remu, sum(lc.TOTAL_REM_SIN_APORTES) nore, sum(lc.TOTAL_SALARIO_FAMILIAR) asigs, sum(lc.TOTAL_DESCUENTOS) descuentos, sum(lc.TOTAL_APORTES_PAT) patr
        from ADELIA.LIQUIDACION_CARGO LC
        INNER JOIN ADELIA.LIQUIDACION L ON LC.LIQUIDACION = L.OBJECTID
        INNER JOIN ADELIA.TIPO_LIQUIDACION TL ON TL.OBJECTID = L.TIPO_LIQ
        INNER JOIN ADELIA.CARGO C ON C.OBJECTID = LC.CARGO
        INNER JOIN ADELIA.ESCALAFON E ON E.OBJECTID = C.ESCALAFON 
        INNER JOIN ADELIA.AGENTE A ON A.OBJECTID = C.AGENTE
        INNER JOIN ADELIA.PERSONA P ON A.PERSONA = P.OBJECTID
        INNER JOIN ADELIA.PROCESO_LIQUIDACION PL ON PL.OBJECTID = L.PROCESO_LIQ
        inner join adelia.area ar on c.AREA = ar.OBJECTID
        WHERE pl.periodo <= TO_DATE('01/06/2023','DD/MM/YYYY')
        AND pl.periodo >= TO_DATE('01/01/2023','DD/MM/YYYY')
        and l.NUMERO_LIQ in (2833,2841)
        and tl.CODE = '0001'
        and ar.CODE = '000003'
        GROUP BY P.NRO_DOCUMENTO            
) tot on tot.docu = p.NRO_DOCUMENTO
where 1 = 1
and ar.CODE = '000003'
and ac.FECHA <= last_day(to_date('01/06/2023','dd/mm/yyyy')) and nvl(bc.FECHA,to_date('01/06/2023','dd/mm/yyyy')) >= to_date('01/06/2023','dd/mm/yyyy')
order by EDAD




select to_date('12/2023/31','DD/MM/YYYY') from dual

SELECT ADD_MONTHS('31/12/2023',1) FROM DUAL