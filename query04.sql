--De la liq ordinaria de Mayo 2023, recuperar listado de AGENTES liquidados, DNI, APELLIDO, NOMBRE; SEXO, DEPENDENCIA, NETO TOTAL; REMU TOTAL; NORE TOTAL, ASIG TOTAL; PATRONAL TOTAL, DESC TOTAL

select P.NRO_DOCUMENTO, 
       P.APELLIDO,
       P.NOMBRE, 
       P.SEXO, 
       listagg(PF.ID || '-' || PF.DESCRIPTION, ', ') within group(order by AC.FECHA)  Dependencia,
       sum(NVL(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_REM_CON_APORTES - LC.TOTAL_DESCUENTOS - LC.TOTAL_DESCUENTOS_COM - LC.TOTAL_DESCUENTOS_EXT + LC.TOTAL_SALARIO_FAMILIAR + LC.TOTAL_OTROS_NO_REM + LC.TOTAL_HABERES_NEG,0)) NETO_TOTAL,
       sum(LC.TOTAL_REM_CON_APORTES) Remunerativo,
       sum(LC.TOTAL_REM_SIN_APORTES + LC.TOTAL_OTROS_NO_REM) No_Remunerativo,
       sum(LC.TOTAL_SALARIO_FAMILIAR) Asignacion_Total,
       sum(LC.TOTAL_APORTES_PAT) Patronales,
       sum(LC.TOTAL_DESCUENTOS + LC.TOTAL_DESCUENTOS_com +LC.TOTAL_DESCUENTOS_ext) descuentos_Totales
from ADELIA.PERSONA P
inner join ADELIA.AGENTE A on A.PERSONA = P.OBJECTID
inner join ADELIA.CARGO C on C.AGENTE = A.OBJECTID
inner join ADELIA.ALTA_CARGO AC on C.ALTA = AC.OBJECTID
inner join ADELIA.LIQUIDACION_CARGO LC on LC.CARGO = C.OBJECTID
inner join ADELIA.LIQUIDACION L on LC.LIQUIDACION = L.OBJECTID
inner join Adelia.pof_saf PF on C.NODOPOF_ACTUAL = PF.NODO_ESTRUCTURA
where L.NUMERO_LIQ = 2824
group by P.NRO_DOCUMENTO, 
         P.APELLIDO,
         P.NOMBRE, 
         P.SEXO
order by length (listagg(PF.ID || '-' || PF.DESCRIPTION, ', ') within group(order by AC.FECHA)) desc



select * from ADELIA.pof_saf