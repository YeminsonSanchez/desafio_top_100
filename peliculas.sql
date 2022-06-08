-- 1. Crear base de datos llamada películas.
CREATE DATABASE peliculas;

\c peliculas 

-- 2. Cargar ambos archivos a su tabla correspondiente.
CREATE TABLE pelicula(
    id INT PRIMARY KEY,
    pelicula VARCHAR(100),
    anio_estreno VARCHAR(4),
    director VARCHAR(100)
);

\copy pelicula (id, pelicula, anio_estreno, director) FROM './peliculas.csv' csv header;

CREATE TABLE reparto (
    id SERIAL PRIMARY KEY,
    id_pelicula INT,
    reparto VARCHAR(255),
    FOREIGN KEY(id_pelicula) REFERENCES pelicula(id)
);

\copy reparto(id_pelicula, reparto) FROM './reparto.csv' csv;

-- 3. Obtener el ID de la película “Titanic”.
SELECT
    id
FROM
    pelicula
WHERE
    pelicula = 'Titanic';

-- 4. Listar a todos los actores que aparecen en la película "Titanic".
SELECT
    reparto
FROM
    reparto
WHERE
    id_pelicula = (
        SELECT
            id
        FROM
            pelicula
        WHERE
            pelicula = 'Titanic'
    );

-- 5. Consultar en cuántas películas del top 100 participa Harrison Ford.
SELECT
    COUNT(pelicula)
FROM
    pelicula
WHERE
    id IN (
        SELECT
            id_pelicula
        FROM
            reparto
        WHERE
            reparto = 'Harrison Ford'
    );

-- 6. Indicar las películas estrenadas entre los años 1990 y 1999 ordenadas por título de
-- manera ascendente.
SELECT
    pelicula
FROM
    pelicula
WHERE
    anio_estreno BETWEEN '1990'
    AND '1999'
ORDER BY
    pelicula ASC;

-- 7. Hacer una consulta SQL que muestre los títulos con su longitud, la longitud debe ser
-- nombrado para la consulta como “longitud_titulo”.
SELECT
    pelicula,
    LENGTH(pelicula) AS longitud_titulo
FROM
    pelicula;

-- 8. Consultar cual es la longitud más grande entre todos los títulos de las películas.
SELECT
    MAX(LENGTH(pelicula)) AS mayor_longitud_titulo
FROM
    pelicula;

-- Extras (no obligatorios) pero son de apreciacion del alumno.
-- 1. Consultar cuales son las peliculas con el nombre mas largo de manera descendente, con su logitud total
SELECT
    pelicula,
    MAX(LENGTH(pelicula)) AS mayor_longitud_titulo
FROM
    pelicula
GROUP BY
    pelicula
ORDER BY
    mayor_longitud_titulo DESC;