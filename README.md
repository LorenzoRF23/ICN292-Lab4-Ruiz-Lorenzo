# ICN292-Lab4-Ruiz-Lorenzo

Entrega del Laboratorio 4 de ICN-292 (Sistemas de Información para la Gestión), USM, 2026-2. Lorenzo Ruiz Flandez.

El laboratorio pide rehacer en MySQL 8 la base `austral` de una editorial, Austral Editores. Después de un error quedaron borradas las tablas `colecciones` y `pagos`, así que el script las vuelve a crear, carga los 6 autores y 12 libros del enunciado y responde 10 consultas.

## Qué hay en el repo

| Archivo | Contenido |
| --- | --- |
| `ICN292-Lab4-Ruiz-Lorenzo.sql` | creación de las tablas, carga de datos y las 10 consultas |
| `ICN292-Lab4-Ruiz-Lorenzo.tex` | informe en LaTeX |
| `ICN292-Lab4-Ruiz-Lorenzo.pdf` | el mismo informe en PDF |
| `imagenes/` | logos y capturas que usa el `.tex` |
| `ICN292-Lab4-Ruiz-Lorenzo.png` | modelo entidad-relación (Reverse Engineer de Workbench) |

## Cómo leerlo

El informe tiene una portada y después una sección por consulta, con el código tal como se ejecutó y la captura de lo que devolvió Workbench. En la consulta 1 hay además una línea que explica por qué `pais <> 'Chile'` no trae a Kenji Arakawa.

En el `.sql` todo va en el orden en que se corre: primero las tablas, después la carga oficial y al final las consultas, cada una marcada con un comentario `-- Consulta N`.

## Para correrlo

Abrir el `.sql` en MySQL Workbench y ejecutarlo. Como empieza con `DROP DATABASE IF EXISTS austral`, se puede correr las veces que haga falta y siempre parte de cero. Ojo con el orden: las consultas 1 a 6 van antes de la 7 y la 8, que modifican los datos.
