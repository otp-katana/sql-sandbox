CREATE TABLE OGRENCI_BILGI_SISTEMI (
	OGRENCI_ID INT,
	AD NVARCHAR (50),
	SOYAD NVARCHAR (50),
	BOLUM NVARCHAR (60),
	SINIF INT,
	NOT_ORTALAMASI DECIMAL (3,2),
	KAYIT_DURUMU NVARCHAR (15)
);

INSERT INTO OGRENCI_BILGI_SISTEMI (
	OGRENCI_ID,
	AD,
	SOYAD,
	BOLUM,
	SINIF,
	NOT_ORTALAMASI,
	KAYIT_DURUMU
)
VALUES
(101, 'Ayşe', 'Yılmaz', 'Yönetim Bilişim Sistemleri', 2, 3.25, 'Aktif'),
(102, 'Mehmet', 'Demir', 'İşletme', 1, 2.80, 'Aktif'),
(103, 'Zeynep', 'Kaya', 'Yönetim Bilişim Sistemleri', 3, 3.90, 'Aktif'),
(104, 'Ali', 'Çelik', 'İktisat', 2, 2.15, 'Aktif'),
(105, 'Elif', 'Şahin', 'Yönetim Bilişim Sistemleri', 1, 3.20, 'Aktif'),
(106, 'Burak', 'Arslan', 'İşletme', 4, 1.95, 'Aktif');


--Görev[1]: Rektörlük, vizyondaki en başarılı öğrencileri görmek istiyor.
/*
'Yönetim Bilişim Sistemleri' bölümünde okuyan, kayıt durumu 'Aktif' ve
not ortalaması '3.00'ün üzerinde olan öğrencilerin tüm bilgilerini getiren
bir sorgu yaz.
*/

SELECT * FROM OGRENCI_BILGI_SISTEMI
WHERE BOLUM = 'Yönetim Bilişim Sistemleri' AND KAYIT_DURUMU = 'Aktif' AND NOT_ORTALAMASI > 3;


--Görev[2]: Yıl sonu geldi ve sistemden sınıf atlatma operasyonu yapman gerekiyor.
/*
'Yönetim Bilişim Sistemleri' bölümünde okuyan ve şu an '3.' sınıfta okuyan tüm öğrencilerin
sınıf bilgisini '4' olarak güncelleyen bir sorgu yaz.
*/

UPDATE OGRENCI_BILGI_SISTEMI
SET SINIF = 4
WHERE BOLUM = 'Yönetim Bilişim Sistemleri' AND SINIF = 3;


--Görev[3]: Dekanlık ödül töreni için okulun en iyi öğrencilerini sahneye çağıracak.
/*
Üniversitedik en yüksek 'Not Ortalamasına' sahip ilk 3 öğrencinin sadece 'Ad', 'Soyad' ve
'Not Ortalaması' bilgierini, notu en yüksekten en düşüğe doğru sıralı şekilde listeleyen
sql sorgusunu yaz.
*/

SELECT TOP 3 AD, SOYAD, NOT_ORTALAMASI FROM OGRENCI_BILGI_SISTEMI
ORDER BY NOT_ORTALAMASI DESC;


--Görev[4]: Öğrenci işleri, sisteme öğrenmcilerin burs durumunu da eklemeye karar verdi.
/*
Tabloya 'BURSLU_MU' adında 'BIT' veya 'VARCHAR' tipinde yeni bir sütun ekle.
Ardından, 'Not Ortalaması' 3.50 ve üzeri olan tüm öğrencilerin 'BURSLU_MU' durumunu 1 olarak güncelle.
*/

ALTER TABLE OGRENCI_BILGI_SISTEMI
ADD BURSLU_MU BIT;

UPDATE OGRENCI_BILGI_SISTEMI
SET BURSLU_MU = 1
WHERE NOT_ORTALAMASI >= 3.50;

SELECT * FROM OGRENCI_BILGI_SISTEMI


--Görev[5]: Okula taya geçişle yeni bir öğrenci geldi.
/*
Yeni öğrencinin bilgierini tabloya gir.
'Yönetim Bilişim Sistemleri' öğrencisi, 2. 'Sınıf', 'Abuziddin Bızdık'.
*/

INSERT INTO OGRENCI_BILGI_SISTEMI (
	OGRENCI_ID,
	AD,
	SOYAD,
	BOLUM,
	SINIF,
	NOT_ORTALAMASI,
	KAYIT_DURUMU
)
VALUES
(107, 'Abuziddin', 'Bızdık', 'Yönetim Bilişim Sistemleri', 2, 0.00, 'Aktif');

SELECT * FROM OGRENCI_BILGI_SISTEMI