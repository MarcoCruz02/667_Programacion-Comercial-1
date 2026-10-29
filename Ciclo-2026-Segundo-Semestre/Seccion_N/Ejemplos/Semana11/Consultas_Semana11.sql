-- Consulta 1: Listar todos los instrumentos con su categoría y proveedor 
SELECT i.InstrumentoID, i.Nombre AS Instrumento, c.NombreCategoria, p.NombreProveedor, i.Precio, i.Stock
FROM Instrumentos i
INNER JOIN Categorias c ON i.CategoriaID = c.CategoriaID
INNER JOIN Proveedores p ON i.ProveedorID = p.ProveedorID;

-- Consulta 2: Filtrar instrumentos cuyo stock sea menor o igual a 5 unidades
SELECT Nombre, Stock, Precio 
FROM Instrumentos 
WHERE Stock <= 5;

-- Consulta 3: Calcular el valor total del inventario agrupado por categoría
SELECT c.NombreCategoria, SUM(i.Precio * i.Stock) AS ValorTotalInventario
FROM Instrumentos i
INNER JOIN Categorias c ON i.CategoriaID = c.CategoriaID
GROUP BY c.NombreCategoria;

INSERT INTO Categorias (NombreCategoria) 
VALUES ('Instrumentos Antiguos y Colección');
GO

SELECT 
    c.NombreCategoria, 
    i.Nombre AS Instrumento, 
    i.Precio, 
    i.Stock
FROM Categorias c
LEFT JOIN Instrumentos i ON c.CategoriaID = i.CategoriaID;



-- 1. CREACIÓN DE UN ÍNDICE (Optimiza búsquedas por nombre de instrumento)
USE TiendaInstumentos;
GO

SET STATISTICS TIME ON;
SET STATISTICS IO ON;
GO

SELECT * 
FROM Instrumentos 
WHERE Nombre = 'Guitarra Acústica C.F. Martin';
GO

CREATE INDEX IX_Instrumentos_Nombre 
ON Instrumentos(Nombre);
GO

SELECT * 
FROM Instrumentos 
WHERE Nombre = 'Guitarra Acústica C.F. Martin';
GO


-- 2. CREACIÓN DE UNA VISTA (Muestra el inventario resumido)
CREATE VIEW vw_ResumenInventario AS
SELECT 
    i.InstrumentoID,
    i.Nombre AS Instrumento,
    c.NombreCategoria,
    i.Precio,
    i.Stock,
    (i.Precio * i.Stock) AS InversionTotal
FROM Instrumentos i
INNER JOIN Categorias c ON i.CategoriaID = c.CategoriaID;
GO

-- Prueba de la vista:
SELECT * FROM vw_ResumenInventario;
GO


-- 3. CREACIÓN DE UN PROCEDIMIENTO ALMACENADO (Permite buscar instrumentos por categoría mediante un parámetro)
CREATE PROCEDURE sp_BuscarPorCategoria
    @NombreCategoria VARCHAR(50)
AS
BEGIN
    SELECT i.InstrumentoID, i.Nombre, i.Precio, i.Stock, p.NombreProveedor
    FROM Instrumentos i
    INNER JOIN Categorias c ON i.CategoriaID = c.CategoriaID
    INNER JOIN Proveedores p ON i.ProveedorID = p.ProveedorID
    WHERE c.NombreCategoria = @NombreCategoria;
END;
GO

-- Prueba del Procedimiento Almacenado:
EXEC sp_BuscarPorCategoria @NombreCategoria = 'Teclados';
GO

