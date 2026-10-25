# 🎮 Game Server Veritabanı Mimarisi & SQL Çalışma Rehberi

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![T-SQL](https://img.shields.io/badge/T--SQL-005C84?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Study Guide](https://img.shields.io/badge/Exam_Prep-10B981?style=for-the-badge&logo=bookmeter&logoColor=white)

Bu proje, devasa çok oyunculu çevrimiçi bir oyunun (MMO) arka plan veritabanı yönetimini simüle eder. Oyuncu kayıtları, seviye atlama, oyun içi ekonomi yönetimi ve hileci kontrolü (Ban işlemleri) gibi gerçek dünya senaryolarını barındırır. Bu belge, hem profesyonel mimari şablonumuzu yansıtır hem de "Senior" seviye sorgu optimizasyonlarını anlamak için hazırlanmıştır.

## 📂 Proje Klasör Yapısı (Separation of Concerns)
Kodlar 5 aşamalı endüstri standardına göre modüler dosyalara ayrılmıştır:
* `01_ddl_init.sql` -> Veritabanı oluşturma ve temel tablo mimarisi (`CREATE`).
* `02_ddl_alter.sql` -> Şema güncellemeleri ve isim değişiklikleri (`ALTER` & `SP_RENAME`).
* `03_dml_insert.sql` -> Oyuncu verilerinin sisteme girişi (`INSERT`).
* `04_dml_operations.sql` -> Seviye atlama, bakiye güncelleme ve ban işlemleri (`UPDATE`, `DELETE`).
* `05_dql_reports.sql` -> Liderlik tablosu ve analizler (`SELECT`).

---

## 🛠️ FAZ 1 & 2: Mimari Kurulum ve Esnetme (DDL)

* **`IDENTITY(1,1)` Mantığı:** Sunucuya her saniye binlerce oyuncu kayıt olabilir, ID atama işini manuel yapamayız. Bu komut, her yeni kayıt için SQL motorunun otomatik ve sıralı bir ID üretmesini sağlar.
* **Sütun İsmi Değiştirme (`SP_RENAME`):** `EXEC SP_RENAME 'OYUNCULAR.OYUN_ICI_KREDI', 'ALTIN_BAKIYE', 'COLUMN';`
  * *Mantık:* Sütun adlarını değiştirmek standart bir `ALTER` komutundan farklıdır. SQL Server'da bu işlem için sisteme özel olarak tanımlanmış bir "Stored Procedure" (Saklı Yordam) olan `SP_RENAME` kullanılır. Sınavlarda hoca tablo yapısını bozmadan isim değiştirmenizi isterse hayat kurtarır.

---

## 💉 FAZ 3: Veri Ekleme (DML)
* ❌ **Hatalı Kullanım:** `INSERT INTO OYUNCULAR VALUES ('ShadowNinja', ...)`
* ✅ **Doğru Kullanım:** `INSERT INTO OYUNCULAR (KULLANICI_ADI, KAYIT_TARIHI, SEVIYE, ALTIN_BAKIYE, BANLI_MI) VALUES ...`
* *Kritik Kural:* Tabloda `IDENTITY` olduğu için `OYUNCU_ID` sütununu parantez içine YAZMADIK. Eğer yazsaydık, SQL hata verip işlemi durduracaktı. Sadece manuel dolduracağımız sütunları belirttik.

---

## ⚙️ FAZ 4: Operasyonlar ve Kod Optimizasyonu (DML)
İşte bir öğrenci ile bir "Veri Mühendisini" ayıran detaylar buradadır.

* **Tek Sorguda Çoklu Güncelleme (Senior Taktik):** 
  * ❌ *Amatör Yaklaşım:* Bir oyuncunun hem seviyesini hem de altınını artırmak için iki ayrı `UPDATE` yazmak (sunucuyu iki kez yorar).
  * ✅ *Profesyonel Yaklaşım:* `UPDATE OYUNCULAR SET SEVIYE = SEVIYE + 1, ALTIN_BAKIYE = ALTIN_BAKIYE + 500 WHERE KULLANICI_ADI = 'x';` İşlemleri **virgül (`,`)** ile ayırarak tek sorguda birleştirdik. `SEVIYE = 6` demek yerine `SEVIYE = SEVIYE + 1` diyerek dinamik matematik kullandık.
* **Toplu Ödül Dağıtımı:** `WHERE BANLI_MI = 0` koşulu hayat kurtarır! Bu sayede banlı (hileci) hesaplara yanlışlıkla ödül altını göndermemiş olduk.

---

## 📊 FAZ 5: Analiz ve Raporlama (DQL)

* **Tarih Sıralamalarında `ASC` ve `DESC` Farkı:** 
  * `ORDER BY KAYIT_TARIHI ASC`: Tarihleri eski tarihten yeni tarihe doğru sıralar (en eski oyuncular üstte).
  * `ORDER BY KAYIT_TARIHI DESC`: **Doğru Kullanım.** Günümüz tarihinden geçmişe doğru iner. "En yeni oyuncuları" en üstte görmek istiyorsak, büyük tarihten küçüğe doğru (`DESC`) inmeliyiz.
* **Mantıksal Kapılar (`OR`):** `WHERE ALTIN_BAKIYE < 1000 OR SEVIYE < 10;`
  * *Mantık:* `AND` deseydik, bir oyuncunun listeye girmesi için *hem* fakir *hem de* düşük seviye olması gerekirdi. `OR` diyerek filtreyi esnettik.
* **Liderlik Tablosu (`TOP` ve `ORDER BY` Uyumu):** `SELECT TOP 3 KULLANICI_ADI, SEVIYE FROM OYUNCULAR ORDER BY SEVIYE DESC;`
  * *İşlem Sırası:* SQL önce tüm oyuncuları seviyelerine göre en yüksekten en düşüğe dizer (`DESC`), ardından en üstteki 3 satırı (`TOP 3`) kesip bize verir.