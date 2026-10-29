-- CREACIÓN DE LA BASE DE DATOS
CREATE DATABASE FerreteriaIndustrialDB;
GO

USE FerreteriaIndustrialDB;
GO

-- TABLAS Y RESTRICCIONES

-- Tabla: Categoria
CREATE TABLE Categoria (
    IdCategoria INT IDENTITY(1,1) PRIMARY KEY,
    NombreCategoria VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(255) NULL
);

-- Tabla: Proveedor
CREATE TABLE Proveedor (
    IdProveedor INT IDENTITY(1,1) PRIMARY KEY,
    NombreProveedor VARCHAR(150) NOT NULL,
    Teléfono VARCHAR(20) NOT NULL,
    Correo VARCHAR(100) NOT NULL
);

-- Tabla: Producto
CREATE TABLE Producto (
    IdProducto INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(150) NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL CHECK (PrecioUnitario > 0),
    Stock INT NOT NULL CHECK (Stock >= 0),
    IdCategoria INT NOT NULL,
    IdProveedor INT NOT NULL,
    CONSTRAINT FK_Producto_Categoria FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria),
    CONSTRAINT FK_Producto_Proveedor FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
);

-- Tabla: Bodega
CREATE TABLE Bodega (
    IdBodega INT IDENTITY(1,1) PRIMARY KEY,
    NombreBodega VARCHAR(100) NOT NULL,
    Ubicacion VARCHAR(255) NOT NULL
);

-- Tabla: Entrada
CREATE TABLE Entrada (
    IdEntrada INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    IdProducto INT NOT NULL,
    IdBodega INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    PrecioCompra DECIMAL(10,2) NOT NULL CHECK (PrecioCompra > 0),
    CONSTRAINT FK_Entrada_Producto FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    CONSTRAINT FK_Entrada_Bodega FOREIGN KEY (IdBodega) REFERENCES Bodega(IdBodega)
);

-- Tabla: Salida
CREATE TABLE Salida (
    IdSalida INT IDENTITY(1,1) PRIMARY KEY,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    IdProducto INT NOT NULL,
    IdBodega INT NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Motivo VARCHAR(255) NOT NULL,
    CONSTRAINT FK_Salida_Producto FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto),
    CONSTRAINT FK_Salida_Bodega FOREIGN KEY (IdBodega) REFERENCES Bodega(IdBodega)
);
GO


-- INSERCIÓNES

-- 3.1 Categorías (5 registros)
INSERT INTO Categoria (NombreCategoria, Descripcion) VALUES
('Herramientas Manuales', 'Martillos, desarmadores, llaves y pinzas'),
('Herramientas Eléctricas', 'Taladros, sierras circulares y amoladoras'),
('Tornillería y Fijación', 'Clavos, tornillos, tuercas y taquetes'),
('Pinturas y Acabados', 'Pinturas de aceite, látex, brochas y lijas'),
('Fontanería y Gasfitería', 'Tubos PVC, llaves de paso y accesorios de agua');

-- 3.2 Proveedores (5 registros)
INSERT INTO Proveedor (NombreProveedor, Teléfono, Correo) VALUES
('Herramientas Profesionales S.A.', '2300-1122', 'ventas@herramientaspro.com'),
('Industrias de Acero y Metal', '2455-8899', 'contacto@acierometal.com'),
('Pinturas y Solventes del Sur', '2211-3344', 'pedidos@pinturessur.com'),
('Conexiones y Tuberías Industriales', '2388-7766', 'info@conextub.com'),
('Ferretera Mayorista Global', '2499-5544', 'ventas@ferreteraglobal.com');

