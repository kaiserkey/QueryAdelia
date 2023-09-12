--B�squeda de patrones en una columna
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), 'GONZALEZ|CRUZ|GOMEZ');

--B�squeda de patrones con comodines + * ? .
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), 'GONZALEZ \w+');

/*
\w: Esto coincide con cualquier car�cter alfanum�rico (letras y n�meros) y el guion bajo "_".

*: Este es un cuantificador que significa "cero o m�s repeticiones". Despu�s de "GONZALEZ" puede haber cero o m�s caracteres alfanum�ricos.

Al usar \w*, estamos permitiendo que cualquier combinaci�n de letras y n�meros despu�s de "GONZALEZ" sea v�lida en la b�squeda. Si deseas limitar la b�squeda solo a letras, podr�as reemplazar \w con [a-zA-Z] para que coincida solo con letras en may�sculas y min�sculas.

+ (M�s): Coincide con una o m�s repeticiones del car�cter o grupo anterior a la expresion.

? (Interrogaci�n): Coincide con cero o una repetici�n del car�cter o grupo anterior a la expresion.

*/

--B�squeda de patrones con caracteres espec�ficos
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), '[aeiouAEIOU]');

/*
[ ] (Corchetes): En una expresi�n regular, los corchetes se utilizan para crear una clase de caracteres. Dentro de los corchetes, puedes enumerar los caracteres que deseas buscar. La expresi�n regular coincidir� con cualquier car�cter que se encuentre dentro de esta lista.

aeiouAEIOU: Esto significa que la expresi�n regular coincidir� con cualquier cadena que contenga al menos una de estas vocales en cualquier posici�n ya sean minusculas o mayusculas.
*/

--B�squeda de rangos de caracteres:
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), '[w-wW-W]');

/*
[ ] (Corchetes): los corchetes se utilizan para crear una clase de caracteres en una expresi�n regular.

- (Guion): El guion se utiliza dentro de los corchetes para definir un rango de caracteres. Por ejemplo, [A-F] representa un rango de caracteres desde 'A' hasta 'F', incluyendo todas las letras alfab�ticas en may�scula que est�n en ese rango.

[A-F]: Esto coincidir� con cualquier car�cter en el campo "codigo" que sea una letra may�scula entre 'A' y 'F'. Por lo tanto, buscar� registros donde el campo contenga caracteres como 'A', 'B', 'C', 'D', 'E' o 'F'.
*/


--B�squeda de patrones negativos:
SELECT * 
FROM ADELIA.PERSONA P
WHERE NOT REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), '[0-9]');

/*
NOT REGEXP_LIKE: se utiliza para negar una expresi�n regular. Esto significa que la consulta seleccionar� registros donde el patr�n no se cumpla.

[0-9]: es una expresi�n regular que representa cualquier d�gito num�rico del 0 al 9. Entonces, REGEXP_LIKE(texto, '[0-9]') coincidir� con registros donde la columna "texto" contenga al menos un d�gito num�rico.
*/


--Reemplazo de texto:

UPDATE mi_tabla SET descripcion = REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4');
/*
REGEXP_REPLACE: es una funci�n que permite reemplazar el texto en una columna basado en un patr�n de expresi�n regular.

SET descripcion = REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4'): Aqu� estamos indicando que queremos actualizar la columna "descripcion". REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4') es la expresi�n que realizar� el reemplazo. Esto significa que todas las ocurrencias de "GPT-3" en la columna "descripcion" se reemplazar�n por "GPT-4".
*/


