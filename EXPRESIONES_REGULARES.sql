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

UPDATE MI_TABLA SET DESCRIPCION = REGEXP_REPLACE(DESCRIPCION, 'GPT-3', 'GPT-4');
/*
REGEXP_REPLACE: es una funci�n que permite reemplazar el texto en una columna basado en un patr�n de expresi�n regular.

SET descripcion = REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4'): Aqu� estamos indicando que queremos actualizar la columna "descripcion". REGEXP_REPLACE(descripcion, 'GPT-3', 'GPT-4') es la expresi�n que realizar� el reemplazo. Esto significa que todas las ocurrencias de "GPT-3" en la columna "descripcion" se reemplazar�n por "GPT-4".
*/

--Validaci�n de direcci�n de correo electr�nico:
SELECT P.EMAIL 
FROM ADELIA.PERSONA P
WHERE 1=1
      --AND P.EMAIL IS NOT NULL
      AND REGEXP_LIKE(P.EMAIL, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');

/*
^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$

^ y $: Estos son anclajes que indican el inicio y el final de la cadena respectivamente. Esto asegura que la cadena completa coincida con el patr�n, no solo una parte de ella.

[A-Za-z0-9._%+-]+: Esta parte verifica el nombre de usuario en la direcci�n de correo electr�nico. Aqu� tenemos:

[A-Za-z0-9]: Coincide con cualquier letra may�scula o min�scula o d�gito.
._%+-: Estos son caracteres especiales que a menudo se permiten en nombres de usuario de correo electr�nico. El + indica que uno o m�s de estos caracteres son v�lidos.
+: Significa que uno o m�s caracteres dentro de los corchetes son v�lidos para el nombre de usuario.
@: Simplemente verifica que haya un s�mbolo '@' despu�s del nombre de usuario. En una direcci�n de correo electr�nico v�lida, debe haber exactamente un s�mbolo '@'.

[A-Za-z0-9.-]+: Esta parte verifica el dominio de nivel de servidor (por ejemplo, "gmail.com"). Aqu� tenemos:

[A-Za-z0-9]: Coincide con cualquier letra may�scula o min�scula o d�gito.
.-: Estos son caracteres especiales que a menudo se permiten en nombres de dominio. El + indica que uno o m�s de estos caracteres son v�lidos.
\\.: Esto verifica que haya un punto ('.') despu�s del nombre de dominio. El doble \ es necesario porque el punto es un car�cter especial en expresiones regulares y debe escaparse con un backslash.

[A-Za-z]{2,4}: Esta parte verifica la extensi�n del dominio (por ejemplo, "com"). Aqu� tenemos:

[A-Za-z]: Coincide con cualquier letra may�scula o min�scula.
{2,4}: Esto indica que debe haber de 2 a 4 letras para la extensi�n del dominio. Esto cubre las extensiones de dominio comunes, como "com", "net", "org", "gov", etc.
*/

--B�squeda de URLs:
SELECT * 
FROM MI_TABLA 
WHERE REGEXP_LIKE(TEXTO, 'http[s]?://[\\w\\.]+');

/*
http[s]?: Esta parte verifica si la cadena comienza con "http://" o "https://".

[s]?: El [s] se coloca entre par�ntesis [], lo que significa que es opcional. La interrogaci�n ? despu�s del [s] indica que puede aparecer cero o una vez. Esto permite que la expresi�n regular coincida tanto con "http://" como con "https://".
://: Coincide literalmente con los dos puntos seguidos por dos barras inclinadas "//". Esto es parte de la sintaxis t�pica de las URL.

[\\w\\.]+: Esta parte verifica el contenido de la URL despu�s de "http://" o "https://". Aqu� tenemos:

[\\w\\.]: Esto busca caracteres alfanum�ricos y el punto literal ".".
+: El s�mbolo de m�s indica que uno o m�s de estos caracteres son v�lidos en esta parte de la URL.

*/

--Extracci�n de n�meros de tel�fono
SELECT REGEXP_SUBSTR(P.TELEFONO_CELULAR, '\b\d{2}-\d{4}-\d{6}\b') AS TELEFONOS
FROM ADELIA.PERSONA P
WHERE TRIM(P.TELEFONO_CELULAR) IS NOT NULL


/*
\\b: Esto representa un l�mite de palabra. Los l�mites de palabra se utilizan para asegurarse de que la coincidencia comience y termine con un l�mite de palabra. Esto significa que se busca el n�mero de tel�fono como una palabra independiente y no parte de una palabra m�s larga.

\\d{3}: Esto busca tres d�gitos consecutivos. El \d es una abreviatura de cualquier d�gito num�rico (0-9), y {3} indica que se deben encontrar exactamente tres d�gitos.

-: Esto busca el gui�n literal "-". Como el gui�n es un car�cter especial en expresiones regulares, no necesita ser escapado con \ en este caso.

\\d{3}: Esto busca otros tres d�gitos consecutivos.

-: Nuevamente, busca otro gui�n literal.

\\d{4}: Esto busca cuatro d�gitos consecutivos.

\\b: Otro l�mite de palabra para asegurarse de que la coincidencia termine como una palabra independiente.
*/


--Validaci�n de direcciones IP:

SELECT * FROM MI_TABLA WHERE REGEXP_LIKE(IP, '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$');

/*
^: Esto marca el comienzo de la cadena, lo que significa que la coincidencia debe comenzar desde el principio de la cadena.

\\d{1,3}: Esto busca entre uno y tres d�gitos consecutivos. El \d es una abreviatura de cualquier d�gito num�rico (0-9), y {1,3} indica que debe haber entre uno y tres d�gitos.

\\.: Esto busca un punto literal ".". Como el punto es un car�cter especial en expresiones regulares, necesita ser escapado con \.

\\d{1,3}: Nuevamente, busca entre uno y tres d�gitos consecutivos.

\\.: Otro punto literal.

\\d{1,3}: Busca otros entre uno y tres d�gitos consecutivos.

\\.: Otro punto literal.

\\d{1,3}: Finalmente, busca otros entre uno y tres d�gitos consecutivos.

$: Esto marca el final de la cadena, lo que significa que la coincidencia debe llegar hasta el final de la cadena.
*/

--Extracci�n de fechas:
SELECT REGEXP_SUBSTR(TEXTO, '\\d{2}/\\d{2}/\\d{4}') AS FECHA FROM MI_TABLA;


SELECT REGEXP_SUBSTR(TO_CHAR(P.FECHA_NACIMIENTO, 'dd/mm/yyyy'), '\d{2}/\d{2}/\d{4}') FECHA_NACIMIENTO
FROM ADELIA.PERSONA P
WHERE P.FECHA_NACIMIENTO IS NOT NULL


/*
\\d: Representa cualquier d�gito (0-9).

{2}: Indica que se esperan exactamente dos d�gitos. Esto asegura que se capturen los n�meros del d�a (por ejemplo, "01" para el primer d�a del mes).

/: Coincide con el car�cter de barra diagonal literal "/". Dado que "/" es un car�cter especial en expresiones regulares, se debe escapar con "\".

{2}: Nuevamente, se esperan exactamente dos d�gitos. Esto asegura que se capturen los n�meros del mes (por ejemplo, "12" para diciembre).

/: Otra barra diagonal literal.

{4}: Aqu�, se esperan exactamente cuatro d�gitos. Esto garantiza que se capturen los n�meros del a�o en formato de cuatro d�gitos (por ejemplo, "2023").
*/