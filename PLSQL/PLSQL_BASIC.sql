
CREATE TABLE PERSONAS (
    PERSONID NUMBER,
    LASTNAME VARCHAR2(255),
    FIRSTNAME VARCHAR2(255),
    Address VARCHAR2(255),
    City VARCHAR2(255)
);


INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (1, 'Doe', 'John', '123 Main St', 'Anytown');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (2, 'Smith', 'Alice', '456 Elm St', 'Otherville');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (3, 'Johnson', 'Michael', '789 Oak St', 'Anycity');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (4, 'Williams', 'Emily', '101 Pine St', 'Othercity');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (5, 'Brown', 'David', '202 Maple St', 'Newtown');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (6, 'Jones', 'Emma', '303 Cedar St', 'Smalltown');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (7, 'Davis', 'Daniel', '404 Birch St', 'Villagetown');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (8, 'Martinez', 'Olivia', '505 Spruce St', 'Townton');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (9, 'Garcia', 'Liam', '606 Fir St', 'Cityville');
INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City) VALUES (10, 'Rodriguez', 'Ava', '707 Redwood St', 'Metropolis');



SELECT *
FROM PERSONAS P;


--SYNTAXIS BASICA DE PL/SQL
--DECLARE
    -- Declaraciones de variables y constantes
--BEGIN
    -- Código PL/SQL
--EXCEPTION
    -- Manejo de excepciones (opcional)
--END;

--FORMAS DE IMPRIMIR VALORES
DECLARE
    V_VARIABLE VARCHAR2(50);
    TYPE LISTA IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    V_LISTA LISTA;
BEGIN
    V_VARIABLE := 'Valor Directo';
    DBMS_OUTPUT.PUT_LINE(V_VARIABLE);
    V_LISTA(1) := 'Valor 1';
    V_LISTA(2) := 'Valor 2';
    DBMS_OUTPUT.PUT_LINE(V_LISTA(1));
END;
/

--TIPOS DE DATOS
DECLARE
    --Para números enteros o decimales.
    V_ENTERO NUMBER := 10;
    V_DECIMAL NUMBER := 3.14;
    --Para cadenas de caracteres de longitud variable.
    V_NOMBRE VARCHAR2(50) := 'Juan';
    --Para cadenas de caracteres de longitud fija.
    V_CODIGO CHAR(10) := 'ABC123';
    --Para fechas y horas.
    V_FECHA DATE := TO_DATE(SYSDATE, 'DD-MM-YYYY');
    --Para valores booleanos (TRUE/FALSE).
    V_CONDICION BOOLEAN := TRUE;
    --Para almacenar grandes bloques de texto.
    V_GRAN_TEXTO CLOB := 'Este es un texto muy largo...';
    --Para almacenar datos binarios grandes, como imágenes.
    V_IMAGEN BLOB;
    --Para definir una variable que tenga la misma estructura que una fila en una tabla existente.
    V_REGISTRO PERSONAS%ROWTYPE;
    --Para definir tablas anidadas o arrays.
    TYPE LISTA_NOMBRES IS TABLE OF VARCHAR2(50);
    V_NOMBRES LISTA_NOMBRES := LISTA_NOMBRES('Juan', 'María', 'Carlos');
BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('NUMERO ENTERO: ' || V_ENTERO);
    DBMS_OUTPUT.PUT_LINE('NUMERO DECIMAL: ' || V_DECIMAL);
    DBMS_OUTPUT.PUT_LINE('VARCHAR2: ' || V_NOMBRE);
    DBMS_OUTPUT.PUT_LINE('CHAR: ' || V_CODIGO);
    DBMS_OUTPUT.PUT_LINE('FECHAS: ' || V_FECHA);
    -- Mostrar el valor de v_condicion
    IF V_CONDICION THEN
        DBMS_OUTPUT.PUT_LINE('v_condicion es TRUE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('v_condicion es FALSE');
    END IF;
    DBMS_OUTPUT.PUT_LINE('CLOB: ' || V_GRAN_TEXTO);
    --DBMS_OUTPUT.PUT_LINE('BLOB: ' || V_IMAGEN);
    FOR i IN 1..V_NOMBRES.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre ' || i || ': ' || V_NOMBRES(i));
    END LOOP;
    -- Asignar valores al registro (por ejemplo, mediante una consulta)
    SELECT * INTO V_REGISTRO FROM PERSONAS WHERE ROWNUM = 1;

    -- Mostrar el contenido del registro
    DBMS_OUTPUT.PUT_LINE('FULL NAME: ' || V_REGISTRO.LASTNAME || ' ' || V_REGISTRO.FIRSTNAME);
END;
/


--BUCLE FOR
DECLARE
    V_VARIABLE NUMBER;
BEGIN
    FOR i IN 1..10 LOOP
        -- Código a ejecutar en cada iteración
        V_VARIABLE := i;
        DBMS_OUTPUT.PUT_LINE(V_VARIABLE);
    END LOOP;
END;
/

--BUCLE WHILE
DECLARE
    V_VARIABLE NUMBER := 1;
BEGIN
    WHILE V_VARIABLE <= 10 LOOP
        -- Código a ejecutar en cada iteración
        DBMS_OUTPUT.PUT_LINE(V_VARIABLE);
        V_VARIABLE := V_VARIABLE + 1;
    END LOOP;
END;
/

--LOOP CON EXIT WHEN
DECLARE
    V_VARIABLE NUMBER := 1;
BEGIN
    LOOP
        -- Código a ejecutar en cada iteración
        DBMS_OUTPUT.PUT_LINE(V_VARIABLE);
        V_VARIABLE := V_VARIABLE + 1;
        EXIT WHEN V_VARIABLE > 10;
    END LOOP;
END;
/

--IF-THEN-ELSE
DECLARE
    V_VARIABLE NUMBER := 10;
BEGIN
    IF V_VARIABLE > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Variable es positiva');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Variable es cero o negativa');
    END IF;
END;
/

--ELSIF
DECLARE
    V_VARIABLE NUMBER := 0;
BEGIN
    IF V_VARIABLE > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Variable es positiva');
    ELSIF V_VARIABLE < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Variable es negativa');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Variable es cero');
    END IF;
END;
/

--CASE
DECLARE
    V_VARIABLE NUMBER := 2;
BEGIN
    CASE V_VARIABLE
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('Variable es 1');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('Variable es 2');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Variable no es ni 1 ni 2');
    END CASE;
END;
/

--FUNCIONES MAS UTILIZADAS
DECLARE
    V_NUMERO VARCHAR2(10) := '123.45';
    V_FECHA_CADENA VARCHAR2(20) := '2023-08-01';
    V_FECHA DATE;
    V_CONCATENADA VARCHAR2(50);
    V_POSICION NUMBER;
    V_HOY DATE := SYSDATE;