-- 3.3 Productos (20 registros)
INSERT INTO Producto (NombreProducto, PrecioUnitario, Stock, IdCategoria, IdProveedor) VALUES
('Martillo de Uña 16oz Stanley', 75.50, 40, 1, 1),
('Juego de Desarmadores 6 pzas', 95.00, 25, 1, 1),
('Llave Ajustable Perica 10 pulg', 60.00, 50, 1, 5),
('Pinza de Presión 10 pulg', 85.00, 18, 1, 5),
('Taladro Percutor 1/2 pulg 650W', 450.00, 12, 2, 1),
('Amoladora Angular 4-1/2 pulg', 380.00, 15, 2, 1),
('Sierra Circular 7-1/4 pulg', 620.00, 8, 2, 5),
('Caja de Clavos con Cabeza 2 pulg (1lb)', 15.00, 120, 3, 2),
('Tornillo para Madera 1-1/2 (Caja 100u)', 35.00, 90, 3, 2),
('Taquetes de Plásticos 1/4 (Bolsa 50u)', 18.00, 110, 3, 2),
('Tuercas Hexagonales 3/8 (Caja 50u)', 42.00, 45, 3, 2),
('Pintura Latex Blanca Galón', 125.00, 30, 4, 3),
('Esmalte Sintético Negro 1/4 Galón', 65.00, 55, 4, 3),
('Brocha de Cerdas 2 pulgadas', 12.00, 80, 4, 3),
('Lija para Madera Grano 80', 5.00, 200, 4, 3),
('Tubo PVC Hidráulico 1/2 pulg 6m', 45.00, 60, 5, 4),
('Codo PVC 90 Grados 1/2 pulg', 4.50, 150, 5, 4),
('Llave de Esfera Metálica 1/2 pulg', 38.00, 22, 5, 4),
('Pegamento para PVC Frasco 240ml', 28.00, 35, 5, 4),
('Teflón en Rollo Profesional', 8.50, 130, 5, 4);

-- 3.4 Bodegas (3 registros)
INSERT INTO Bodega (NombreBodega, Ubicacion) VALUES
('Bodega Central de Suministros', 'Zona 9, Ciudad Capital'),
('Bodega Periferica Sur', 'Villa Nueva, Kilómetro 18'),
('Bodega de Distribución Oriente', 'Chiquimula Centro');

-- 3.5 Entradas (30 registros)
INSERT INTO Entrada (Fecha, IdProducto, IdBodega, Cantidad, PrecioCompra) VALUES
('2026-09-01 08:30:00', 1, 1, 30, 55.00),
('2026-09-01 09:15:00', 5, 1, 10, 350.00),
('2026-09-02 10:00:00', 8, 2, 100, 10.00),
('2026-09-02 11:20:00', 12, 1, 20, 90.00),
('2026-09-03 08:00:00', 16, 3, 40, 32.00),
('2026-09-03 09:30:00', 3, 1, 25, 42.00),
('2026-09-04 14:00:00', 6, 2, 12, 280.00),
('2026-09-04 15:10:00', 9, 1, 50, 24.00),
('2026-09-05 08:45:00', 13, 3, 30, 45.00),
('2026-09-05 10:20:00', 17, 1, 80, 3.00),
('2026-09-06 11:00:00', 2, 2, 15, 70.00),
('2026-09-06 13:30:00', 4, 1, 10, 60.00),
('2026-09-07 09:00:00', 7, 3, 5, 480.00),
('2026-09-07 10:15:00', 10, 1, 60, 11.00),
('2026-09-08 08:20:00', 11, 2, 25, 28.00),
('2026-09-08 09:40:00', 14, 1, 40, 7.50),
('2026-09-09 10:00:00', 15, 3, 100, 3.00),
('2026-09-09 11:30:00', 18, 1, 15, 25.00),
('2026-09-10 08:00:00', 19, 2, 20, 18.00),
('2026-09-10 09:00:00', 20, 1, 70, 5.00),
('2026-09-11 08:30:00', 1, 2, 20, 55.00),
('2026-09-11 10:00:00', 5, 3, 5, 350.00),
('2026-09-12 09:15:00', 8, 1, 50, 10.00),
('2026-09-12 11:00:00', 12, 2, 15, 90.00),
('2026-09-13 08:45:00', 16, 1, 20, 32.00),
('2026-09-13 14:20:00', 3, 3, 10, 42.00),
('2026-09-14 09:00:00', 6, 1, 8, 280.00),
('2026-09-14 10:30:00', 9, 2, 30, 24.00),
('2026-09-15 08:00:00', 13, 3, 20, 45.00),
('2026-09-15 09:30:00', 17, 2, 50, 3.00);

