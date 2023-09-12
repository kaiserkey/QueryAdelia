--Búsqueda de patrones en una columna
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), 'GONZALEZ|CRUZ|GOMEZ');

--Búsqueda de patrones con comodines + * ? .
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), 'GONZALEZ \w+');

/*
\w: Esto coincide con cualquier carácter alfanumérico (letras y números) y el guion bajo "_".

*: Este es un cuantificador que significa "cero o más repeticiones". Después de "GONZALEZ" puede haber cero o más caracteres alfanuméricos.

Al usar \w*, estamos permitiendo que cualquier combinación de letras y números después de "GONZALEZ" sea válida en la búsqueda. Si deseas limitar la búsqueda solo a letras, podrías reemplazar \w con [a-zA-Z] para que coincida solo con letras en mayúsculas y minúsculas.

+ (Más): Coincide con una o más repeticiones del carácter o grupo anterior a la expresion.

? (Interrogación): Coincide con cero o una repetición del carácter o grupo anterior a la expresion.

*/

--Búsqueda de patrones con caracteres específicos
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), '[aeiouAEIOU]');

/*
[ ] (Corchetes): En una expresión regular, los corchetes se utilizan para crear una clase de caracteres. Dentro de los corchetes, puedes enumerar los caracteres que deseas buscar. La expresión regular coincidirá con cualquier carácter que se encuentre dentro de esta lista.

aeiouAEIOU: Esto significa que la expresión regular coincidirá con cualquier cadena que contenga al menos una de estas vocales en cualquier posición ya sean minusculas o mayusculas.
*/

--Búsqueda de rangos de caracteres:
SELECT * 
FROM ADELIA.PERSONA P
WHERE REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), '[w-wW-W]');

/*
[ ] (Corchetes): los corchetes se utilizan para crear una clase de caracteres en una expresión regular.

- (Guion): El guion se utiliza dentro de los corchetes para definir un rango de caracteres. Por ejemplo, [A-F] representa un rango de caracteres desde 'A' hasta 'F', incluyendo todas las letras alfabéticas en mayúscula que están en ese rango.

[A-F]: Esto coincidirá con cualquier carácter en el campo "codigo" que sea una letra mayúscula entre 'A' y 'F'. Por lo tanto, buscará registros donde el campo contenga caracteres como 'A', 'B', 'C', 'D', 'E' o 'F'.
*/


--Búsqueda de patrones negativos:
SELECT * 
FROM ADELIA.PERSONA P
WHERE NOT REGEXP_LIKE(TRIM(P.APELLIDO) || ' ' || TRIM(P.NOMBRE), '[0-9]');

/*
NOT REGEXP_LIKE: se utiliza para negar una expresión regular. Esto significa que la consulta seleccionará registros donde el patrón no se cumpla.

[0-9]: es una expresión regular que representa cualquier dígito numérico del 0 al 9. Entonces, REGEXP_LIKE(texto, '[0-9]') coincidirá con registros donde la columna "texto" contenga al menos un dígito numérico.
*/


--Reemplazo de texto:

UPDATE mi_tabla SET descripcion = REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4');
/*
REGEXP_REPLACE: es una función que permite reemplazar el texto en una columna basado en un patrón de expresión regular.

SET descripcion = REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4'): Aquí estamos indicando que queremos actualizar la columna "descripcion". REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4') es la expresión que realizará el reemplazo. Esto significa que todas las ocurrencias de "GPT-3" en la columna "descripcion" se reemplazarán por "GPT-4".
*/


