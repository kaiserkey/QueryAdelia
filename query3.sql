--De la liq ordinaria de junio, totales por tipo de concepto, tipo concepto (decode) , cant, monto total, 
-- S no remunerativo
--D descuento
--A aportes patronales
--DE descuento externo
--C remunerativo
--F salario familiar
-- B base de calculo
--O otros no remunerativos

select decode(trim(CL.TIPO_CONCEPTO), 'S', 'No Remunerativo', 
                                    'D', 'Descuento', 
                                    'A', 'Aportes Patronales', 
                                    'DE', 'Descuento Externo', 
                                    'C', 'Remunerativo', 
                                    'F', 'Salario Familiar', 
                                    'B', 'Base de Calculo', 
                                    'O', 'Otros no Remunerativos',
                                    'Otro') tipo_de_concepto, 
        count(*) cantidad, 
        sum(ACL.MONTO) monto_total
from ADELIA.APLICACION_CONCEPTO_LIQ acl
inner join ADELIA.CONCEPTO_LIQUIDACION cl on CL.OBJECTID = ACL.CONCEPTO_LIQ
inner join ADELIA.LIQUIDACION_CARGO lc on LC.OBJECTID = ACL.LIQUIDACION_CARGO
inner join ADELIA.LIQUIDACION l on L.OBJECTID = LC.LIQUIDACION
where 1=1
and L.NUMERO_LIQ = 2833
group by CL.TIPO_CONCEPTO
order by 3 desc


SELECT LC.NRO_DOCUMENTO, CL.CODE, CL.DESCRIPTION, ACL.MONTO, ACL.CANTIDAD, ACL.PERIODO
from ADELIA.APLICACION_CONCEPTO_LIQ acl
inner join ADELIA.CONCEPTO_LIQUIDACION cl on CL.OBJECTID = ACL.CONCEPTO_LIQ
inner join ADELIA.LIQUIDACION_CARGO lc on LC.OBJECTID = ACL.LIQUIDACION_CARGO
inner join ADELIA.LIQUIDACION l on L.OBJECTID = LC.LIQUIDACION
where 1=1
and L.NUMERO_LIQ IN (2833,2841,2824)
AND CL.CODE LIKE '064-%'


SELECT TRUNC( TO_DATE() /6.1)+1 FROM DUAL