BEGIN
    -- TO_DATE: Convierte una cadena a una fecha.
    V_FECHA := TO_DATE(V_FECHA_CADENA, 'YYYY-MM-DD');
    
    -- CONCAT: Concatena dos cadenas.
    V_CONCATENADA := CONCAT('Número: ', TO_NUMBER(V_NUMERO));
    --INSTR: Devuelve la posición de la primera ocurrencia de una subcadena en una cadena.
    V_POSICION := INSTR(V_CONCATENADA, 'Número');
    
    -- Salida de datos
    DBMS_OUTPUT.PUT_LINE('Fecha convertida: ' || TO_CHAR(V_FECHA, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('Cadena concatenada: ' || V_CONCATENADA);
    DBMS_OUTPUT.PUT_LINE('Fecha actual: ' || TO_CHAR(V_HOY, 'DD-MON-YYYY HH24:MI:SS'));
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--Este bloque PL/SQL consulta la tabla Personas y muestra los registros utilizando DBMS_OUTPUT.PUT_LINE.

DECLARE
    --Declaraciones de variables y constantes
    P_ID NUMBER;
    P_LAST_NAME VARCHAR2(255);
    P_FIRST_NAME VARCHAR2(255);
    P_ADDRESS VARCHAR2(255);
    P_CITY VARCHAR2(255);
BEGIN
    --Bucles en pl/sql
    FOR REC IN (SELECT * FROM PERSONAS) LOOP
        P_ID := REC.PERSONID;
        P_LAST_NAME := REC.LASTNAME;
        P_FIRST_NAME := REC.FIRSTNAME;
        P_ADDRESS := REC.ADDRESS;
        P_CITY := REC.CITY;
        
        --mostrar la salida con dbms_output.put_line
        DBMS_OUTPUT.ENABLE;
        DBMS_OUTPUT.PUT_LINE('PersonID: ' || P_ID || ', LastName: ' || P_LAST_NAME || ', FirstName: ' || P_FIRST_NAME || ', Address: ' || P_ADDRESS || ', City: ' || P_CITY);
    END LOOP;
-- Manejo de excepciones (opcional)
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/


--Este bloque PL/SQL inserta un nuevo registro en la tabla Persons con los valores proporcionados.

DECLARE
    P_ID NUMBER := 11;
    P_LAST_NAME VARCHAR2(255) := 'Smith';
    P_FIRST_NAME VARCHAR2(255) := 'Emma';
    P_ADDRESS VARCHAR2(255) := '808 Pine St';
    P_CITY VARCHAR2(255) := 'Newville';
BEGIN
    INSERT INTO PERSONAS (PERSONID, LASTNAME, FIRSTNAME, Address, City)
    VALUES (P_ID, P_LAST_NAME, P_FIRST_NAME, P_ADDRESS, P_CITY);
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('Nuevo registro insertado.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--Procedimientos y Funciones Almacenados: PL/SQL se usa para escribir procedimientos y funciones almacenados en la base de datos. Estos son bloques de código reutilizables que pueden ser llamados desde aplicaciones o incluso desde otras partes de la base de datos. Los procedimientos y funciones almacenados son útiles para realizar operaciones complejas y lógicas en la base de datos.

CREATE OR REPLACE PROCEDURE GET_PERSONA_DETAILS (PERSONA_ID NUMBER) AS
    -- declarar variables para almacenar los detalles de la persona
    P_ID PERSONAS.PERSONID%TYPE;
    P_LAST_NAME PERSONAS.LASTNAME%TYPE;
    P_FIRST_NAME PERSONAS.FIRSTNAME%TYPE;
    P_ADDRESS PERSONAS.ADDRESS%TYPE;
    P_CITY PERSONAS.CITY%TYPE;
BEGIN
    -- lógica para recuperar los detalles de la persona basados en el ID
    FOR REC IN (SELECT * FROM PERSONAS P WHERE P.PERSONID = PERSONA_ID) LOOP
        P_ID := REC.PERSONID;
        P_LAST_NAME := REC.LASTNAME;
        P_FIRST_NAME := REC.FIRSTNAME;
        P_ADDRESS := REC.ADDRESS;
        P_CITY := REC.CITY;
        
        -- mostrar la salida con dbms_output.put_line
        DBMS_OUTPUT.ENABLE;
        DBMS_OUTPUT.PUT_LINE('PersonID: ' || P_ID || ', LastName: ' || P_LAST_NAME || ', FirstName: ' || P_FIRST_NAME || ', Address: ' || P_ADDRESS || ', City: ' || P_CITY);
    END LOOP;
END;
/

DECLARE
    -- declarar una variable para el ID de la persona que deseas buscar
    PERSONA_ID NUMBER := 1; -- reemplaza 123 con el ID de la persona que estás buscando
    
BEGIN
    -- llamar al procedimiento
    GET_PERSONA_DETAILS(PERSONA_ID);
END;
/

--Para obtener los resultados de un procedimiento almacenado en una consulta SQL, puedes usar una función en lugar de un procedimiento. Las funciones en PL/SQL pueden retornar un valor, y ese valor puede ser utilizado en una consulta SQL.

CREATE OR REPLACE FUNCTION GET_PERSONA_DETAILS_func (PERSONA_ID NUMBER) RETURN VARCHAR2 AS
    -- declarar variables para los detalles de la persona
    P_DETAILS VARCHAR2(1000);
BEGIN
    -- lógica para recuperar los detalles del empleado basados en el ID
    FOR REC IN (SELECT * FROM PERSONAS P WHERE P.PERSONID = PERSONA_ID) LOOP
        P_DETAILS := 'PersonID: ' || REC.PERSONID || ', LastName: ' || REC.LASTNAME || ', FirstName: ' || REC.FIRSTNAME || ', Address: ' || REC.ADDRESS || ', City: ' || REC.CITY;
    END LOOP;
    -- retornar los detalles como resultado de la función
    RETURN P_DETAILS;
END;
/

SELECT GET_PERSONA_DETAILS_func(1) FROM DUAL;

--En PL/SQL puedes usar tipos de datos definidos por el usuario (User-Defined Types, UDTs) para crear estructuras de datos complejas que pueden contener múltiples valores. Una de las formas de devolver múltiples valores desde una función en PL/SQL es usando un tipo de tabla definido por el usuario.

CREATE OR REPLACE TYPE PERSONDETAIL AS OBJECT (
    PERSONID NUMBER,
    LASTNAME VARCHAR2(255),
    FIRSTNAME VARCHAR2(255),
    Address VARCHAR2(255),
    City VARCHAR2(255)
);
/
--definir un tipo de tabla para almacenar detalles de personas
CREATE OR REPLACE TYPE PERSONDETAILLIST AS TABLE OF PERSONDETAIL;
/

--crear una función que retorna esta lista de detalles de persona:
CREATE OR REPLACE FUNCTION GET_PERSONA_DETAILS_LIST (PERSONA_ID NUMBER) RETURN PERSONDETAILLIST PIPELINED AS
BEGIN
    -- lógica para recuperar los detalles del empleado basados en el ID
    FOR REC IN (SELECT * FROM PERSONAS P WHERE P.PERSONID >= PERSONA_ID) LOOP
        PIPE ROW(PERSONDETAIL(REC.PERSONID, REC.LASTNAME, REC.FIRSTNAME, REC.ADDRESS, REC.CITY));
    END LOOP;
    -- retornar los detalles como una lista usando PIPELINED
END;
/

--usar la función en una consulta SQL para obtener la lista de detalles de persona
SELECT * FROM TABLE(GET_PERSONA_DETAILS(1));


--trigger para la tabla PERSONAS que verifica si la columna PERSONID está en el rango específico
CREATE OR REPLACE TRIGGER CHECK_PERSON_ID
BEFORE INSERT OR UPDATE ON PERSONAS
FOR EACH ROW
BEGIN
    IF :NEW.PERSONID < 1000 OR :NEW.PERSONID > 9999 THEN
        RAISE_APPLICATION_ERROR(-20001, 'PERSONID should be a 4-digit number');
    END IF;
END;
/

--un ejemplo de un bloque anónimo PL/SQL que maneja excepciones para la tabla PERSONAS
DECLARE
    V_LASTNAME VARCHAR2(255);
BEGIN
    -- Intentar seleccionar un apellido de la tabla PERSONAS
    SELECT LASTNAME INTO V_LASTNAME FROM PERSONAS WHERE PERSONID = 1;

    -- Mostrar el apellido seleccionado
    DBMS_OUTPUT.PUT_LINE('Apellido: ' || V_LASTNAME);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Manejar la excepción de "ningún dato encontrado"
        DBMS_OUTPUT.PUT_LINE('No se encontraron datos para el ID especificado.');
    WHEN OTHERS THEN
        -- Manejar cualquier otra excepción
        DBMS_OUTPUT.PUT_LINE('Ocurrió un error: ' || SQLERRM);
END;
/






