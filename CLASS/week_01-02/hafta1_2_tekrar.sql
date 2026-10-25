CREATE TABLE OGRENCILER (
	OGRENCI_ID INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	OGRENCI_NO INT NOT NULL,
	AD_SOYAD NVARCHAR (50) NOT NULL,
	BOLUM NVARCHAR (50) NOT NULL,
	SINIF INT NOT NULL,
	NOT_ORTALAMASI DECIMAL (3,2),
	SEHIR NVARCHAR (20)
);


INSERT INTO OGRENCILER (OGRENCI_NO, AD_SOYAD, BOLUM, SINIF, NOT_ORTALAMASI, SEHIR)
VALUES
(1001, 'Ayşe Yılmaz', 'Yönetim Bilişim Sistemleri', 2, 3.25, 'Trabzon'),
(1002, 'Mehmet Kaya', 'İşletme', 3, 2.40, 'Gümüşhane'),
(1003, 'Elif Demir', 'Yönetim Bilişim Sistemleri', 1, 3.70, 'Ankara'),
(1004, 'Can Aydın', 'Yönetim Bilişim Sistemleri', 3, 2.95, 'İstanbul'),
(1005, 'Zeynep Şahin', 'İşletme', 2, 3.10, 'Trabzon'),
(1006, 'Ali Çelik', 'Yönetim Bilişim Sistemleri', 4, 2.20, 'Gümüşhane'),
(1007, 'Ece Arslan', 'Yönetim Bilişim Sistemleri', 2, 3.85, 'Ankara'),
(1008, 'Burak Koç', 'İşletme', 1, 2.65, 'İstanbul');


-- Görev(1): OGRENCILER, tablosundaki tüm öğrencileri görüntüleyen SQL sorgusunu yazın.
SELECT * FROM OGRENCILER;

-- Görev(2): Yalnızca "AD_SOYAD" ve "BOLUM" bilgilerini görüntüleyen SQL sorgusunu yazın.
SELECT AD_SOYAD, BOLUM FROM OGRENCILER;

-- Görev(3): "Yönetim Bilişim Sistemleri" bölümünde öğrenim gören öğrencileri görüntüleyen SQL sorgusunu yazın.
SELECT * FROM OGRENCILER WHERE BOLUM = 'Yönetim Bilişim Sistemleri';

-- Görev(4): 2. sınıfta öğrenim gören öğrencileri görüntüleyen SQL sorgusunu yazın.
SELECT * FROM OGRENCILER WHERE SINIF = 2;

-- Görev(5): "NOT_ORTALAMASI", 3 (üç)'ün üzerinde olan öğrencileri görüntüleyen SQL sorgusunu yazın.
SELECT * FROM OGRENCILER WHERE NOT_ORTALAMASI > 3;

-- Görev(6): "Trabzon'da" öğrenim gören öğrencileri görüntüleyen SQL sorgusunu yazın.
SELECT * FROM OGRENCILER WHERE SEHIR = 'Trabzon';

-- Görev(7): 1004 (bin dört) numaraları öğrenciyi görüntüleyen SQL sorgusunu yazın.
SELECT * FROM OGRENCILER WHERE OGRENCI_NO = 1004;

-- Görev(8): "OGRENCILER", tablosuna öğrencilerin 'e-posta' bilgisini tutabilmesi için "E_MAIL" adında yeni bir sütun ekleyen SQL sorgusunu yazın.
ALTER TABLE OGRENCILER ADD E_MAIL NVARCHAR (50);

-- Görev(9): "OGRENCILER", tablosuna öğrencilerin 'telefon numarası' bilgisini tutabilmesi için "TEL_NO" adında yeni bir sütun ekleyen SQL sorgusunu yazın.
ALTER TABLE OGRENCILER ADD TEL_NO INT;

-- Görev(10): (80'ler aradı telefonlarını geri istiyorlar...) "TEL_NO" sütununu kaldıran SQL sorgusunu yazın.
ALTER TABLE OGRENCILER DROP COLUMN TEL_NO;

-- Görev(11): (Valilerden yoğun eleştiri...) "SEHIR" sütununun daha açıklayıcı olması için adını "IKAMET_SEHRI" olarak değiştiren SQL sorgusunu yazın.
EXEC sp_rename 'OGRENCILER.SEHIR', 'IKAMET_SEHRI', 'COLUMN';

-- Görev(12): (Tersten penaltı...) Tüm değişiklikleri görüntüleyen SQL sorgusunu yazın.
SELECT * FROM OGRENCILER;


/*
Çalışanlar açlık grevine başladı. Üniversite yönetimi tarafından görevlendirildiniz.
Grev bitene kadar sizden 3 (üç) önemli görevi yerine getirmeniz isteniyor.
*/

-- Görev[1]: Not ortalaması "2.50" altındaki öğrenciler,
-- Görev[2]: 4. sınıfta okuyan öğrenciler,
-- Görev[3]: "Ankara'da" ikamet eden öğrenciler.

-- [1]
SELECT * FROM OGRENCILER WHERE NOT_ORTALAMASI < 2.50;

-- [2]
SELECT * FROM OGRENCILER WHERE SINIF = 4;

-- [3]
SELECT * FROM OGRENCILER WHERE IKAMET_SEHRI = 'Ankara';
