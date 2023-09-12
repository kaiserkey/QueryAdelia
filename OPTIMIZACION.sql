--La sentencia EXPLAIN PLAN te permite obtener información detallada sobre cómo Oracle planea ejecutar una consulta SQL sin ejecutarla realmente.
EXPLAIN PLAN FOR
SELECT * 
FROM ADELIA.PERSONA P 
INNER JOIN ADELIA.AGENTE A ON A.PERSONA = P.OBJECTID

;

-- Para ver el plan de ejecución
SELECT * 
FROM TABLE(DBMS_XPLAN.DISPLAY)

;


