

--Lectura de Archivos

CREATE OR REPLACE DIRECTORY MI_DIRECTORIO AS 'C:\Users\usuario\Documents\QUERYS_ADELIA\PLSQL';

DECLARE
    FILE_HANDLE UTL_FILE.FILE_TYPE;
    FILE_CONTENT VARCHAR2(32767);
BEGIN
    -- Abre el archivo para lectura (en modo texto)
    FILE_HANDLE := UTL_FILE.FOPEN('MI_DIRECTORIO', 'pruebas.txt', 'R');
    --En Oracle, los objetos de directorio (DIRECTORY) deben apuntar a rutas absolutas en el sistema de archivos. Esto significa 
    --que necesitas especificar la ruta completa desde la ra�z del sistema de archivos, por ejemplo, C:\ruta\a\tu\directorio en 
    --Windows.

    --Oracle no permite rutas relativas para los objetos de directorio, as� que siempre debes especificar la ruta completa al 
    --crear un objeto de directorio en Oracle.

    -- Lee el contenido del archivo l�nea por l�nea
    LOOP
        BEGIN
            UTL_FILE.GET_LINE(FILE_HANDLE, FILE_CONTENT);
            DBMS_OUTPUT.PUT_LINE(FILE_CONTENT);
        EXCEPTION
            WHEN UTL_FILE.READ_ERROR THEN
                EXIT; -- Sale del bucle si no hay m�s l�neas para leer
        END;
    END LOOP;

    -- Cierra el archivo despu�s de la lectura
    UTL_FILE.FCLOSE(FILE_HANDLE);
END;
/

--Escritura en Archivos:
DECLARE
    FILE_HANDLE UTL_FILE.FILE_TYPE;
BEGIN
    -- Abre el archivo para escritura (en modo texto, crea el archivo si no existe)
    FILE_HANDLE := UTL_FILE.FOPEN('MI_DIRECTORIO', 'pruebas2.txt', 'W');

    -- Escribe en el archivo
    UTL_FILE.PUT_LINE(FILE_HANDLE, 'Hola, Mundo!');
    UTL_FILE.PUT_LINE(FILE_HANDLE, 'Esta es otra l�nea.');

    -- Cierra el archivo despu�s de la escritura
    UTL_FILE.FCLOSE(FILE_HANDLE);
END;
/