# YBS Veritabanı Lab - Hafta 2: Veri Manipülasyonu ve Tablo Yönetimi

Bu çalışma, Yönetim Bilişim Sistemleri (YBS) veritabanı laboratuvarı kapsamında sıfırdan bir öğrenci otomasyon sistemi veritabanının inşa edilmesini, yapısal olarak esnetilmesini ve kriz senaryolarına (iş kurallarına) göre sorgulanmasını içermektedir.

Tüm kodlar **Microsoft SQL Server (T-SQL)** standartlarına uygun olarak tek bir script dosyası içinde geliştirilmiş ve test edilmiştir.

## 🚀 Neler Öğrenildi ve Hangi Yetenekler Kullanıldı?

Bu senaryo boyunca bir veritabanı uzmanının temel günlük operasyonları simüle edilmiştir:

*   **Veri Tanımlama (DDL - Data Definition Language):** 
    *   `CREATE TABLE` ile doğru kapasite ve tipte (`INT`, `NVARCHAR`, `DECIMAL`) sütun mimarilerinin kurulması.
    *   `IDENTITY(1,1)` ile otomatik artan Primary Key (Birincil Anahtar) atanması.
    *   `ALTER TABLE ... ADD / DROP COLUMN` komutlarıyla mevcut tablo yapısının esnetilmesi.
    *   SQL Server'a özgü `sp_rename` prosedürü ile sütun isimlerinin güncellenmesi.
*   **Veri İşleme (DML - Data Manipulation Language):** 
    *   `INSERT INTO` ile tabloya tekli ve çoklu veri setlerinin, doğru formatlama (sayılar, metinler ve `NULL` değerler) kısıtlarına uyularak eklenmesi.
*   **Veri Sorgulama (DQL - Data Query Language):** 
    *   `SELECT` ile temel izdüşüm (projection) işlemleri.
    *   `WHERE` koşulu ile metin (`=`), sayısal (`>`, `<`) mantıksal operatörlerinin kullanılması.

## 📂 Dosya İçeriği ve Senaryo Akışı

Çalışma dosyası bir hikaye akışı şeklinde yapılandırılmıştır:

1.  **İskeletin Kurulması:** `OGRENCILER` tablosunun veri tipleri ve `NOT NULL` iş kuralları gözetilerek oluşturulması.
2.  **Veri Girişi:** Sisteme ilk 8 öğrencinin kaydının yapılması.
3.  **Filtreleme Görevleri:** Belirli öğrencilerin, bölümlerin ve not ortalamalarının `SELECT` işlemleriyle listelenmesi.
4.  **Kriz ve Güncelleme Operasyonları:** 
    *   Gelen talepler üzerine yeni e-posta ve telefon sütunlarının eklenmesi.
    *   Mizahi senaryo gereği ("80'ler aradı...") gereksiz sütunların imha edilmesi.
    *   Valilik şikayeti üzerine `SEHIR` isminin `IKAMET_SEHRI` olarak prosedürel şekilde değiştirilmesi.
    *   Üniversite çalışanlarının greve gitmesi sebebiyle acil durum verilerinin (notu 2.50 altı olanlar, son sınıf öğrencileri, vb.) çekilmesi.

## 🛠️ Nasıl Çalıştırılır?

1.  Bu repodaki `.sql` uzantılı dosyayı **SQL Server Management Studio (SSMS)** üzerinden açın.
2.  Dosyayı mevcut bir veritabanı (örn: `master` veya kendi oluşturduğunuz bir db) üzerinde çalıştırdığınızdan emin olun.
3.  Kodları yukarıdan aşağıya, yorum satırlarında belirtilen blokları **seçerek (highlight ederek)** ve sırayla **Execute (F5)** tuşuna basarak çalıştırın.
4.  Eğer tabloyu en baştan sıfırlamak isterseniz, scriptin en başına `DROP TABLE IF EXISTS OGRENCILER;` komutunu ekleyebilir veya nesne gezgininden tabloyu silebilirsiniz.

---
*Bu proje, veri mühendisliği ve SQL geliştirme yeteneklerini belgelemek amacıyla açık kaynaklı bir portfolyo çalışması olarak GitHub'a eklenmiştir.*
