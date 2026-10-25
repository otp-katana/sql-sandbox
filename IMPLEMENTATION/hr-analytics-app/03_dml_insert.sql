USE TechStart_DB;
GO

-- 1. Personel Verilerinin Eklenmesi
INSERT INTO EKIP (
	AD_SOYAD,
	DEPARTMAN,
	YAS,
	MAAS,
	PERFORMANS_PUANI
)
VALUES
('Ali Yılmaz', 'Yazılım', 28, 45000.00, 85),
('Ayşe Demir', 'Pazarlama', 32, 38000.00, 92),
('Can Şahin', 'Yazılım', 24, 41000.00, 78),
('Elif Çelik', 'Tasarım', 29, 36000.00, 88),
('Burak Kaya', 'Yazılım', 35, 52000.00, 95),
('Ceren Yıldız', 'Pazarlama', 26, 34000.00, 70),
('Deniz Ak', 'Tasarım', 31, 39000.00, 90);
GO