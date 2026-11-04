USE EtkinlikBilet_DB;
GO

-- 1. Dinamik Matematik (UPDATE): Ankara etkinliklerine %15 zam yap
UPDATE ETKINLIKLER
SET BILET_FIYATI = BILET_FIYATI * 1.15
WHERE SEHIR = 'Ankara';
GO

-- 2. İptal Operasyonu (UPDATE): Kullanıcı 3'ün 102 numaralı etkinliğe aldığı bileti pasife çek
UPDATE BILETLER
SET DURUM = 'İptal', IDAE_TALEBI = 1
WHERE KULLANICI_ID = 3 AND ETKINLIK_ID = 102;
GO

-- 3. Veri Temizliği (DELETE): Yaşı 18'den küçük olan test hesaplarını sil
DELETE FROM KULLANICILAR
WHERE YAS < 18;
GO