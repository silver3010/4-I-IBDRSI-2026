-Ejercicio 1- carrito de compra

CREATE TABLE carrito1 (
    id int NOT NULL auto_increment PRIMARY KEY,
    Articulo VARCHAR(50) NOT NULL
);


INSERT INTO carrito1 (Articulo) VALUES
('Azucar'),
('Pan'),
('Juego'),
('Refresco'),
('Harina');


CREATE TABLE carrito2 (
    id int NOT NULL auto_increment PRIMARY KEY,
    Articulo VARCHAR (50) NOT NULL
);


INSERT INTO carrito2 (Articulo) VALUES 
('Azucar'),
('Pan'),
('Mantequilla'),
('Queso'),
('Manzana');


SELECT
    c1.Articulo AS "Articulos del carrito1",
    c2.Articulo AS "Articulos del carrito2"
FROM carrito1 cl
LEFT JOIN carrito2 c2 ON cl.Articulo = c2.Articulo
UNION
SELECT
    c1.Articulo AS "Articulos del carrito1",
    c2.Articulo AS "Articulos del carrito2"
FROM carrito1 cl
RIGHT JOIN carrito2 c2 ON cl.Articulo = c2.Articulo

-- Ejercicio 2 - Empleados y Gerentes

CREATE TABLE Empleados (
    Id_empleados INT PRIMARY KEY,
    Id_gerente INT NULL,
    puesto VARCHAR (50) NOT NULL

);


INSERT INTO Empleados (Id_empleados, Id_gerente, puesto) VALUES
(1001, NULL, 'Presidente'),
(2002, 1001, 'Directo'),
(3003, 1001, 'Gerente'),
(4004, 2002, 'Ingeniero'),
(5005, 2002, 'Contador'),
(6006, 2002, 'Administrador');


WITH RECURSIVE Jerarquia AS (
    SELECT Id_empleados, Id_gerente, puesto, 0 AS Nivel
    FROM Empleados
    WHERE Id_gerente IS NULL

    UNION NULL

    SELECT e.Id_empleados, e.Id_gerente, e.puesto, j.Nivel + 1
    FROM Empleados e
    JOIN Jerarquia j ON e.Id_gerente = j.Id_empleados
) SELECT * FROM Jerarquia ORDER BY Nivel, Id_empleados;

-- Ejercicio 3 - Dos predicados

CREATE TABLE Ordenes (
    Id_cliente INT NOT NULL,
    Id_Orden INT PRIMARY KEY,
    Estado_Destino VARCHAR(10) NOT NULL,
    Costo DECIMAL(10, 2)NOT NULL
);


INSERT INTO Ordenes (Id_cliente, Id_Orden, Estado_Destino, Costo)
VALUES
(1001, 1, 'JAL', 987.00),
(1001, 2, 'CDMX', 400.00),
(1001, 3, 'CDMX', 545.00),
(1001, 4, 'CDMX', 321.00),
(2002, 5, 'MTY', 324.00),
(3003, 6, 'JAL', 931.00),
(4004, 7, 'JAL', 876.00),
(5005, 8, 'CDMX', 567.00);

SELECT o.Id_cliente, o.Id_Orden, o.Estado_Destino, o.Costo
FROM Ordenes o
WHERE o.Estado_Destino = 'CDMX'
  AND o.Id_cliente IN (
    SELECT DISTINCT Id_cliente
    FROM Ordenes
    WHERE Estado_Destino = 'JAL'
  );