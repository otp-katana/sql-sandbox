# 🛒 E-Ticaret Veritabanı Mimarisi & SQL Çalışma Rehberi

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![T-SQL](https://img.shields.io/badge/T--SQL-005C84?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Study Guide](https://img.shields.io/badge/Exam_Prep-10B981?style=for-the-badge&logo=bookmeter&logoColor=white)

Bu proje, bir e-ticaret sisteminin temel veritabanı altyapısının kurulması, güncellenmesi ve yönetilmesi süreçlerini simüle eder[cite: 22]. **Bu belge, hem yeni 5 aşamalı mimarimizi yansıtan profesyonel bir portfolyo şablonu hem de yaklaşan veritabanı vize sınavı için kapsamlı bir tekrar ve referans kaynağı olarak tasarlanmıştır**[cite: 22].

## 📂 Proje Klasör Yapısı (Separation of Concerns)
Kodlar, profesyonel bir veri mühendisliği yaklaşımıyla işlevlerine göre modüler dosyalara ayrılmıştır[cite: 22]:
* `01_ddl_init.sql` -> Veritabanı ve temel tablo mimarilerinin oluşturulması (`CREATE`).
* `02_ddl_alter.sql` -> Tablo şeması güncellemeleri (`ALTER`).
* `03_dml_insert.sql` -> Başlangıç verilerinin enjeksiyonu (`INSERT`).
* `04_dml_operations.sql` -> Günlük operasyonlar, güncellemeler ve silmeler (`UPDATE`, `DELETE`).
* `05_dql_reports.sql` -> Analiz ve filtreleme sorguları (`SELECT`).

---

## 🛠️ FAZ 1: Mimari Kurulum (DDL - Data Definition Language)
Bu aşamada verilerin saklanacağı evleri (tabloları) inşa ettik[cite: 22]. Tablo oluştururken en önemli karar veri tipleridir[cite: 22].

* **`INT PRIMARY KEY IDENTITY(1,1)`**: Her kaydın benzersiz bir TC Kimlik no'su gibi bir ID'si olmalı (`PRIMARY KEY`)[cite: 22]. `IDENTITY(1,1)` ise "1'den başla, 1'er 1'er otomatik art" demektir[cite: 22]. Böylece manuel ID girme zahmetinden ve hatalarından kurtulduk[cite: 22].
* **`NVARCHAR(n)` vs `VARCHAR(n)`**: Başındaki 'N' (National) harfi Unicode desteği sağlar[cite: 22]. Türkçe karakterleri (ş, ğ, ç, ö) veritabanında bozmadan saklamak için ad, soyad gibi alanlarda `NVARCHAR` kullandık[cite: 22]. Yabancı karakter içermeyen e-posta gibi alanlarda `VARCHAR` yeterlidir[cite: 22].
* **`DECIMAL(10,2)`**: Para birimleri için `FLOAT` kullanılamaz çünkü küsuratlarda yuvarlama hataları yapar[cite: 22]. `DECIMAL(10,2)` "Toplam 10 basamaklı sayı, bunun 2 basamağı virgülden sonra" anlamına gelir[cite: 22]. Kuruşlu fiyatlar için kusursuzdur[cite: 22].
* **`DATETIME`**: Tarih ve saat bilgisini aynı anda tutmak için[cite: 22].

---

## 🏗️ FAZ 2: Çevik Revizyonlar (ALTER Operasyonları)
Canlıdaki bir tabloyu silip (`DROP`) baştan yaratmak içindeki tüm veriyi yok eder[cite: 22]. Bunun yerine tablo iskeletini `ALTER` ile esnettik[cite: 22].

* **Sütun Ekleme:** `ALTER TABLE KULLANICILAR ADD AktifMi BIT;`[cite: 22]
  * *Neden BIT?* Kullanıcının aktif olup olmaması bir "Evet/Hayır" (True/False) durumudur[cite: 22]. Veritabanındaki en küçük veri tipi olan `BIT` (Sadece 1 veya 0 alır), bu durumlar için performansı maksimize eder[cite: 22].
* **Sütun Silme:** `ALTER TABLE KULLANICILAR DROP COLUMN E_POSTA;`[cite: 22]
  * *Dikkat:* Bu komut, o sütunu ve içindeki *tüm verileri* kalıcı olarak siler[cite: 22]. Geri dönüşü yoktur[cite: 22].

---

## 💉 FAZ 3: Veri Ekleme (DML - Data Manipulation Language)
Sisteme veri beslediğimiz aşamadır[cite: 22].

### `INSERT INTO` ve IDENTITY Tuzağı
* ❌ **Hatalı Kullanım:** `INSERT INTO URUNLER VALUES ('Kazak', 'Giyim', 100, 5)`[cite: 22]
* ✅ **Doğru Kullanım:** `INSERT INTO URUNLER (URUN_ADI, URUN_GRUBU, FIYAT, STOK) VALUES ('Kazak', 'Giyim', 100, 5)`[cite: 22]
* *Neden Sütun İsimlerini Yazdık?* Eğer tabloda `IDENTITY` (otomatik artan ID) varsa, SQL motoruna "ID'yi sen ver, ben sadece şu sütunları dolduracağım" diyerek yol göstermek ZORUNDAYIZ[cite: 22]. Aksi takdirde SQL, verdiğimiz ilk değeri ('Kazak') ID sütununa sıkıştırmaya çalışır ve patlar[cite: 22].

---

## ⚙️ FAZ 4: Günlük Operasyonlar (Veri Manipülasyonu)
> **Altın Kural:** `WHERE` olmadan `UPDATE` KULLANILMAZ![cite: 22] Veritabanının en tehlikeli komutlarıdır[cite: 22]. Sınavda hocaların en çok puan kırdığı yer burasıdır[cite: 22].

* **Dinamik Matematik ile Güncelleme (`UPDATE`):**
  `UPDATE URUNLER SET FIYAT = FIYAT - 200 WHERE URUN_GRUBU = 'Giyim';`[cite: 22]
  * *Mantık:* Eğer sadece `SET FIYAT = 200` deseydik, tüm giyim ürünlerinin fiyatı sabit 200 TL olurdu[cite: 22]. Biz mevcut değerin üzerinden dinamik bir eksiltme yaptık[cite: 22].
* **Nokta Atışı Silme (`DELETE`):**
  `DELETE FROM KULLANICILAR WHERE AktifMi = 0 AND AD = 'X';`[cite: 22]
  * *Mantık:* Nokta atışı hedef belirlemek için koşulları daralttık[cite: 22]. Sadece `AktifMi = 0` deseydik masum kullanıcıları, sadece `AD = 'X'` deseydik aktif bir X kullanıcısını silerdik[cite: 22].

---

## 📊 FAZ 5: Raporlama ve Analiz (DQL - Data Query Language)
Veriyi okuma sanatıdır[cite: 22].

* **Çoklu Koşul Filtrelemesi (`WHERE ... OR`):**
  `SELECT * FROM URUNLER WHERE STOK < 10 OR FIYAT > 10000;`[cite: 22]
  * *Mantık:* Her iki koşuldan SADECE BİRİNİN sağlanması satırın rapora girmesi için yeterlidir[cite: 22]. Riskli (stoku az) veya değerli (fiyatı çok) ürünleri tek potada erittik[cite: 22].
* **Sıralama ve Sınırlandırma (`ORDER BY` ve `TOP`):**
  `SELECT TOP 3 URUN_ADI, FIYAT FROM URUNLER ORDER BY FIYAT DESC;`[cite: 22]
  * *İşlem Sırası:* SQL motoru önce tüm ürünleri bulur[cite: 22]. Sonra `ORDER BY FIYAT DESC` ile bunları en yüksek fiyattan en düşüğe (Descending) doğru dizer[cite: 22]. En son `TOP 3` ile sadece en üstteki 3 satırı kesip getirir[cite: 22]. Vitrin raporlamalarının belkemiğidir[cite: 22].

---
## 🎯 Sınav İçin Son Hatırlatmalar
1. Metin (String) ve Tarih (Date) değerlerini mutlaka **TEK TIRNAK** (`'...'`) içine al[cite: 22].
2. Ondalıklı sayılarda virgül (`,`) değil, **nokta** (`.`) kullan[cite: 22].
3. `UPDATE` ve `DELETE` yazarken, kodu çalıştırmadan önce `WHERE` satırını yazdığını **3 kez kontrol et!**[cite: 22]