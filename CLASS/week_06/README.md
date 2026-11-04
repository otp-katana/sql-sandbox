# 🎫 Etkinlik ve Bilet Yönetimi (Event Ticketing DB) - SQL Çalışma Rehberi

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![T-SQL](https://img.shields.io/badge/T--SQL-005C84?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Study Guide](https://img.shields.io/badge/Exam_Prep-10B981?style=for-the-badge&logo=bookmeter&logoColor=white)

Bu proje, ulusal çapta organizasyonlar düzenleyen bir etkinlik ve biletleme platformunun (Eventbrite, Biletix benzeri) veritabanı altyapısını simüle eder. Kullanıcı kayıtları, etkinlik kapasite/fiyat yönetimleri, bilet satış operasyonları ve iade/iptal süreçlerini barındırır. 

Bu belge, **DDL (Veri Tanımlama)** ve **DML (Veri İşleme)** konularını vize öncesi pekiştirmek için laboratuvar senaryoları üzerinden hazırlanmıştır.

## 📂 Proje Klasör Yapısı (Separation of Concerns)

Kodlar, endüstri standardı olan modüler mimariye göre sınıflandırılmıştır:

* `01_ddl_init.sql` -> `KULLANICILAR`, `ETKINLIKLER` ve `BILETLER` tablolarının inşası (`CREATE`).
* `02_ddl_alter.sql` -> Unicode karakter desteği ve yeni iş kurallarının şemaya eklenmesi (`ALTER`).
* `03_dml_insert.sql` -> Örnek kullanıcı, etkinlik ve satış verilerinin sisteme enjeksiyonu (`INSERT`).
* `04_dml_operations.sql` -> Dinamik fiyat güncellemeleri, bilet iptalleri ve veri temizliği (`UPDATE`, `DELETE`).

---

## 🛠️ FAZ 1 & 2: Mimari Kurulum ve Çevik Revizyon (DDL)

### 1. `IDENTITY(1,1)` vs Manuel ID Ataması
Veritabanı tasarımında ID stratejisi verinin doğasına göre değişir:
* **Otomatik (Kullanıcılar & Biletler):** Müşterilere ve biletlere manuel ID vermek imkansızdır. Bu yüzden `BiletID INT PRIMARY KEY IDENTITY(1,1)` kullandık.
* **Manuel (Etkinlikler):** Organizatörler etkinlik kodlarını (Örn: 101, 102) özel olarak belirleyebilir. Bu tabloda `IDENTITY` KULLANMADIK; ID'leri kendimiz atadık.

### 2. Canlı Şema Revizyonu (`ALTER`)
* ❌ **Amatör Yaklaşım:** Türkçe karakterler (ş, ğ, ç) bozuk çıktığı için tabloyu `DROP` edip `NVARCHAR` ile baştan yaratmak (Tüm kullanıcı verisi silinir!).
* ✅ **Mühendislik Yaklaşımı:** İçerideki veriyi koruyarak tipi esnetmek: `ALTER TABLE KULLANICILAR ALTER COLUMN AdSoyad NVARCHAR(100);`

---

## 💉 FAZ 3: Veri Enjeksiyonu (DML)

* **IDENTITY Tuzağına Dikkat:** 
  * `KULLANICILAR` tablosuna veri eklerken `KullaniciID` sütununu yazmadık (SQL kendi verdi). 
  * `ETKINLIKLER` tablosuna veri eklerken `EtkinlikID` sütununu **özellikle belirttik** çünkü `IDENTITY` kullanmamıştık: `INSERT INTO ETKINLIKLER (EtkinlikID, EtkinlikAdi...) VALUES (101, ...)`

---

## ⚙️ FAZ 4: Günlük Operasyonlar ve İş Kuralları (DML)

### 1. Bölgesel Dinamik Fiyatlandırma (`UPDATE`)
Maliyet artışlarından dolayı sadece 'Ankara' şehrindeki etkinliklere **%15 zam** yapılması gerekti.
* **Kullanım:** `UPDATE ETKINLIKLER SET BiletFiyati = BiletFiyati * 1.15 WHERE Sehir = 'Ankara';`
* *Mantık:* Fiyatı manuel olarak hesaplayıp yazmak yerine (`SET BiletFiyati = 862.5`), mevcut değerin üzerine matematiksel bir çarpan ekledik.

### 2. Çoklu Kriterle İşlem İptali (`UPDATE` ile Soft Delete)
Bir kullanıcı biletini iptal ettiğinde satırı `DELETE` ile silmek, finansal raporları (şirketin o bileti ne zaman kime sattığı bilgisini) yok eder. 
* **Doğru Yaklaşım (Soft Delete):** Satırı silmek yerine durumunu güncelledik.
* **Kullanım:** `UPDATE BILETLER SET Durum = 'İptal', IadeTalebi = 1 WHERE KullaniciID = 3 AND EtkinlikID = 102;`

### 3. Hedefli Veri Temizliği (`DELETE`)
Yaşı 18'den küçük olan ve sisteme sızan test hesaplarını temizlemek için:
* **Kullanım:** `DELETE FROM KULLANICILAR WHERE Yas < 18;`

---

## 🎯 Sınav İçin Son Hatırlatmalar
1. Bir tablonun bir sütununa `IDENTITY` verilip verilmediğine dikkat edin. Verildiyse `INSERT` işleminde o sütunu atlayın.
2. `UPDATE` işlemlerinde zam/indirim yapıyorsanız işlemi mutlaka **matematiksel operatörlerle** (`Fiyat = Fiyat * 1.15` veya `Fiyat = Fiyat - 50`) kurgulayın.
3. Tablo şemasında değişiklik istendiğinde (yeni bir sütun ekleme veya tip değiştirme) `CREATE` veya `DROP` değil, **kesinlikle `ALTER TABLE`** komutunu kullanın.