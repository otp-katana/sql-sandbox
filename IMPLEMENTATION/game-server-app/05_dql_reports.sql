USE GameServer_DB;
GO

-- 1. Liderlik Tablosu (En yüksek seviyeli ilk 3 oyuncu)
SELECT TOP 3 KULLANICI_ADI, SEVIYE FROM OYUNCULAR
ORDER BY SEVIYE DESC;
GO

-- 2. Fakirhane (Altını 1000'den veya Seviyesi 10'dan az olanlar)
SELECT * FROM OYUNCULAR
WHERE ALTIN_BAKIYE < 1000 OR SEVIYE < 10;
GO

-- 3. Kayıt Günlüğü (En yeni oyunculardan en eskilere doğru sıralı - DESC olarak düzeltildi)
SELECT * FROM OYUNCULAR
ORDER BY KAYIT_TARIHI DESC;
GO