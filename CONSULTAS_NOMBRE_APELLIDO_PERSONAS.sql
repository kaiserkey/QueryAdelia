SELECT *
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), '[^a-zA-Z������������''"�`. ]', 'c') --EXPRESION REGULAR PARA OBTENER LOS NOMBRES QUE NO ESTEN EN LA EXPRESION

;


--PUCHETA IGNACIO VALENTINO
SELECT *
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), 'SORIA', 'c')
--AND P.SEXO = 'M'
--27394684

;

select *
from ADELIA.PERSONA p
where trim(p.NRO_DOCUMENTO) = '69696969'

