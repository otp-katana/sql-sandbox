# 📘 T-SQL Başucu Kitabı: Cilt 1 — Mimari (DDL) ve Veri Manipülasyonu (DML)

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![T-SQL](https://img.shields.io/badge/T--SQL-005C84?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Handbook](https://img.shields.io/badge/Reference_Book-8A2BE2?style=for-the-badge&logo=gitbook&logoColor=white)

Bu belge, ilişkisel veritabanı yönetim sistemlerinde (RDBMS) kullanılan **DDL (Veri Tanımlama Dili)** ve **DML (Veri İşleme Dili)** komutlarının tamamını; ana mantıkları, hafıza teknikleri, endüstri standartları ve sınav tuzaklarıyla birlikte açıklayan kapsamlı bir mühendislik rehberidir.

---

## 🧠 Zihinsel Model: DDL ve DML Farkı Nasıl Akılda Tutulur?

Bir veritabanını **inşa edilen bir apartman** olarak hayal edin:
* **🏗️ DDL (Data Definition Language - Veri Tanımlama Dili):** İnşaat mühendisidir. Binanın kolonlarını diker, odaları yapar (`CREATE`), duvarı yıkıp odayı genişletir (`ALTER`), binayı tamamen yıkar (`DROP`) veya binanın içindeki tüm eşyaları tek tuşla buharlaştırıp daireyi sıfırlar (`TRUNCATE`). **DDL, verinin kendisiyle değil, verinin yaşayacağı İSKELET ile ilgilenir.**
* **💉 DML (Data Manipulation Language - Veri İşleme Dili):** Nakliye şirketi ve ev sahibidir. Dairelerin içine yeni eşyalar/kiracılar taşır (`INSERT`), mevcut eşyaların yerini veya rengini değiştirir (`UPDATE`), eskiyen eşyaları çöpe atar (`DELETE`). **DML, binanın duvarlarına dokunmaz; sadece içerideki VERİ ile ilgilenir.**

---

# BÖLÜM 1: 🏗️ DDL (Data Definition Language) — Mimari Komutlar

DDL komutları çalıştırıldığı anda veritabanı yapısını kalıcı olarak değiştirir (Auto-Commit).

## 1. `CREATE` (İnşa Etmek)
* **Amacı:** Veritabanında sıfırdan yeni bir nesne (Veritabanı, Tablo, İndeks, Görünüm vb.) oluşturmak.
* **Akılda Tutma Tekniği:** İngilizce "Yaratmak/Oluşturmak". Boş bir arsaya sıfırdan temel atmak.
* **Nerede ve Neyle Kullanılır?** Proje başlangıçlarında `DATABASE` veya `TABLE` anahtar kelimeleri, sütun veri tipleri ve kısıtlayıcılarla (Constraints) birlikte kullanılır.
* **Sözdizimi (Syntax) ve Örnek:**
```sql
-- 1. Veritabanı oluşturma
CREATE DATABASE Sirket_DB;
GO

-- 2. Tablo oluşturma (Tam donanımlı endüstri standardı)
CREATE TABLE PERSONEL (
    PERSONEL_ID INT PRIMARY KEY IDENTITY(1,1),
    TC_NO CHAR(11) UNIQUE NOT NULL,
    AD_SOYAD NVARCHAR(60) NOT NULL,
    MAAS DECIMAL(10,2) DEFAULT 17002.00 CHECK (MAAS > 0),
    ISE_GIRIS_TARIHI DATETIME DEFAULT GETDATE(),
    AKTIF_MI BIT DEFAULT 1
);
```

---

## 2. `ALTER` (Tadilat Yapmak)
* **Amacı:** Mevcut bir tablonun içindeki **verileri kaybetmeden** yapısını (şemasını) değiştirmek, yeni sütun eklemek, silmek veya veri tipini güncellemek.
* **Akılda Tutma Tekniği:** "Alternatif üretmek / Değiştirmek". Evin içindeki kiracıyı sokağa atmadan balkonu odaya katmak.
* **Alt Komutları ve Kullanımları:**
  * **`ALTER TABLE ... ADD`**: Tabloya yeni bir sütun veya kural (Constraint) ekler.
  * **`ALTER TABLE ... ALTER COLUMN`**: Mevcut bir sütunun veri tipini veya boyutunu değiştirir.
  * **`ALTER TABLE ... DROP COLUMN`**: Tablodan bir sütunu (ve içindeki veriyi) kalıcı olarak koparıp atar.

* **Sözdizimi (Syntax) ve Örnek:**
```sql
-- 1. Yeni sütun ekleme (ADD)
ALTER TABLE PERSONEL 
ADD DEPARTMAN NVARCHAR(30);

-- 2. Mevcut sütunun kapasitesini ve kuralını değiştirme (ALTER COLUMN)
ALTER TABLE PERSONEL 
ALTER COLUMN DEPARTMAN NVARCHAR(50) NOT NULL;

-- 3. Gereksiz sütunu tablodan silme (DROP COLUMN)
ALTER TABLE PERSONEL 
DROP COLUMN ISE_GIRIS_TARIHI;
```
> ⚠️ **Mühendislik & Sınav Uyarısı:** Dolu bir tabloda `ALTER COLUMN` ile veri boyutu küçültülürken (örn: `NVARCHAR(50)` -> `NVARCHAR(10)`), içeride 10 karakterden uzun tek bir kayıt bile varsa SQL `"String or binary data would be truncated"` hatası verir ve işlemi iptal eder. Ayrıca MySQL/Oracle'da kullanılan `MODIFY COLUMN` komutu T-SQL'de (SQL Server) **geçersizdir**, doğrusu `ALTER COLUMN`'dur.

---

## 3. `DROP` (Temelden Yıkmak)
* **Amacı:** Bir veritabanını veya tabloyu, içindeki tüm verilerle, indekslerle ve kurallarla birlikte sistemden tamamen yok etmek.
* **Akılda Tutma Tekniği:** "Drop the mic (Mikrofonu bırak/at)". Binaya dinamit döşeyip haritadan silmek.
* **Sözdizimi (Syntax) ve Örnek:**
```sql
-- Klasik yıkım (Tablo yoksa hata verir)
DROP TABLE PERSONEL;

-- Modern Endüstri Standardı (SQL Server 2016+): Varsa yık, yoksa hata verme!
DROP TABLE IF EXISTS PERSONEL;
```
> ⚠️ **Sınav Tuzağı:** Sınavda *"Tablodaki tüm müşteri kayıtlarını silin"* dendiğinde `DROP TABLE` yazarsanız tabloyu da yok ettiğiniz için **0 puan** alırsınız. Kayıt silmek DML (`DELETE` / `TRUNCATE`) işidir; `DROP` ise tablonun kendisini yok eder.

---

## 4. `TRUNCATE` (Fabrika Ayarlarına Döndürmek)
* **Amacı:** Tablonun iskeletine (sütunlarına) dokunmadan, içerisindeki **tüm satırları** tek bir hamlede, log (kayıt) tutmadan ultra hızlı bir şekilde boşaltmak ve otomatik artan sayacı (`IDENTITY`) sıfırlamak.
* **Akılda Tutma Tekniği:** "Format atmak". Apartmanın duvarları yerinde kalır ama tüm daireler aynı anda boşaltılıp ilk günkü sıfır haline döner.
* **Nerede Kullanılır?** Test ortamlarında sahte verileri temizleyip ID sayacını tekrar `1`'den başlatmak gerektiğinde kullanılır. **Asla `WHERE` koşulu alamaz!** (Ya hep ya hiç mantığıyla çalışır).
* **Sözdizimi (Syntax) ve Örnek:**
```sql
TRUNCATE TABLE PERSONEL;
```

---

## 5. `EXEC sp_rename` (Tabela Değiştirmek)
* **Amacı:** SQL Server'da mevcut bir tablonun veya sütunun adını değiştirmek.
* **Akılda Tutma Tekniği:** SQL Server'da `ALTER` komutu isim değiştiremez. Bunun için sistemde kayıtlı özel bir yardımcı program (`sp_rename` - Stored Procedure) çağrılır (`EXEC`).
* **Sözdizimi (Syntax) ve Örnek:**
```sql
-- Sütun adı değiştirme: EXEC sp_rename 'TabloAdi.EskiSutunAdi', 'YeniSutunAdi', 'COLUMN';
EXEC sp_rename 'PERSONEL.AD_SOYAD', 'TAM_AD', 'COLUMN';

-- Tablo adı değiştirme:
EXEC sp_rename 'PERSONEL', 'CALISANLAR';
```

---

## 🛡️ DDL'in Omurgası: Kısıtlayıcılar (Constraints) ve Veri Tipleri

Tablo oluştururken (`CREATE`) veya güncellerken (`ALTER`) verinin kalitesini ve güvenliğini koruyan kurallara **Constraint (Kısıtlayıcı)** denir. Sınavlarda klasik kod yazma sorularının kalbidir:

| Kısıtlayıcı (Constraint) | Amacı ve Ana Mantığı | Akılda Tutma Tekniği | Örnek Kullanım |
| :--- | :--- | :--- | :--- |
| **`PRIMARY KEY`** | Satırı benzersiz kılar. Tekrar edemez ve boş (`NULL`) bırakılamaz. Bir tabloda sadece 1 tane olur. | TC Kimlik Numarası / Parmak İzi. | `ID INT PRIMARY KEY` |
| **`IDENTITY(x,y)`** | Sütuna manuel veri girilmesini engeller; `x`'ten başlayıp `y` kadar otomatik artırır. | Sıramatik fişi. | `ID INT IDENTITY(1,1)` |
| **`FOREIGN KEY`** | Başka bir tablonun `PRIMARY KEY`'ine bağlanarak tablolar arası ilişki kurar. | Evlilik cüzdanı (İki tabloyu birbirine bağlar). | `BOLUM_ID INT FOREIGN KEY REFERENCES BOLUMLER(ID)` |
| **`NOT NULL`** | O sütunun boş geçilmesini yasaklar. Veri girilmesi zorunludur. | Web formlarındaki kırmızı yıldızlı (*) zorunlu alan. | `AD NVARCHAR(50) NOT NULL` |
| **`UNIQUE`** | Sütundaki verinin tekrar etmesini engeller (Ancak Primary Key'den farklı olarak tabloda birden fazla Unique sütun olabilir). | Cep telefonu veya E-Posta adresi (Herkeste farklıdır). | `EPOSTA VARCHAR(100) UNIQUE` |
| **`CHECK`** | Sütuna girilecek veriyi mantıksal bir şarta bağlar. Şart sağlanmazsa veriyi reddeder. | Gece kulübü kapısındaki yaş kontrolü (Bodyguard). | `YAS INT CHECK (YAS >= 18)` |
| **`DEFAULT`** | Veri eklenirken o sütun boş bırakılırsa, SQL'in otomatik olarak atayacağı varsayılan değerdir. | Fabrika çıkışı telefon duvar kağıdı. | `AKTIF BIT DEFAULT 1` |

### 📌 Kritik T-SQL Veri Tipleri Seçim Rehberi
* **Tam Sayılar:** `BIT` (0 veya 1 - Boolean) < `TINYINT` (0-255 arası, yaş vb. için) < `SMALLINT` (-32bin / +32bin) < `INT` (Standart tam sayı, ±2 Milyar) < `BIGINT` (Milyarlarca satırlık log tabloları için).
* **Ondalıklı / Finansal Sayılar:** **`DECIMAL(p, s)`** (Örn: `DECIMAL(10,2)` -> Toplam 10 basamak, 2'si virgülden sonra). *Finansal verilerde küsurat hatası yaptığı için `FLOAT` kullanmak Anti-Pattern'dir!*
* **Metinler:**
  * `CHAR(10)`: Sabit uzunluk. `'Ali'` yazsanız bile hafızada 10 karakterlik yer kaplar (TC No, Plaka Kodu gibi uzunluğu sabit verilerde çok hızlıdır).
  * `VARCHAR(50)`: Değişken uzunluk. `'Ali'` yazarsanız sadece 3 karakter yer kaplar.
  * `NVARCHAR(50)`: **Unicode** destekli değişken uzunluk. Türkçe, Arapça, Japonca karakterlerin (`ş, ğ, İ, ö`) bozulmaması için endüstri standardıdır.
* **Zaman:** `DATE` (Sadece YYYY-AA-GG), `TIME` (Sadece Saat), `DATETIME` (Tarih + Saat).

---

# BÖLÜM 2: 💉 DML (Data Manipulation Language) — Veri İşleme Komutları

DML komutları tablonun içindeki verilerle (satırlarla) oynar.

## 1. `INSERT` (Veri Enjekte Etmek)
* **Amacı:** Tabloya bir veya birden fazla yeni kayıt (satır) eklemek.
* **Akılda Tutma Tekniği:** "Insert coin (Jeton atmak)". Sisteme dışarıdan yeni bir varlık sokmak.
* **Kullanım Varyasyonları:**

### A) Standart ve Çoklu Ekleme (`INSERT INTO ... VALUES`)
```sql
-- Tek satır veya virgülle ayrılmış çoklu satır ekleme (En yaygın kullanım)
INSERT INTO URUNLER (URUN_ADI, KATEGORI, FIYAT, STOK)
VALUES 
    ('Mekanik Klavye', 'Elektronik', 2500.00, 15),
    ('Oyuncu Mouse', 'Elektronik', 1200.50, 30),
    ('Ofis Koltuğu', 'Mobilya', 5400.00, 5);
```
> ⚠️ **IDENTITY Kuralı:** `IDENTITY(1,1)` özelliğine sahip bir `ID` sütunu, `INSERT INTO` parantezinin içine **kesinlikle yazılmaz!** (İstisnai olarak eski bir ID'yi zorla eklemek gerekirse `SET IDENTITY_INSERT TABLO_ADI ON;` komutu kullanılır).

### B) Tablodan Tabloya Veri Aktarımı (`INSERT INTO ... SELECT`)
Mevcut bir tablodaki verileri filtreleyip başka bir mevcut tabloya saniyeler içinde kopyalar (`VALUES` kelimesi kullanılmaz!):
```sql
INSERT INTO PASIF_KULLANICILAR (AD, SOYAD, KAYIT_TARIHI)
SELECT AD, SOYAD, KAYIT_TARIHI 
FROM KULLANICILAR 
WHERE AKTIF_MI = 0;
```

### C) Yedekleme ve Klonlama (`SELECT ... INTO`) — *Hayat Kurtaran Taktik*
Daha önce **var olmayan** yeni bir tabloyu otomatik oluşturur ve seçilen verileri içine kopyalar (Hem DDL hem DML özelliği taşır). Tehlikeli bir `UPDATE` veya `DELETE` yapmadan önce tabloyu yedeklemek için birebirdir:
```sql
-- URUNLER tablosunun birebir kopyasını 'URUNLER_YEDEK' adıyla oluşturur ve verileri içine basar:
SELECT * INTO URUNLER_YEDEK 
FROM URUNLER;
```

---

## 2. `UPDATE` (Veri Güncellemek)
* **Amacı:** Tabloda halihazırda var olan satırların bir veya birden fazla sütunundaki değerleri değiştirmek.
* **Akılda Tutma Tekniği:** Telefona gelen güncelleme. Telefon (satır) aynı kalır ama içindeki özellikler (`SET`) yenilenir.
* **Altın Bileşenleri:**
  * `UPDATE [Tablo]`: Hangi tabloda çalışılacak?
  * `SET [Sütun = YeniDeğer]`: Hangi hücre nasıl değişecek? (Birden fazla sütun **virgül `,`** ile ayrılır).
  * `WHERE [Koşul]`: **HAYATİ FİLTRE!** Hangi satırlar bu güncellemeden etkilenecek?

* **Sözdizimi (Syntax) ve Örnekler:**
```sql
-- 1. Dinamik Matematik ve Çoklu Sütun Güncelleme (Senior Yaklaşım)
-- Elektronik ürünlerine %20 zam yap VE stoklarını 5'er adet artır:
UPDATE URUNLER
SET FIYAT = FIYAT * 1.20, 
    STOK = STOK + 5
WHERE KATEGORI = 'Elektronik';

-- 2. Sabit Değer Atama
UPDATE KULLANICILAR
SET AKTIF_MI = 0
WHERE KULLANICI_ID = 42;
```
> 🚨 **Felaket Senaryosu:** Eğer `WHERE` satırını yazmayı unutursanız, SQL hiçbir hata vermez ve tablodaki **10 milyon kaydın tamamını** aynı değere eşitler!

---

## 3. `DELETE` (Hedefli Veri Silmek)
* **Amacı:** Tablodaki belirli şartları sağlayan satırları (kayıtları) silmek.
* **Akılda Tutma Tekniği:** Cımbızla istenmeyen otları yolmak.
* **Nerede Kullanılır?** `WHERE` koşulu ile birlikte spesifik kayıtları (banlanan oyuncular, iptal edilen siparişler vb.) temizlemek için kullanılır. Sütun adı almaz, doğrudan satırın tamamını siler (`DELETE AD FROM TABLO` diye bir kullanım **yoktur**, doğrusu `DELETE FROM TABLO`'dur).
* **Sözdizimi (Syntax) ve Örnek:**
```sql
-- Stoğu bitmiş VE fiyatı 100 TL'nin altında olan ürünleri sistemden sil:
DELETE FROM URUNLER
WHERE STOK = 0 AND FIYAT < 100;
```

---

## 4. İleri Seviye (Senior) DML Cephaneliği

Mülakatlarda ve kurumsal projelerde standart komutların ötesine geçmek için kullanılan profesyonel araçlardır:

### A) `MERGE` (Upsert: Varsa Güncelle, Yoksa Ekle)
İki tabloyu (Örn: Ana Stok Tablosu ile Günlük Gelen Ürünler Tablosunu) karşılaştırır. Ürün ana tabloda zaten varsa stoğunu günceller (`UPDATE`), yoksa yeni ürün olarak ekler (`INSERT`). Tek sorguda tüm senkronizasyonu çözer:
```sql
MERGE INTO ANA_URUNLER AS Hedef
USING YENI_GELENLER AS Kaynak
ON (Hedef.URUN_ID = Kaynak.URUN_ID)
WHEN MATCHED THEN
    UPDATE SET Hedef.STOK = Hedef.STOK + Kaynak.STOK
WHEN NOT MATCHED THEN
    INSERT (URUN_ADI, FIYAT, STOK) VALUES (Kaynak.URUN_ADI, Kaynak.FIYAT, Kaynak.STOK);
```

### B) `OUTPUT` (İşlem Raporu Alma)
Bir `INSERT`, `UPDATE` veya `DELETE` işlemi yaptığınızda, etkilenen satırların **eski (`deleted`)** ve **yeni (`inserted`)** hallerini anında ekrana basar. *"Acaba yanlışlıkla kimi sildim?"* veya *"Yeni eklenen kayda hangi ID atandı?"* sorularının cevabıdır:
```sql
-- Fiyatı güncellerken, ürünün eski fiyatını ve yeni fiyatını aynı anda ekranda göster:
UPDATE URUNLER
SET FIYAT = FIYAT + 500
OUTPUT inserted.URUN_ADI, deleted.FIYAT AS EskiFiyat, inserted.FIYAT AS YeniFiyat
WHERE KATEGORI = 'Giyim';
```

### C) `BULK INSERT` (Yığın Veri Yükleme)
Dışarıdaki bir `.csv` veya `.txt` dosyasındaki yüz binlerce satırı saniyeler içinde tabloya aktarır:
```sql
BULK INSERT MUSTERILER
FROM 'C:\Veriler\musteri_listesi.csv'
WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');
```

---

# ⚔️ Büyük Karşılaştırma: `DELETE` vs `TRUNCATE` vs `DROP`
*(Vize ve Final Sınavlarının Banko Klasik Sorusu)*

| Özellik | `DELETE` | `TRUNCATE` | `DROP` |
| :--- | :--- | :--- | :--- |
| **Dil Ailesi (Kategori)** | **DML** (Veri İşleme) | **DDL** (Veri Tanımlama) | **DDL** (Veri Tanımlama) |
| **Ne Yapar?** | Seçilen satırları tek tek siler. | Tablodaki **tüm satırları** tek hamlede boşaltır. | Tabloyu **iskeletiyle birlikte** tamamen yok eder. |
| **`WHERE` Koşulu Alır mı?** | ✅ **Evet** (Filtreleme yapılabilir). | ❌ **Hayır** (Tüm tabloyu temizler). | ❌ **Hayır** (Tabloyu uçurur). |
| **`IDENTITY` (Sayaç) Ne Olur?** | Kaldığı yerden devam eder (Sıfırlanmaz). | **Sıfırlanır** (Başlangıç değerine, örn: 1'e döner). | Tablo yok olduğu için sayaç da yok olur. |
| **Hız ve Performans** | Yavaştır (Her satırı Transaction Log'a yazar). | **Çok Hızlıdır** (Sayfa bazlı siler, minimal log tutar). | **Anındadır** (Yapıyı doğrudan kaldırır). |
| **Tablo Yapısı Kalır mı?** | ✅ Kalır. | ✅ Kalır. | ❌ **Yok olur.** |

---

# 🛑 Altın Güvenlik Çemberi: `BEGIN TRAN` / `ROLLBACK` / `COMMIT`

Teknik olarak **TCL (Transaction Control Language)** ailesine ait olsa da, profesyonel bir mühendis tehlikeli bir DML (`UPDATE` / `DELETE`) komutu yazarken bu güvenlik kemerini mutlaka kullanır:

```sql
BEGIN TRANSACTION; -- 1. Güvenli alanı (kum havuzunu) başlat.

DELETE FROM KULLANICILAR WHERE AKTIF_MI = 0; -- 2. Silme işlemini yap ve kaç satır etkilendiğine bak.

-- Eğer yanlışlıkla tüm tabloyu sildiysen panik yapma, zamanı geri sar:
ROLLBACK TRANSACTION; 

-- Eğer her şey doğruysa işlemi kalıcı olarak mühürle:
COMMIT TRANSACTION;
```

---
*📖 **Cilt 2 (DQL - Veri Sorgulama Dili):** `SELECT`, `JOIN`, `GROUP BY`, `HAVING`, Alt Sorgular (Subqueries) ve Pencere Fonksiyonları (Window Functions) 7. ve 8. hafta modüllerinde bu kütüphaneye eklenecektir.*