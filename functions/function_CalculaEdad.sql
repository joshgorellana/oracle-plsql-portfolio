CREATE OR REPLACE FUNCTION fn_calcula_edad (
    p_fecha_nacimiento IN DATE
) RETURN NUMBER
IS
BEGIN
    IF p_fecha_nacimiento IS NULL THEN
        RETURN NULL;
    END IF;

    RETURN FLOOR(
        MONTHS_BETWEEN(SYSDATE, p_fecha_nacimiento) / 12
    );
END fn_calcula_edad;
/