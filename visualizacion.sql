SELECT 
    MU.anio,
    MU.clave_sitio,
    CASE
        WHEN DS.nombre_sitio IS NULL THEN 'Nombre no disponible'
        ELSE DS.nombre_sitio
    END AS nombre_sitio,
    AVG(MU.co3) AS avg_co3,
    AVG(MU.hco3) AS avg_hco3,
    AVG(MU.oh) AS avg_oh,
    AVG(MU.cot) AS avg_cot,
    AVG(MU.cot_sol) AS avg_cot_sol,
    AVG(MU.n_nh3) AS avg_n_nh3,
    AVG(MU.n_no2) AS avg_n_no2
FROM dbo.muestras AS MU
LEFT JOIN dbo.sitios AS DS
    ON MU.clave_sitio = DS.clave_sitio
WHERE MU.anio >= 2019 
GROUP BY MU.anio, MU.clave_sitio, DS.nombre_sitio
HAVING AVG(MU.n_no2) > 1;
