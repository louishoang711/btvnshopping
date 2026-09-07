USE jakartaJPA;
GO

SET NOCOUNT ON;

MERGE dbo.categories AS target
USING (VALUES
    (N'Electronics', N'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=600&h=600&fit=crop&auto=format', 1),
    (N'Apparel', N'https://images.unsplash.com/photo-1542272604-787c3835535d?w=600&h=600&fit=crop&auto=format', 1),
    (N'Home & Garden', N'https://images.unsplash.com/photo-1585664811087-47f65abbad64?w=600&h=600&fit=crop&auto=format', 1),
    (N'Sports', N'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&h=600&fit=crop&auto=format', 1)
) AS source(Categoryname, Images, Status)
ON target.Categoryname = source.Categoryname
WHEN MATCHED THEN UPDATE SET Images = source.Images, Status = source.Status
WHEN NOT MATCHED THEN INSERT (Categoryname, Images, Status) VALUES (source.Categoryname, source.Images, source.Status);

DECLARE @Electronics INT = (SELECT TOP 1 CategoryId FROM dbo.categories WHERE Categoryname = N'Electronics');
DECLARE @Apparel INT = (SELECT TOP 1 CategoryId FROM dbo.categories WHERE Categoryname = N'Apparel');
DECLARE @HomeGarden INT = (SELECT TOP 1 CategoryId FROM dbo.categories WHERE Categoryname = N'Home & Garden');
DECLARE @Sports INT = (SELECT TOP 1 CategoryId FROM dbo.categories WHERE Categoryname = N'Sports');

MERGE dbo.products AS target
USING (VALUES
    (N'Sony WH-1000XM5', N'Industry-leading noise cancellation with up to 30 hours of battery life.', 8990000.00, 84, N'https://images.unsplash.com/photo-1618366712010-f4ae9c647dcb?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-1,SYSDATETIME()), @Electronics),
    (N'Dyson V15 Detect', N'Whole-home cleaning with laser dust detection technology.', 17990000.00, 31, N'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-2,SYSDATETIME()), @HomeGarden),
    (N'Nike Air Max 270', N'Comfortable everyday performance with an iconic Air Max design.', 3990000.00, 162, N'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-3,SYSDATETIME()), @Sports),
    (N'Apple AirPods Pro', N'Immersive audio, active noise cancellation and a compact charging case.', 6290000.00, 0, N'https://images.unsplash.com/photo-1606741965429-02919b2cf6b9?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-4,SYSDATETIME()), @Electronics),
    (N'KitchenAid Stand Mixer', N'Professional-grade performance for home chefs who value quality.', 11490000.00, 22, N'https://images.unsplash.com/photo-1585664811087-47f65abbad64?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-5,SYSDATETIME()), @HomeGarden),
    (N'Levi''s 501 Jeans', N'The original straight-fit jeans with timeless five-pocket styling.', 2290000.00, 310, N'https://images.unsplash.com/photo-1542272604-787c3835535d?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-6,SYSDATETIME()), @Apparel),
    (N'Patagonia Down Sweater', N'Warm, lightweight and windproof outerwear for everyday adventures.', 5790000.00, 7, N'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-7,SYSDATETIME()), @Apparel),
    (N'Garmin Forerunner 265', N'Advanced GPS tracking and health monitoring for dedicated athletes.', 11490000.00, 45, N'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-8,SYSDATETIME()), @Sports),
    (N'Bose SoundLink Flex', N'Portable waterproof speaker with clear, balanced sound.', 3790000.00, 0, N'https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-9,SYSDATETIME()), @Electronics),
    (N'Le Creuset Dutch Oven', N'Premium enameled cast iron for slow cooking, roasting and baking.', 9390000.00, 18, N'https://images.unsplash.com/photo-1584990347449-a5d9f800a783?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-10,SYSDATETIME()), @HomeGarden),
    (N'Logitech MX Master 3S', N'Quiet precision mouse designed for productive creative workflows.', 2490000.00, 93, N'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-11,SYSDATETIME()), @Electronics),
    (N'Instant Pot Duo 7-in-1', N'Seven convenient cooking functions in one compact appliance.', 2490000.00, 55, N'https://images.unsplash.com/photo-1585664811087-47f65abbad64?w=600&h=600&fit=crop&auto=format', 1, DATEADD(MINUTE,-12,SYSDATETIME()), @HomeGarden)
) AS source(ProductName, Description, Price, Quantity, Images, Status, CreatedAt, CategoryId)
ON target.ProductName = source.ProductName
WHEN MATCHED THEN UPDATE SET Description=source.Description, Price=source.Price, Quantity=source.Quantity, Images=source.Images, Status=source.Status, CategoryId=source.CategoryId
WHEN NOT MATCHED THEN INSERT (ProductName, Description, Price, Quantity, Images, Status, CreatedAt, CategoryId)
VALUES (source.ProductName, source.Description, source.Price, source.Quantity, source.Images, source.Status, source.CreatedAt, source.CategoryId);

DELETE FROM dbo.categories
WHERE Categoryname NOT IN (N'Electronics', N'Apparel', N'Home & Garden', N'Sports')
  AND NOT EXISTS (SELECT 1 FROM dbo.products p WHERE p.CategoryId = dbo.categories.CategoryId)
  AND NOT EXISTS (SELECT 1 FROM dbo.videos v WHERE v.CategoryId = dbo.categories.CategoryId);
GO
