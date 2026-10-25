USE Eticaret_DB;
GO

-- 1. Fazlalık Test Verilerinin Silinmesi
DELETE FROM KULLANICILAR WHERE KULLANICI_ID >= 6;
DELETE FROM URUNLER WHERE URUN_ID >= 6;
GO

-- 2. Uzun ürün isimleri için sütun kapasitesinin artırılması
ALTER TABLE URUNLER ALTER COLUMN URUN_ADI NVARCHAR (50);
GO

-- 3. Ürün Verilerinin Güncellenmesi
UPDATE URUNLER
SET URUN_ADI = 'Asus ROG Strix Oled Xg27aqdpg 26.5" Monitör'
WHERE URUN_ID = 1;
GO

UPDATE URUNLER
SET STOK_ADEDI = 0
WHERE URUN_ID = 5;
GO

UPDATE URUNLER
SET FIYAT = FIYAT - 200
WHERE URUN_GRUBU = 'Giyim';
GO

-- 4. Pasif ve İstenmeyen Kullanıcının Silinmesi
DELETE FROM KULLANICILAR
WHERE AD = 'X' AND AKTIF_MI = 0;
GO