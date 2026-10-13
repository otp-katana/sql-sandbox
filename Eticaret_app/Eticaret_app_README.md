# 🛒 E-Ticaret Operasyon Merkezi - SQL Vize Çalışma Rehberi

Bu proje, bir e-ticaret sisteminin temel veritabanı altyapısının kurulması, güncellenmesi ve yönetilmesi süreçlerini simüle eder. **Bu belge, yaklaşan veritabanı vize sınavı için kapsamlı bir tekrar ve referans kaynağı olarak özel tasarlanmıştır.**

## 📂 Proje Klasör Yapısı (Separation of Concerns)
Kodlar, profesyonel bir veri mühendisliği yaklaşımıyla işlevlerine göre modüler dosyalara ayrılmıştır:
* `00_init_Eticaret_DB.sql` -> Veritabanı oluşturma.
* `kullanıcılar_tablo.sql` / `ürünler_tablo.sql` -> Temel tablo mimarileri (DDL).
* `tablo_modifikasyonları.sql` -> Tablo şeması güncellemeleri (DDL).
* `veri_ekleme.sql` -> Başlangıç verilerinin enjeksiyonu (DML).
* `veri_düzenleme.sql` -> Günlük operasyonlar, güncellemeler ve silmeler (DML).
* `veri_raporlama.sql` -> Analiz ve filtreleme sorguları (DQL).

---

## 🛠️ FAZ 1: Mimari Kurulum (DDL - Data Definition Language)

Bu aşamada verilerin saklanacağı evleri (tabloları) inşa ettik.

### `CREATE TABLE` Komutu ve Veri Tipleri
Tablo oluştururken en önemli karar veri tipleridir.
* **`INT PRIMARY KEY IDENTITY(1,1)`**: 
  * *Neden Kullandık?* Her kaydın benzersiz bir TC Kimlik no'su gibi bir ID'si olmalı (`PRIMARY KEY`). `IDENTITY(1,1)` ise "1'den başla, 1'er 1'er otomatik art" demektir. Böylece manuel ID girme zahmetinden ve hatalarından kurtulduk.
* **`NVARCHAR(n)` vs `VARCHAR(n)`**: 
  * *Neden NVARCHAR?* Başındaki 'N' (National) harfi Unicode desteği sağlar. Türkçe karakterleri (ş, ğ, ç, ö) veritabanında bozmadan saklamak için ad, soyad gibi alanlarda `NVARCHAR` kullandık. Yabancı karakter içermeyen e-posta gibi alanlarda `VARCHAR` yeterlidir.
* **`DECIMAL(10,2)`**:
  * *Neden FLOAT değil?* Para birimleri için `FLOAT` kullanılamaz çünkü küsuratlarda yuvarlama hataları yapar. `DECIMAL(10,2)` "Toplam 10 basamaklı sayı, bunun 2 basamağı virgülden sonra" anlamına gelir. Kuruşlu fiyatlar için kusursuzdur.
* **`DATETIME`**: Tarih ve saat bilgisini aynı anda tutmak için.

---

## 🏗️ FAZ 2: Çevik Revizyonlar (ALTER Operasyonları)

Canlıdaki bir tabloyu silip (`DROP`) baştan yaratmak içindeki tüm veriyi yok eder. Bunun yerine tablo iskeletini `ALTER` ile esnettik.

### `ALTER TABLE ... ADD`
* **Kullanım:** `ALTER TABLE KULLANICILAR ADD AktifMi BIT;`
* *Neden BIT?* Kullanıcının aktif olup olmaması bir "Evet/Hayır" (True/False) durumudur. Veritabanındaki en küçük veri tipi olan `BIT` (Sadece 1 veya 0 alır), bu durumlar için performansı maksimize eder.

### `ALTER TABLE ... DROP COLUMN`
* **Kullanım:** `ALTER TABLE KULLANICILAR DROP COLUMN E_POSTA;`
* *Dikkat:* Bu komut, o sütunu ve içindeki *tüm verileri* kalıcı olarak siler. Geri dönüşü yoktur.

