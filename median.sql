SELECT  
    MEDICIONES.[clave_sitio],
    CASE
        WHEN DS.[nombre_sitio] IS NOT NULL THEN DS.[nombre_sitio]
        ELSE 'Nombre no disponible'
    END as [nombre_sitio],
    MEDICIONES.[anio],
    MEDICIONES.mediana_co3,
    MEDICIONES.mediana_hco3,
    MEDICIONES.mediana_oh,
    MEDICIONES.mediana_cot,
    MEDICIONES.mediana_cot_sol,
    MEDICIONES.mediana_n_nh3,
    MEDICIONES.mediana_n_no2
FROM (
    SELECT 
        [clave_sitio],
        [anio],
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [co3]) OVER (PARTITION BY [anio], [clave_sitio]) as mediana_co3,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [hco3]) OVER (PARTITION BY [anio], [clave_sitio]) as mediana_hco3,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [oh]) OVER (PARTITION BY [anio], [clave_sitio]) as mediana_oh,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [cot]) OVER (PARTITION BY [anio], [clave_sitio]) as mediana_cot,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [cot_sol]) OVER (PARTITION BY [anio], [clave_sitio]) as mediana_cot_sol,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [n_nh3]) OVER (PARTITION BY [anio], [clave_sitio]) as mediana_n_nh3,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY [n_no2]) OVER (PARTITION BY [anio], [clave_sitio]) as mediana_n_no2
    FROM [dbo].[muestras]
) as MEDICIONES
LEFT JOIN [dbo].[sitios] AS DS
    ON MEDICIONES.[clave_sitio] = DS.[clave_sitio]
