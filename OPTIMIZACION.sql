--La sentencia EXPLAIN PLAN te permite obtener informaci�n detallada sobre c�mo Oracle planea ejecutar una consulta SQL sin ejecutarla realmente.
EXPLAIN PLAN FOR
SELECT * 
FROM ADELIA.PERSONA P 
INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID

;

-- Para ver el plan de ejecuci�n
SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY)

;


