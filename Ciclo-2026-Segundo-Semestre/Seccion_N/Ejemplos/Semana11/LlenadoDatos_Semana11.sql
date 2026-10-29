USE TiendaInstrumentos;
GO

INSERT INTO Categorias (NombreCategoria) VALUES 
('Cuerdas'), 
('Percusión'), 
('Teclados'), 
('Viento');

INSERT INTO Proveedores (NombreProveedor, Telefono) VALUES 
('Yamaha Music Corp', '555-0101'),
('Fender Musical Instruments', '555-0202'),
('Roland Corporation', '555-0303'),
('Gibson Brands', '555-0404'),
('Pearl Drums', '555-0505');

INSERT INTO Instrumentos (Nombre, CategoriaID, ProveedorID, Precio, Stock) VALUES 
('Guitarra Acústica C.F. Martin', 1, 2, 450.00, 12),
('Guitarra Eléctrica Stratocaster', 1, 2, 850.00, 8),
('Bajo Eléctrico Precision', 1, 2, 700.00, 5),
('Ukelel Soprano', 1, 1, 95.00, 25),
('Violín Acústico 4/4', 1, 1, 300.00, 7),
('Batería Acústica Export Series', 2, 5, 1200.00, 3),
('Caja / Redoblante 14x5.5', 2, 5, 250.00, 10),
('Platillos Hi-Hat 14"', 2, 5, 320.00, 6),
('Pandereta Profesional', 2, 5, 35.00, 40),
('Bongós de Madera', 2, 5, 140.00, 15),
('Piano Digital 88 Teclas', 3, 3, 950.00, 4),
('Sintetizador Analógico', 3, 3, 1100.00, 5),
('Teclado Portátil 61 Teclas', 3, 1, 220.00, 14),
('Controlador MIDI USB', 3, 3, 180.00, 20),
('Órgano Electrónico Compacto', 3, 3, 800.00, 2),
('Saxofón Alto Eb', 4, 1, 750.00, 6),
('Flauta Traversa de Níquel', 4, 1, 280.00, 9),
('Trompeta en Sib', 4, 1, 450.00, 8),
('Clarinete Soprano', 4, 1, 390.00, 7),
('Armónica Diatónica en Do', 4, 1, 45.00, 30);
GO