-- 3.6 Salidas (20 registros)
INSERT INTO Salida (Fecha, IdProducto, IdBodega, Cantidad, Motivo) VALUES
('2026-09-02 10:00:00', 1, 1, 5, 'Venta a contratista obra gris'),
('2026-09-02 11:30:00', 5, 1, 3, 'Venta mostrador'),
('2026-09-03 09:00:00', 15, 1, 10, 'Merma por humedad en empaque'),
('2026-09-03 14:15:00', 8, 1, 20, 'Venta por volumen a carpintería'),
('2026-09-04 08:30:00', 12, 2, 5, 'Venta minorista'),
('2026-09-04 10:00:00', 16, 3, 10, 'Venta para instalación hidráulica'),
('2026-09-05 11:00:00', 2, 1, 4, 'Venta ferretera local'),
('2026-09-05 15:45:00', 19, 2, 5, 'Uso para reparaciones internas en bodega'),
('2026-09-06 09:20:00', 3, 1, 8, 'Venta mostrador'),
('2026-09-06 13:00:00', 6, 1, 3, 'Venta taller mecánico'),
('2026-09-07 10:00:00', 10, 3, 15, 'Venta paquete instalación'),
('2026-09-08 08:45:00', 13, 1, 10, 'Venta a pintor residencial'),
('2026-09-08 12:10:00', 17, 1, 30, 'Venta fontanero externo'),
('2026-09-09 09:30:00', 20, 3, 20, 'Venta mostrador'),
('2026-09-10 10:15:00', 4, 1, 2, 'Garantía por defecto de fábrica'),
('2026-09-10 14:00:00', 7, 3, 2, 'Venta constructora'),
('2026-09-11 08:30:00', 9, 1, 15, 'Venta carpintería'),
('2026-09-12 09:00:00', 11, 2, 5, 'Venta armado de estructuras'),
('2026-09-13 11:20:00', 14, 2, 12, 'Venta menudeo'),
('2026-09-14 16:00:00', 18, 2, 3, 'Venta mostrador');
GO


-- CONSULTAS SQL

-- Consulta 1: Top 5 productos con más salidas
SELECT TOP 5 
    p.IdProducto,
    p.NombreProducto,
    SUM(s.Cantidad) AS TotalUnidadesSalida
FROM Salida s
INNER JOIN Producto p ON s.IdProducto = p.IdProducto
GROUP BY p.IdProducto, p.NombreProducto
ORDER BY TotalUnidadesSalida DESC;

-- Consulta 2: Productos con stock por debajo de 15 unidades 
SELECT 
    IdProducto,
    NombreProducto,
    Stock,
    PrecioUnitario
FROM Producto
WHERE Stock <= 15
ORDER BY Stock ASC;


-- VISTAS
USE FerreteriaIndustrialDB;
GO

-- VISTA StockPorCategoria
CREATE VIEW StockPorCategoria AS
SELECT 
    c.IdCategoria,
    c.NombreCategoria,
    COUNT(p.IdProducto) AS TotalProductos,
    SUM(p.Stock) AS StockTotal,
    AVG(p.PrecioUnitario) AS PrecioPromedio
FROM Categoria c
LEFT JOIN Producto p ON c.IdCategoria = p.IdCategoria
GROUP BY c.IdCategoria, c.NombreCategoria;
GO


SELECT * FROM StockPorCategoria;