--Listar agentes liquidados en la liq de julio tentativa, mostrando los siguientes datos:
--Dni, apellido y nombre, edad, dependencia,escalafon,categoria,tiene_asig, OS, neto total.  

12345678, 50, MINISTERIO DE SALUD, ESCALAFON GRAL; CATEGORIA F, SI, DOSEP, 12354498
12345678, 50, MINISTERIO DE SALUD, TELEVISION; ENCARGADO CAT 3, NO, DOSEP, 4456566


502 cpto os
406 hijo
407 hijo disc
--848

SELECT 
    P.NRO_DOCUMENTO, 
    P.APELLIDO || ', ' || P.NOMBRE Agente, 
    ADELIA.GET_EDAD_A_FECHA(P.FECHA_NACIMIENTO, sysDate) Edad, 
    PF.ID || '-' || PF.DESCRIPTION Dependencia, 
    trim(E.CODE) || '-' || E.DESCRIPTION Escalafon,
    trim(DC.Code) || '-' || DC.DESCRIPTION Categoria,
    case when asig.nro_documento is null then 'No' else 'Si' end asignacion,
    OS.os
from ADELIA.AGENTE A 
inner join ADELIA.PERSONA P on A.PERSONA = P.OBJECTID 
inner join ADELIA.CARGO C on C.AGENTE = A.OBJECTID 
inner join ADELIA.DEFINICION_CARGO DC on C.DEFINICION_CARGO = DC.OBJECTID
inner join ADELIA.POF_SAF PF on PF.NODO_ESTRUCTURA = C.NODOPOF_ACTUAL
inner join ADELIA.ESCALAFON E on C.ESCALAFON = E.OBJECTID
inner join ADELIA.LIQUIDACION_CARGO LC on LC.CARGO = C.OBJECTID
inner join ADELIA.LIQUIDACION Liq on LIQ.OBJECTID = LC.LIQUIDACION
inner join ADELIA.PROCESO_LIQUIDACION PL on PL.OBJECTID = LIQ.PROCESO_LIQ
left join (select distinct LC.NRO_DOCUMENTO --CL.code, CL.DESCRIPTION
            from ADELIA.APLICACION_CONCEPTO_LIQ ACL
            inner join ADELIA.CONCEPTO_LIQUIDACION CL on CL.OBJECTID = ACL.CONCEPTO_LIQ
            inner join ADELIA.LIQUIDACION_CARGO LC on ACL.LIQUIDACION_CARGO = LC.OBJECTID
            inner join ADELIA.LIQUIDACION Liq on LIQ.OBJECTID = LC.LIQUIDACION
            inner join ADELIA.PROCESO_LIQUIDACION PL on PL.OBJECTID = LIQ.PROCESO_LIQ
            where PL.PERIODO in (to_Date ('01/07/2023', 'dd/mm/yyyy')) 
            and CL.CODE like '40%') Asig on Asig.NRO_DOCUMENTO = LC.NRO_DOCUMENTO
left join (select distinct LC.NRO_DOCUMENTO, CL.code || ' ' || CL.DESCRIPTION OS
            from ADELIA.APLICACION_CONCEPTO_LIQ ACL
            inner join ADELIA.CONCEPTO_LIQUIDACION CL on CL.OBJECTID = ACL.CONCEPTO_LIQ
            inner join ADELIA.LIQUIDACION_CARGO LC on ACL.LIQUIDACION_CARGO = LC.OBJECTID
            inner join ADELIA.LIQUIDACION Liq on LIQ.OBJECTID = LC.LIQUIDACION
            inner join ADELIA.PROCESO_LIQUIDACION PL on PL.OBJECTID = LIQ.PROCESO_LIQ
            where PL.PERIODO in (to_Date ('01/07/2023', 'dd/mm/yyyy')) 
            and CL.CODE like '502%') OS on OS.nro_documento = P.NRO_DOCUMENTO            
where PL.PERIODO in (to_Date ('01/07/2023', 'dd/mm/yyyy'))
and Os.nro_documento is null

select * from ADELIA.AGENTE

select distinct LC.NRO_DOCUMENTO, CL.code || ' ' || CL.DESCRIPTION OS
from ADELIA.APLICACION_CONCEPTO_LIQ ACL
inner join ADELIA.CONCEPTO_LIQUIDACION CL on CL.OBJECTID = ACL.CONCEPTO_LIQ
inner join ADELIA.LIQUIDACION_CARGO LC on ACL.LIQUIDACION_CARGO = LC.OBJECTID
inner join ADELIA.LIQUIDACION Liq on LIQ.OBJECTID = LC.LIQUIDACION
inner join ADELIA.PROCESO_LIQUIDACION PL on PL.OBJECTID = LIQ.PROCESO_LIQ
where PL.PERIODO in (to_Date ('01/07/2023', 'dd/mm/yyyy')) 
and CL.CODE like '502%'
order by 1