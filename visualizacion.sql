-- Consulta 1

select * from muestras

SELECT 
    MU.clave_sitio,
    CASE
        WHEN DS.nombre_sitio IS NULL THEN 'Nombre no disponible'
        ELSE DS.nombre_sitio
    END as nombre_sitio,
    MU.clave_monitoreo,
    MU.fecha_realizacion,
    MU.anio,
    MU.co3,
    MU.hco3,
    MU.oh,
    MU.cot,
    MU.cot_sol,
    MU.n_nh3,
    MU.n_no2  
FROM dbo.muestras AS MU
LEFT JOIN dbo.sitios AS DS
    ON MU.clave_sitio = DS.clave_sitio
WHERE DS.nombre_sitio IS NULL;
