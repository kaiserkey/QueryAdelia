select escalafon, sum(cantidad), sum(total), LISTAGG( porc_os , ', ') WITHIN GROUP (ORDER BY porc_os) 
from (
    select escalafon, porc_os, count(distinct nro_documento) cantidad, sum(remu) total --,LISTAGG(porc_os) WITHIN GROUP (ORDER BY porc_os)
    from (
    select substr(e.CODE,3,2)||' - '|| e.DESCRIPTION escalafon,p.NRO_DOCUMENTO,
    sum(case when cl.TIPO_CONCEPTO = 'C' then ac.MONTO else 0 end) remu, 
    nvl(sum(case when cl.CODE like '502%' and to_number(ac.CANTIDAD) > 1 then to_number(ac.CANTIDAD) else null end),0) porc_os,
    sum(case when cl.TIPO_CONCEPTO = 'C' then ac.MONTO else 0 end) * nvl(sum(case when cl.CODE like '502%' and to_number(ac.CANTIDAD) > 1 then to_number(ac.CANTIDAD) else null end),1) / 100 desc_simulado,
    nvl(sum(case when cl.CODE like '502%' then ac.MONTO else 0 end),0)
    - nvl(sum(case when cl.TIPO_CONCEPTO = 'C' then ac.MONTO else 0 end),0) * nvl(sum(case when cl.CODE like '502%' and to_number(ac.CANTIDAD) > 1 then to_number(ac.CANTIDAD) else null end),1) / 100 control
    from adelia.aplicacion_concepto_liq ac
    inner join adelia.liquidacion_cargo lc on ac.LIQUIDACION_CARGO = lc.OBJECTID
    inner join adelia.liquidacion l on l.OBJECTID = lc.LIQUIDACION
    inner join adelia.concepto_liquidacion cl on cl.OBJECTID = ac.CONCEPTO_LIQ
    inner join adelia.cargo c on c.OBJECTID = lc.CARGO
    inner join adelia.escalafon e on c.ESCALAFON = e.OBJECTID
    inner join adelia.agente a on a.OBJECTID = c.AGENTE 
    inner join adelia.persona p on p.OBJECTID = a.PERSONA
    INNER JOIN ADELIA.TIPO_LIQUIDACION TL ON TL.OBJECTID = L.TIPO_LIQ
    inner join adelia.area ar on ar.OBJECTID = c.AREA
    where l.NUMERO_LIQ = '71089'
    and tl.CODE = '0001'
    and ar.CODE = '000003'
    group by p.NRO_DOCUMENTO,substr(e.CODE,3,2)||' - '|| e.DESCRIPTION
    having sum(case when cl.CODE like '502%' and to_number(ac.CANTIDAD) > 1 then to_number(ac.CANTIDAD) else null end) is not null 
    /*and 
    nvl(sum(case when cl.CODE like '502%' then ac.MONTO else 0 end),0)
    - nvl(sum(case when cl.TIPO_CONCEPTO = 'C' then ac.MONTO else 0 end),0) * nvl(sum(case when cl.CODE like '502%' and to_number(ac.CANTIDAD) > 1 then to_number(ac.CANTIDAD) else null end),1) / 100 not between -1 and 1*/
    ) group by escalafon, porc_os
) group by escalafon