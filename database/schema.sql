IF DB_ID(N'jakartaJPA') IS NULL
BEGIN
    CREATE DATABASE jakartaJPA;
END;
GO

USE jakartaJPA;
GO

IF OBJECT_ID(N'dbo.categories', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.categories (
        CategoryId INT IDENTITY(1,1) PRIMARY KEY,
        Categoryname NVARCHAR(200) NOT NULL,
        Images NVARCHAR(500) NULL,
        Status INT NOT NULL DEFAULT 1
    );
END;
GO

IF OBJECT_ID(N'dbo.users', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username VARCHAR(50) NOT NULL UNIQUE,
        password VARCHAR(200) NOT NULL,
        fullname NVARCHAR(100) NULL,
        phone VARCHAR(20) NULL,
        email VARCHAR(100) NULL UNIQUE,
        images NVARCHAR(500) NULL,
        role INT NOT NULL DEFAULT 0,
        active INT NULL DEFAULT 1,
        created_at DATETIME2 NULL DEFAULT SYSDATETIME()
    );
END;
GO

IF COL_LENGTH('dbo.users', 'active') IS NULL
    ALTER TABLE dbo.users ADD active INT NULL DEFAULT 1;
GO

IF COL_LENGTH('dbo.users', 'created_at') IS NULL
    ALTER TABLE dbo.users ADD created_at DATETIME2 NULL DEFAULT SYSDATETIME();
GO

IF OBJECT_ID(N'dbo.products', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.products (
        ProductId INT IDENTITY(1,1) PRIMARY KEY,
        ProductName NVARCHAR(255) NOT NULL,
        Description NVARCHAR(2000) NULL,
        Price DECIMAL(18,2) NOT NULL,
        Quantity INT NOT NULL DEFAULT 0,
        Images NVARCHAR(500) NULL,
        Status INT NOT NULL DEFAULT 1,
        CreatedAt DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
        CategoryId INT NOT NULL,
        CONSTRAINT FK_products_categories FOREIGN KEY (CategoryId)
            REFERENCES dbo.categories(CategoryId)
    );
    CREATE INDEX idx_product_created_at ON dbo.products(CreatedAt);
    CREATE INDEX idx_product_category ON dbo.products(CategoryId);
END;
GO
