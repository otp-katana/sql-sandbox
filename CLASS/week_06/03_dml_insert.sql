USE EtkinlikBilet_DB;
GO

-- 1. Kullanıcı Verileri
INSERT INTO KULLANICILAR (AD_SOYAD, SEHIR, YAS)
VALUES 
('Deniz Arslan', 'Trabzon', 22),
('Zeynep Kaya', 'Ankara', 28),
('Mert Yılmaz', 'İstanbul', 24),
('Ece Demir', 'İzmir', 31),
('Burak Çelik', 'Ankara', 35);
GO

-- 2. Etkinlik Verileri (Tarih ve kapasite şemada zorunlu olduğu için varsayılan değerlerle eklendi)
INSERT INTO ETKINLIKLER (ETKINLIK_ID, ETKINLIK_ADI, KATEGORI, SEHIR, TARIH, BILET_FIYATI, KAPASITE)
VALUES 
(101, 'Yapay Zeka Zirvesi', 'Konferans', 'Ankara', '2026-12-01', 750.00, 500),
(102, 'Indie Rock Gecesi', 'Konser', 'İstanbul', '2026-11-20', 600.00, 1500),
(103, 'Oyun Tasarım Atölyesi', 'Atölye', 'İzmir', '2026-11-25', 450.00, 50),
(104, 'Dijital Sanat Festivali', 'Festival', 'Trabzon', '2026-12-10', 300.00, 1000),
(105, 'Siber Güvenlik Kampı', 'Eğitim', 'Ankara', '2026-12-15', 900.00, 100);
GO

-- 3. Satılan Biletlerin Verileri
INSERT INTO BILETLER (KULLANICI_ID, ETKINLIK_ID, SATIN_ALMA_TARIHI, ODENEN_TUTAR, DURUM)
VALUES 
(1, 101, '2026-11-01', 750.00, 'Aktif'),
(2, 101, '2026-11-02', 700.00, 'Aktif'),
(3, 102, '2026-11-02', 600.00, 'Aktif'),
(4, 103, '2026-11-03', 450.00, 'Aktif'),
(5, 105, '2026-11-03', 900.00, 'Aktif');
GO