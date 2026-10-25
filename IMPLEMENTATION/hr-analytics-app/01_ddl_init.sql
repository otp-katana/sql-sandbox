-- 1. Veritabanı Oluşturma ve Seçme
USE master;
GO

CREATE DATABASE TechStart_DB;
GO

USE TechStart_DB;
GO

-- 2. İnsan Kaynakları (EKIP) Tablosunun Kurulumu
CREATE TABLE EKIP (
	ID INT PRIMARY KEY IDENTITY (1,1),
	AD_SOYAD NVARCHAR (50),
	DEPARTMAN NVARCHAR (50),
	YAS INT,
	MAAS DECIMAL (7,2),
	PERFORMANS_PUANI INT
);
GO