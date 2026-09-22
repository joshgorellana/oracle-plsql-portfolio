-- ============================================================================
-- Nombre: fn_limpiar_saltos_linea.sql
-- Descripción: Función PL/SQL para remover saltos de línea (CHR(10), CHR(13))
--              y colapsar espacios múltiples en una sola línea.
-- Fecha: 2026-09-21
-- Versión: 1.0
-- Compatibilidad: Oracle 11g+
-- ============================================================================

-- Eliminar función si existe (opcional, para re-creación limpia)
-- DROP FUNCTION fn_limpiar_saltos_linea;

CREATE OR REPLACE FUNCTION fn_limpiar_saltos_linea (
    p_cadena IN VARCHAR2
) RETURN VARCHAR2
IS
    v_resultado VARCHAR2(32767);
BEGIN
    -- Validar entrada nula
    IF p_cadena IS NULL THEN
        RETURN NULL;
    END IF;
    
    -- Paso 1: Reemplazar LF (10) y CR (13) por espacio
    v_resultado := REPLACE(REPLACE(p_cadena, CHR(10), ' '), CHR(13), ' ');
    
    -- Paso 2: Colapsar espacios múltiples a uno solo
    v_resultado := REGEXP_REPLACE(v_resultado, ' {2,}', ' ');
    
    -- Paso 3: Eliminar espacios al inicio y final
    RETURN TRIM(v_resultado);
END fn_limpiar_saltos_linea;
/

-- ============================================================================
-- Ejemplo de uso:
-- ============================================================================
-- SELECT fn_limpiar_saltos_linea('Hola' || CHR(10) || 'Mundo   multiple') 
--        AS texto_limpio 
-- FROM DUAL;
-- Resultado: 'Hola Mundo multiple'
-- ============================================================================

-- Script de prueba (descomentar para ejecutar)
-- SET SERVEROUTPUT ON;
-- DECLARE
--     v_test VARCHAR2(100) := 'Línea 1' || CHR(10) || 'Línea 2' || CHR(13) || '  Espacios  múltiples  ';
-- BEGIN
--     DBMS_OUTPUT.PUT_LINE('Original: [' || v_test || ']');
--     DBMS_OUTPUT.PUT_LINE('Limpio:   [' || fn_limpiar_saltos_linea(v_test) || ']');
-- END;
-- /