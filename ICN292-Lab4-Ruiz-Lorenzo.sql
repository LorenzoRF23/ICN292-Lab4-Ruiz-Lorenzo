-- ICN292 Laboratorio 4 - SQL (1/2)
-- Lorenzo Ruiz Flandez

DROP DATABASE IF EXISTS austral;
CREATE DATABASE austral;
USE austral;

-- Entregable 1: tablas

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT,
    nombre VARCHAR(80) NOT NULL,
    pais VARCHAR(60) NULL,
    genero ENUM('Cómic', 'Ensayo', 'Infantil', 'Novela', 'Poesía') NOT NULL,
    PRIMARY KEY (id_autor)
);

-- colecciones y pagos son las tablas que faltaban (consultas 9 y 10)
CREATE TABLE colecciones (
    id_coleccion INT AUTO_INCREMENT,
    titulo VARCHAR(120) NOT NULL,
    fecha_publicacion DATE NOT NULL,
    PRIMARY KEY (id_coleccion)
);

-- id_coleccion queda en NULL hasta la consulta 9 porque la carga oficial no trae colecciones
CREATE TABLE libros (
    id_libro INT AUTO_INCREMENT,
    id_autor INT NOT NULL,
    id_coleccion INT NULL,
    titulo VARCHAR(120) NOT NULL,
    paginas INT,
    ejemplares_vendidos INT,
    anio INT,
    PRIMARY KEY (id_libro),
    FOREIGN KEY (id_autor) REFERENCES autores (id_autor),
    FOREIGN KEY (id_coleccion) REFERENCES colecciones (id_coleccion)
);

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT,
    id_autor INT NOT NULL,
    fecha_pago DATE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_autor) REFERENCES autores (id_autor)
);

-- Carga oficial

INSERT INTO autores (nombre, pais, genero) VALUES
    ('Elena Pizarro', 'Chile', 'Novela'),
    ('Harold Finch', 'Inglaterra', 'Ensayo'),
    ('Rodrigo Bahamonde', 'Chile', 'Poesía'),
    ('Valentina Correa', 'Argentina', 'Infantil'),
    ('Nora Keller', 'Estados Unidos', 'Novela'),
    ('Kenji Arakawa', NULL, 'Cómic');

INSERT INTO libros (id_autor, titulo, paginas, ejemplares_vendidos, anio) VALUES
    (1, 'Cielo de Enero', 210, 1500, 2024),
    (1, 'Marea Baja', 185, 800, 2023),
    (1, 'El Norte', 200, 2200, 2024),
    (2, 'Estrellas que Caen', 240, 3000, 2022),
    (2, 'Máquinas', 215, 450, 2024),
    (3, 'Luz Artificial', 300, 1200, 2024),
    (3, 'Ruido Blanco', 280, 600, 2023),
    (4, 'El Barrio de Lila', 190, 5000, 2024),
    (4, 'Antes del Amanecer', 205, 2700, 2024),
    (4, 'La Calle 8', 175, 900, 2023),
    (5, 'Flor de Hierro', 195, 4100, 2024),
    (5, 'Hora Dorada', 220, 1800, 2022);

-- Entregable 2: consultas

-- Consulta 1
SELECT nombre, genero
FROM autores
WHERE pais <> 'Chile' OR pais IS NULL
ORDER BY nombre;

-- Consulta 2
SELECT titulo, paginas
FROM libros
WHERE paginas >= 190 AND paginas <= 220
ORDER BY paginas ASC;

-- Consulta 3
SELECT COUNT(*) AS total_libros,
       SUM(ejemplares_vendidos) AS total_ejemplares_vendidos,
       AVG(paginas) AS promedio_paginas,
       MIN(anio) AS anio_mas_antiguo,
       MAX(ejemplares_vendidos) AS max_ejemplares_un_libro
FROM libros;

-- Consulta 4
SELECT DISTINCT genero
FROM autores
ORDER BY genero;

-- Consulta 5
SELECT a.nombre, COUNT(*) AS libros_2024
FROM autores AS a
JOIN libros AS l ON l.id_autor = a.id_autor
WHERE l.anio = 2024
GROUP BY a.id_autor, a.nombre
HAVING COUNT(*) > 1
ORDER BY a.nombre;

-- Consulta 6
SELECT titulo, ejemplares_vendidos
FROM libros
WHERE anio = 2024 AND ejemplares_vendidos > 2000
ORDER BY ejemplares_vendidos DESC
LIMIT 3;

-- Workbench viene con safe updates activado y no deja hacer el DELETE ni el UPDATE filtrando por titulo
SET SQL_SAFE_UPDATES = 0;

-- Consulta 7
INSERT INTO libros (id_autor, titulo, paginas, ejemplares_vendidos, anio)
VALUES (3, 'Papel Mojado', 260, 50, 2024);

SELECT * FROM libros WHERE titulo = 'Papel Mojado';

DELETE FROM libros WHERE titulo = 'Papel Mojado';

SELECT * FROM libros WHERE titulo = 'Papel Mojado';

-- Consulta 8
SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';

UPDATE libros
SET ejemplares_vendidos = ejemplares_vendidos + 100
WHERE titulo = 'Cielo de Enero';

SELECT titulo, ejemplares_vendidos FROM libros WHERE titulo = 'Cielo de Enero';

-- Consulta 9
INSERT INTO colecciones (titulo, fecha_publicacion) VALUES
    ('Narrativa del Sur', '2022-04-23'),
    ('Pensamiento y Verso', '2022-09-10'),
    ('Pequeños Lectores', '2023-03-27');

UPDATE libros SET id_coleccion = 1 WHERE id_autor = 1 OR id_autor = 5;
UPDATE libros SET id_coleccion = 2 WHERE id_autor = 2 OR id_autor = 3;
UPDATE libros SET id_coleccion = 3 WHERE id_autor = 4;

SELECT l.titulo AS libro, c.titulo AS coleccion, c.fecha_publicacion
FROM libros AS l
JOIN colecciones AS c ON l.id_coleccion = c.id_coleccion
ORDER BY c.fecha_publicacion, l.titulo;

-- Consulta 10
INSERT INTO pagos (id_autor, fecha_pago, monto) VALUES
    (1, '2026-03-31', 850000.00),
    (4, '2026-04-15', 1250000.00),
    (1, '2026-09-30', 620500.50),
    (5, '2026-10-05', 980000.00);

SELECT a.nombre, p.fecha_pago, p.monto
FROM pagos AS p
JOIN autores AS a ON p.id_autor = a.id_autor
ORDER BY p.fecha_pago;

SELECT a.nombre, SUM(p.monto) AS total_pagado
FROM pagos AS p
JOIN autores AS a ON p.id_autor = a.id_autor
GROUP BY a.id_autor, a.nombre
ORDER BY a.nombre;
