--1. Crear un campo calculado que muestre el valor de la monetización del video y otra con los impuestos que estos generan. 
WITH VideosFiltrados AS (
    SELECT 
        yt.video_id,
        yt.title,
        yt."channelTitle",
        yt.country,
        yt."categoryId",
        yt.view_count,
        yt.comments_disabled,
        COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB')) AS cmp
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
),
Monetizacion AS (
    SELECT 
        fv.video_id,
        fv.title,
        fv."channelTitle",
        fv.country,
        fv."categoryId",
        fv.view_count,
        fv.cmp,
        ROUND((fv.view_count / 1000.0) * fv.cmp,2) AS ValorMonetizacion,
        CASE 
            WHEN fv.country = 'COL' AND fv."categoryId" <> 26 THEN ROUND((fv.view_count / 1000.0) * fv.cmp * 0.10,2)
            ELSE 0
        END AS Impuestos
    FROM 
        VideosFiltrados fv
)
SELECT 
    video_id,
    country,
    "categoryId",
    view_count,
    cmp,
    ValorMonetizacion,
    Impuestos
FROM 
    Monetizacion;

--2. Monetización total por canales y los impuestos pagados por cada uno de ellos.
WITH VideosFiltrados AS (
    SELECT 
        yt.video_id,
        yt.title,
        yt."channelTitle",
        yt.country,
        yt."categoryId",
        yt.view_count,
        yt.comments_disabled,
        COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB')) AS cmp
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
),
Monetizacion AS (
    SELECT 
        fv."channelTitle",
        fv.video_id,
        fv.country,
        fv."categoryId",
        fv.view_count,
        fv.cmp,
        ROUND((fv.view_count / 1000.0) * fv.cmp, 2) AS ValorMonetizacion,
        CASE 
            WHEN fv.country = 'COL' AND fv."categoryId" <> 26 THEN ROUND((fv.view_count / 1000.0) * fv.cmp * 0.10, 2)
            ELSE 0
        END AS Impuestos
    FROM 
        VideosFiltrados fv
)
SELECT 
    "channelTitle",
    SUM(ValorMonetizacion) AS MonetizacionTotal,
    SUM(Impuestos) AS ImpuestosTotal
FROM 
    Monetizacion
GROUP BY 
    "channelTitle"
ORDER BY 
    MonetizacionTotal DESC;

--3. Considerando que tomaremos como meta de monetización para los canales de México el promedio de la monetización de ese país, cual es la brecha que los canales de México tienen para alcanzar la meta. 
WITH VideosFiltrados AS (
    SELECT 
        yt.video_id,
        yt.title,
        yt."channelTitle",
        yt.country,
        yt."categoryId",
        yt.view_count,
        yt.comments_disabled,
        COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB')) AS cmp
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
),
Monetizacion AS (
    SELECT 
        fv.video_id,
        fv.title,
        fv."channelTitle",
        fv.country,
        fv."categoryId",
        fv.view_count,
        fv.cmp,
        ROUND((fv.view_count / 1000.0) * fv.cmp, 2) AS ValorMonetizacion,
        CASE 
            WHEN fv.country = 'COL' AND fv."categoryId" <> 26 THEN ROUND((fv.view_count / 1000.0) * fv.cmp * 0.10, 2)
            ELSE 0
        END AS Impuestos
    FROM 
        VideosFiltrados fv
),
MetaMonetizacionMexico AS (
    SELECT 
        ROUND(AVG(ValorMonetizacion),2) AS MetaMonetizacion
    FROM 
        Monetizacion
    WHERE 
        country = 'MEX'
),
MonetizacionPorCanal AS (
    SELECT 
        "channelTitle",
        SUM(ValorMonetizacion) AS MonetizacionTotal
    FROM 
        Monetizacion
    WHERE 
        country = 'MEX'
    GROUP BY 
        "channelTitle"
)
SELECT 
    mpc."channelTitle",
    mpc.MonetizacionTotal,
    mmm.MetaMonetizacion,
    ROUND(mmm.MetaMonetizacion - mpc.MonetizacionTotal,2) AS Brecha
FROM 
    MonetizacionPorCanal mpc,
    MetaMonetizacionMexico mmm
ORDER BY 
    Brecha DESC;

--4. Cuantas visitas requieren los videos de los canales de USA para alcanzar una monetización de un millón de dólares. 
WITH VideosFiltrados AS (
    SELECT 
        yt.video_id,
        yt.title,
        yt."channelTitle",
        yt.country,
        yt."categoryId",
        yt.view_count,
        yt.comments_disabled,
        COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB')) AS cmp
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
),
MonetizacionUSA AS (
    SELECT 
        fv.video_id,
        fv.title,
        fv."channelTitle",
        fv.country,
        fv."categoryId",
        fv.view_count,
        fv.cmp,
        ROUND((fv.view_count / 1000.0) * fv.cmp, 2) AS ValorMonetizacion
    FROM 
        VideosFiltrados fv
    WHERE 
        fv.country = 'USA'
),
CMP_USA AS (
    SELECT 
        AVG(cmp) AS avg_cmp
    FROM 
        MonetizacionUSA
)
SELECT 
    ROUND(1000000 / avg_cmp * 1000) AS visitas_necesarias
