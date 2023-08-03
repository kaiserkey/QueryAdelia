select count(*)
from ADELIA.AGENTE a
inner join ADELIA.PERSONA p on A.PERSONA = P.OBJECTID
--where trunc ((trunc (sysdate, 'yyyy') - trunc (P.FECHA_NACIMIENTO, 'yyyy'))/365)  >= 60 -- 17712
--where trunc((sysdate - P.FECHA_NACIMIENTO)/365) >= 60 --17252
where GET_EDAD_A_FECHA(P.FECHA_NACIMIENTO, sysdate) >= 60 --17210

select *
from ADELIA.CONCEPTO_LIQUIDACION cl
-- S no remunerativo
--D descuento
--A aportes patronales
--DE descuento externo
--C remunerativo
--F salario familiar
-- B base de calculo
--O otros no remunerativos
where cl.tipo_concepto in ('O', 'B')

select P.NOMBRE, P.APELLIDO, C.ESTADO, trunc((trunc(sysdate, 'yyyy')-trunc(C.FECHA_DESIGNACION, 'yyyy'))/365) años_de_antiguedad
from ADELIA.AGENTE a
inner join ADELIA.PERSONA p on P.OBJECTID = A.PERSONA
inner join ADELIA.CARGO c on C.AGENTE = A.OBJECTID
where c.estado = '01'
--order by c.estado desc