---

## 💉 FAZ 3: Veri Ekleme (DML - Data Manipulation Language)

Sisteme veri beslediğimiz aşamadır.

### `INSERT INTO` ve IDENTITY Tuzağı
* **Hatalı Kullanım:** `INSERT INTO URUNLER VALUES ('Kazak', 'Giyim', 100, 5)`
* **Doğru Kullanım:** `INSERT INTO URUNLER (URUN_ADI, URUN_GRUBU, FIYAT, STOK) VALUES ('Kazak', 'Giyim', 100, 5)`
* *Neden Sütun İsimlerini Yazdık?* Eğer tabloda `IDENTITY` (otomatik artan ID) varsa, SQL motoruna "ID'yi sen ver, ben sadece şu sütunları dolduracağım" diyerek yol göstermek ZORUNDAYIZ. Aksi takdirde SQL, verdiğimiz ilk değeri ('Kazak') ID sütununa sıkıştırmaya çalışır ve patlar.

---

## ⚙️ FAZ 4: Günlük Operasyonlar (Veri Manipülasyonu)

Veritabanının en tehlikeli komutlarıdır. Sınavda hocaların en çok puan kırdığı yer burasıdır.

### `UPDATE ... SET` (Güncelleme)
* **Altın Kural:** `WHERE` olmadan `UPDATE` KULLANILMAZ!
* **Dinamik Matematik:** `UPDATE URUNLER SET FIYAT = FIYAT - 200 WHERE URUN_GRUBU = 'Giyim';`
  * *Neden `FIYAT = FIYAT - 200`?* Eğer sadece `SET FIYAT = 200` deseydik, tüm giyim ürünlerinin fiyatı sabit 200 TL olurdu. Biz mevcut değerin üzerinden dinamik bir eksiltme yaptık. Python'daki `fiyat -= 200` mantığı ile birebir aynıdır.

### `DELETE FROM` (Kayıt Silme)
* **Kullanım:** `DELETE FROM KULLANICILAR WHERE AktifMi = 0 AND AD = 'X';`
* *Neden AND kullandık?* Sadece `AktifMi = 0` deseydik, pasif olan masum kullanıcıları da silerdik. Sadece `AD = 'X'` deseydik, aktif bir X kullanıcısını silerdik. Nokta atışı hedef belirlemek için koşulları daralttık.

---

## 📊 FAZ 5: Raporlama ve Analiz (DQL - Data Query Language)

Veriyi okuma sanatıdır.

### Çoklu Koşul Filtrelemesi (`WHERE ... OR`)
* **Kullanım:** `SELECT * FROM URUNLER WHERE STOK < 10 OR FIYAT > 10000;`
* *Mantık:* Her iki koşuldan SADECE BİRİNİN sağlanması satırın rapora girmesi için yeterlidir. Riskli (stoku az) veya değerli (fiyatı çok) ürünleri tek potada erittik.

### Sıralama ve Sınırlandırma (`ORDER BY` ve `TOP`)
* **Kullanım:** `SELECT TOP 3 URUN_ADI, FIYAT FROM URUNLER ORDER BY FIYAT DESC;`
* *İşlem Sırası:* SQL motoru önce tüm ürünleri bulur. Sonra `ORDER BY FIYAT DESC` ile bunları en yüksek fiyattan en düşüğe (Descending) doğru dizer. En son `TOP 3` ile sadece en üstteki 3 satırı kesip getirir. Vitrin raporlamalarının belkemiğidir.

---
**🎯 Sınav İçin Son Hatırlatmalar:**
1. Metin (String) ve Tarih (Date) değerlerini mutlaka TEK TIRNAK (`'...'`) içine al.
2. Ondalıklı sayılarda virgül `,` değil, nokta `.` kullan.
3. `UPDATE` ve `DELETE` yazarken, kodu çalıştırmadan önce `WHERE` satırını yazdığını 3 kez kontrol et!