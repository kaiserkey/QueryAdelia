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

UPDATE MI_TABLA SET DESCRIPCION = REGEXP_REPLACE(DESCRIPCION, 'GPT-3', 'GPT-4');
/*
REGEXP_REPLACE: es una función que permite reemplazar el texto en una columna basado en un patrón de expresión regular.

SET descripcion = REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4'): Aquí estamos indicando que queremos actualizar la columna "descripcion". REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4') es la expresión que realizará el reemplazo. Esto significa que todas las ocurrencias de "GPT-3" en la columna "descripcion" se reemplazarán por "GPT-4".
*/

--Validación de dirección de correo electrónico:
SELECT P.EMAIL 
FROM ADELIA.PERSONA P
WHERE 1=1
      --AND P.EMAIL IS NOT NULL
      AND REGEXP_LIKE(P.EMAIL, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

/*
^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$

^ y $: Estos son anclajes que indican el inicio y el final de la cadena respectivamente. Esto asegura que la cadena completa coincida con el patrón, no solo una parte de ella.

[A-Za-z0-9._%+-]+: Esta parte verifica el nombre de usuario en la dirección de correo electrónico. Aquí tenemos:

[A-Za-z0-9]: Coincide con cualquier letra mayúscula o minúscula o dígito.
._%+-: Estos son caracteres especiales que a menudo se permiten en nombres de usuario de correo electrónico. El + indica que uno o más de estos caracteres son válidos.
+: Significa que uno o más caracteres dentro de los corchetes son válidos para el nombre de usuario.
@: Simplemente verifica que haya un símbolo '@' después del nombre de usuario. En una dirección de correo electrónico válida, debe haber exactamente un símbolo '@'.

[A-Za-z0-9.-]+: Esta parte verifica el dominio de nivel de servidor (por ejemplo, "gmail.com"). Aquí tenemos:

[A-Za-z0-9]: Coincide con cualquier letra mayúscula o minúscula o dígito.
.-: Estos son caracteres especiales que a menudo se permiten en nombres de dominio. El + indica que uno o más de estos caracteres son válidos.
\\.: Esto verifica que haya un punto ('.') después del nombre de dominio. El doble \ es necesario porque el punto es un carácter especial en expresiones regulares y debe escaparse con un backslash.

[A-Za-z]{2,4}: Esta parte verifica la extensión del dominio (por ejemplo, "com"). Aquí tenemos:

[A-Za-z]: Coincide con cualquier letra mayúscula o minúscula.
{2,4}: Esto indica que debe haber de 2 a 4 letras para la extensión del dominio. Esto cubre las extensiones de dominio comunes, como "com", "net", "org", "gov", etc.
*/

--Búsqueda de URLs:
SELECT * 
FROM MI_TABLA 
WHERE REGEXP_LIKE(TEXTO, 'http[s]?://[\\w\\.]+');

/*
http[s]?: Esta parte verifica si la cadena comienza con "http://" o "https://".

[s]?: El [s] se coloca entre paréntesis [], lo que significa que es opcional. La interrogación ? después del [s] indica que puede aparecer cero o una vez. Esto permite que la expresión regular coincida tanto con "http://" como con "https://".
://: Coincide literalmente con los dos puntos seguidos por dos barras inclinadas "//". Esto es parte de la sintaxis típica de las URL.

[\\w\\.]+: Esta parte verifica el contenido de la URL después de "http://" o "https://". Aquí tenemos:

[\\w\\.]: Esto busca caracteres alfanuméricos y el punto literal ".".
+: El símbolo de más indica que uno o más de estos caracteres son válidos en esta parte de la URL.

*/

--Extracción de números de teléfono
SELECT REGEXP_SUBSTR(P.TELEFONO_CELULAR, '\b\d{2}-\d{4}-\d{6}\b') AS TELEFONOS
FROM ADELIA.PERSONA P
WHERE TRIM(P.TELEFONO_CELULAR) IS NOT NULL


/*
\\b: Esto representa un límite de palabra. Los límites de palabra se utilizan para asegurarse de que la coincidencia comience y termine con un límite de palabra. Esto significa que se busca el número de teléfono como una palabra independiente y no parte de una palabra más larga.

\\d{3}: Esto busca tres dígitos consecutivos. El \d es una abreviatura de cualquier dígito numérico (0-9), y {3} indica que se deben encontrar exactamente tres dígitos.

-: Esto busca el guión literal "-". Como el guión es un carácter especial en expresiones regulares, no necesita ser escapado con \ en este caso.

\\d{3}: Esto busca otros tres dígitos consecutivos.

-: Nuevamente, busca otro guión literal.

\\d{4}: Esto busca cuatro dígitos consecutivos.

\\b: Otro límite de palabra para asegurarse de que la coincidencia termine como una palabra independiente.
*/


--Validación de direcciones IP:

SELECT * FROM MI_TABLA WHERE REGEXP_LIKE(IP, '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$');

/*
^: Esto marca el comienzo de la cadena, lo que significa que la coincidencia debe comenzar desde el principio de la cadena.

\\d{1,3}: Esto busca entre uno y tres dígitos consecutivos. El \d es una abreviatura de cualquier dígito numérico (0-9), y {1,3} indica que debe haber entre uno y tres dígitos.

\\.: Esto busca un punto literal ".". Como el punto es un carácter especial en expresiones regulares, necesita ser escapado con \.

\\d{1,3}: Nuevamente, busca entre uno y tres dígitos consecutivos.

\\.: Otro punto literal.

\\d{1,3}: Busca otros entre uno y tres dígitos consecutivos.

\\.: Otro punto literal.

\\d{1,3}: Finalmente, busca otros entre uno y tres dígitos consecutivos.

$: Esto marca el final de la cadena, lo que significa que la coincidencia debe llegar hasta el final de la cadena.
*/

--Extracción de fechas:
SELECT REGEXP_SUBSTR(TEXTO, '\\d{2}/\\d{2}/\\d{4}') AS FECHA FROM MI_TABLA;


SELECT REGEXP_SUBSTR(TO_CHAR(P.FECHA_NACIMIENTO, 'dd/mm/yyyy'), '\d{2}/\d{2}/\d{4}') FECHA_NACIMIENTO
FROM ADELIA.PERSONA P
WHERE P.FECHA_NACIMIENTO IS NOT NULL


/*
\\d: Representa cualquier dígito (0-9).

{2}: Indica que se esperan exactamente dos dígitos. Esto asegura que se capturen los números del día (por ejemplo, "01" para el primer día del mes).

/: Coincide con el carácter de barra diagonal literal "/". Dado que "/" es un carácter especial en expresiones regulares, se debe escapar con "\".

{2}: Nuevamente, se esperan exactamente dos dígitos. Esto asegura que se capturen los números del mes (por ejemplo, "12" para diciembre).

/: Otra barra diagonal literal.

{4}: Aquí, se esperan exactamente cuatro dígitos. Esto garantiza que se capturen los números del año en formato de cuatro dígitos (por ejemplo, "2023").
*/