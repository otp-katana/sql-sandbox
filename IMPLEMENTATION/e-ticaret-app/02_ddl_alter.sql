USE Eticaret_DB;
GO

-- 1. Kullanıcılar tablosuna aktiflik durumu ekleme
ALTER TABLE KULLANICILAR
ADD AKTIF_MI BIT;
GO

-- 2. Kullanıcılar tablosundan e-posta sütununu kaldırma
ALTER TABLE KULLANICILAR
DROP COLUMN E_POSTA;
GO

-- 3. Ürünler tablosundaki kategori ismini güncelleme
EXEC SP_RENAME 'URUNLER.KATEGORI', 'URUN_GRUBU', 'COLUMN';
GO