USE Eticaret_DB;
GO

-- 1. Kullanıcı Verilerinin Eklenmesi
INSERT INTO KULLANICILAR (AD, SOYAD, KAYIT_TARIHI, AKTIF_MI)
VALUES
('Ahmet', 'Yılmaz', '2026-01-15 10:30:00', 1),
('Zeynep', 'Demir', '2026-02-20 14:45:00', 1),
('Burak', 'Şahin', '2026-05-12 16:20:00', 1),
('Elif', 'Çelik', '2026-10-10 11:00:00', 0),
('X', 'Anonim', '2026-10-13 03:00:00', 0);
GO

-- 2. Ürün Verilerinin Eklenmesi
INSERT INTO URUNLER (URUN_ADI, URUN_GRUBU, FIYAT, STOK_ADEDI)
VALUES
('Asus ROG Strix', 'Elektronik', 45000.00, 15),
('Sony WH-1000XM5', 'Elektronik', 12500.00, 8),
('Mavi Yün Kazak', 'Giyim', 850.50, 40),
('North Face Mont', 'Giyim', 4500.00, 5),
('Dior Sauvage Parfüm', 'Kozmetik', 3200.00, 1),
('iPhone 15 Pro', 'Elektronik', 75000.00, 25);
GO