FROM 
    CMP_USA;

--5. Cuales son los canales de Colombia que han sido más exonerados de impuestos.
WITH VideosFiltrados AS (
    SELECT 
        yt.video_id,
        yt.title,
        yt."channelTitle",
        yt.country,
        yt."categoryId",
        yt.view_count,
        yt.comments_disabled,
        COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB')) AS cmp
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
),
MonetizacionColombia AS (
    SELECT 
        fv.video_id,
        fv.title,
        fv."channelTitle",
        fv.country,
        fv."categoryId",
        fv.view_count,
        fv.cmp,
        ROUND((fv.view_count / 1000.0) * fv.cmp, 2) AS ValorMonetizacion,
        CASE 
            WHEN fv.country = 'COL' AND fv."categoryId" = 26 THEN ROUND((fv.view_count / 1000.0) * fv.cmp * 0.10, 2)
            ELSE 0
        END AS Exoneracion
    FROM 
        VideosFiltrados fv
    WHERE 
        fv.country = 'COL'
)
SELECT 
    "channelTitle",
    SUM(Exoneracion) AS TotalExoneracion
FROM 
    MonetizacionColombia
GROUP BY 
    "channelTitle"
ORDER BY 
    TotalExoneracion DESC;

--6. En que país de los indicados se tiene una mayor monetización
WITH VideosFiltrados AS (
    SELECT 
        yt.video_id,
        yt.title,
        yt."channelTitle",
        yt.country,
        yt."categoryId",
        yt.view_count,
        yt.comments_disabled,
        COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB')) AS cmp
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
),
Monetizacion AS (
    SELECT 
        fv.video_id,
        fv.title,
        fv."channelTitle",
        fv.country,
        fv."categoryId",
        fv.view_count,
        fv.cmp,
        ROUND((fv.view_count / 1000.0) * fv.cmp, 2) AS ValorMonetizacion
    FROM 
        VideosFiltrados fv
)
SELECT 
    country,
    SUM(ValorMonetizacion) AS MonetizacionTotal
FROM 
    Monetizacion
GROUP BY 
    country
ORDER BY 
    MonetizacionTotal DESC
LIMIT 1;

--7. Según la opinión del grupo, que es mas conveniente para Colombia, abrir un canal de salud y bienestar o un canal de jardinería (clasificación 24)
WITH MonetizacionPorClasificacion AS (
    SELECT 
        yt."categoryId",
        ROUND(AVG((yt.view_count / 1000.0) * COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB'))), 2) AS monetizacion_promedio
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" IN (24, 26)
        AND yt.country = 'COL'
        AND yt."categoryId" NOT IN (29, 19, 27)
    GROUP BY 
        yt."categoryId"
)
SELECT 
    "categoryId",
    monetizacion_promedio,
    CASE 
        WHEN "categoryId" = 24 THEN monetizacion_promedio - (monetizacion_promedio * 0.10)
        ELSE monetizacion_promedio
    END AS ganancias_finales_promedio
FROM 
    MonetizacionPorClasificacion;

--8. En México que es más conveniente, un canal de Jardinería (clasificación 24) o un canal de videojuegos (Clasificación 23)
WITH MonetizacionPorClasificacion AS (
    SELECT 
        yt."categoryId",
        ROUND(AVG((yt.view_count / 1000.0) * COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB'))), 2) AS monetizacion_promedio
    FROM 
        youtube_trending_data yt
    JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" IN (23, 24)
        AND yt.country = 'MEX'
        AND yt."categoryId" NOT IN (29, 19, 27)
    GROUP BY 
        yt."categoryId"
)
SELECT 
    "categoryId",
    monetizacion_promedio
FROM 
    MonetizacionPorClasificacion;

--9. Si el CMP de USA se redujera en un 25%, los ingresos en México serían mayores a los de USA?
WITH MonetizacionPromedioUSA AS (
    SELECT 
        ROUND(AVG((view_count / 1000.0) * (COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB')) * 0.75)), 2) AS monetizacion_promedio_usa
    FROM 
        youtube_trending_data yt
    LEFT JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
        AND yt.country = 'USA'
),
MonetizacionPromedioMexico AS (
    SELECT 
        ROUND(AVG((view_count / 1000.0) * COALESCE(c."CMP", (SELECT "CMP" FROM cmp WHERE "PAIS" = 'GB'))), 2) AS monetizacion_promedio_mexico
    FROM 
        youtube_trending_data yt
    LEFT JOIN 
        paises p ON yt.country = p." iso3"
    LEFT JOIN 
        cmp c ON p." iso2" = c."PAIS"
    WHERE 
        yt.comments_disabled = 'FALSE' 
        AND yt."categoryId" NOT IN (29, 19, 27)
        AND yt.country = 'MEX'
)
SELECT 
    monetizacion_promedio_usa,
    monetizacion_promedio_mexico,
    CASE 
        WHEN monetizacion_promedio_mexico > monetizacion_promedio_usa THEN 'México'
        ELSE 'USA'
    END AS pais_con_mayores_ingresos
FROM 
    MonetizacionPromedioUSA, MonetizacionPromedioMexico;