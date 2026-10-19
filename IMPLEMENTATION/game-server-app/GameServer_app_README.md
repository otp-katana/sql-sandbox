# 🎮 Oyun Sunucusu Yönetimi (Game Backend) - SQL Vize Çalışma Rehberi 2

Bu proje, devasa çok oyunculu çevrimiçi bir oyunun (MMO) arka plan veritabanı yönetimini simüle eder. Oyuncu kayıtları, seviye atlama, oyun içi ekonomi yönetimi ve hileci kontrolü (Ban işlemleri) gibi gerçek dünya senaryolarını barındırır.

Bu rehber, SQL temellerini pekiştirmek ve "Senior" seviye sorgu optimizasyonlarını anlamak için hazırlanmıştır.

## 📂 Proje Dosyaları

* `00_init_GameServer_DB.sql` -> Veritabanı oluşturma (`CREATE DATABASE`).
* `oyuncular_tablo.sql` -> Temel tablo mimarisi (`CREATE TABLE`).
* `tablo_modifikasyonları.sql` -> Şema güncellemeleri ve isim değişiklikleri (`ALTER` & `SP_RENAME`).
* `veri_ekleme.sql` -> Oyuncu verilerinin sisteme girişi (`INSERT INTO`).
* `veri_düzenleme.sql` -> Seviye atlama, bakiye güncelleme ve ban işlemleri (`UPDATE` & `DELETE`).
* `veri_raporlama.sql` -> Liderlik tablosu ve analizler (`SELECT`).

---

## 🏗️ FAZ 1 & 2: Mimari Kurulum ve Esnetme (DDL)

### 1. Tablo Oluşturma Mantığı
```sql
CREATE TABLE OYUNCULAR (
	OYUNCU_ID INT PRIMARY KEY IDENTITY (1,1),
	...
```
* **Neden `IDENTITY(1,1)`?** Sunucuya her saniye binlerce oyuncu kayıt olabilir. ID atama işini manuel yapamayız. Bu komut, her yeni kayıt için SQL motorunun otomatik ve sıralı bir ID üretmesini sağlar.

### 2. Sütun İsmi Değiştirme (`SP_RENAME`)
```sql
EXEC SP_RENAME 'OYUNCULAR.OYUN_ICI_KREDI', 'ALTIN_BAKIYE', 'COLUMN';
```
* Sütun adlarını değiştirmek standart bir `ALTER` komutundan farklıdır. SQL Server'da bu işlem için sisteme özel olarak tanımlanmış bir "Stored Procedure" (Saklı Yordam) olan `SP_RENAME` kullanılır. Sınavlarda hoca tablo yapısını bozmadan isim değiştirmenizi isterse hayat kurtarır.

---

## 💉 FAZ 3: Veri Ekleme (DML)

```sql
INSERT INTO OYUNCULAR (KULLANICI_ADI, KAYIT_TARIHI, SEVIYE, ALTIN_BAKIYE, BANLI_MI)
VALUES ('ShadowNinja', '2026-08-15 14:30:00', 60, 15000.50, 0), ...
```
* **Kritik Kural:** Tabloda `IDENTITY` olduğu için `OYUNCU_ID` sütununu parantez içine YAZMADIK. Eğer yazsaydık, SQL hata verip işlemi durduracaktı. Sadece manuel dolduracağımız sütunları belirttik.

---

## ⚙️ FAZ 4: Operasyonlar ve Kod Optimizasyonu (DML)

İşte bir öğrenci ile bir "Veri Mühendisini" ayıran detaylar buradadır.

### 1. Tek Sorguda Çoklu Güncelleme (Senior Taktik)
* **Amatör Yaklaşım:** Bir oyuncunun hem seviyesini hem de altınını artırmak için iki ayrı `UPDATE` yazmak (sunucuyu iki kez yorar).
* **Profesyonel Yaklaşım:** İşlemleri **virgül (`,`)** ile ayırarak tek sorguda birleştirmek:
```sql
UPDATE OYUNCULAR
SET SEVIYE = SEVIYE + 1, ALTIN_BAKIYE = ALTIN_BAKIYE + 500
WHERE KULLANICI_ADI = 'x';
```
* **Dinamik Matematik:** `SEVIYE = 6` demek yerine `SEVIYE = SEVIYE + 1` diyerek, oyuncunun mevcut durumu ne olursa olsun o değerin üzerine ekleme yaptık.

### 2. Toplu Ödül Dağıtımı
```sql
UPDATE OYUNCULAR SET ALTIN_BAKIYE = ALTIN_BAKIYE + 100 WHERE BANLI_MI = 0;
```
* `WHERE` koşulu hayat kurtarır! Bu sayede banlı (hileci) hesaplara yanlışlıkla ödül altını göndermemiş olduk.

---

## 📊 FAZ 5: Analiz ve Raporlama (DQL)

### 1. Tarih Sıralamalarında `ASC` ve `DESC` Farkı
Zaman verilerinde sıralama yaparken yön (Artan/Azalan) çok kritiktir:
* **`ORDER BY KAYIT_TARIHI ASC` (Artan):** Tarihleri eski tarihten yeni tarihe doğru sıralar. Yani en eski oyuncular en üstte çıkar.
* **`ORDER BY KAYIT_TARIHI DESC` (Azalan - Doğru Kullanım):** Günümüz tarihinden geçmişe doğru iner. **"En yeni oyuncuları"** en üstte görmek istiyorsak, büyük tarihten küçüğe doğru (`DESC`) inmeliyiz.

### 2. Mantıksal Kapılar (`OR`)
```sql
SELECT * FROM OYUNCULAR WHERE ALTIN_BAKIYE < 1000 OR SEVIYE < 10;
```
* **`AND` vs `OR`:** `AND` deseydik, bir oyuncunun listeye girmesi için *hem* fakir *hem de* düşük seviye olması gerekirdi. `OR` diyerek, "Altını az olanlar DA gelsin, Seviyesi düşük olanlar DA gelsin" dedik. Filtreyi esnettik.

### 3. Liderlik Tablosu (`TOP` ve `ORDER BY` Uyumu)
```sql
SELECT TOP 3 KULLANICI_ADI, SEVIYE FROM OYUNCULAR ORDER BY SEVIYE DESC;
```
* SQL önce tüm oyuncuları seviyelerine göre en yüksekten en düşüğe dizer (`DESC`), ardından en üstteki 3 satırı (`TOP 3`) kesip bize verir.