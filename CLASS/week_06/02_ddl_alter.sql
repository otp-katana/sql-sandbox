USE EtkinlikBilet_DB;
GO

-- 1. İsimlerdeki Unicode (Türkçe) karakter desteğini sağlama
ALTER TABLE KULLANICILAR
ALTER COLUMN AD_SOYAD NVARCHAR(100);
GO

-- 2. Biletler tablosuna güvenlik amacıyla 'İade Edildi' durumunu tutacak hızlı bir bayrak ekleme
ALTER TABLE BILETLER
ADD IDAE_TALEBI BIT DEFAULT 0;
GO