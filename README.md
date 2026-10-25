# 🗄️ SQL Sandbox & Data Engineering Portfolio

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![T-SQL](https://img.shields.io/badge/T--SQL-005C84?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

Bu depo, Yönetim Bilişim Sistemleri (YBS) veritabanı laboratuvar çalışmalarını, veri mühendisliği pratiklerini ve Microsoft SQL Server mimarisi üzerindeki yapısal denemeleri barındıran merkezi çalışma alanımdır. 

Klasik bir ödev deposundan ziyade, profesyonel veri mühendisliği standartlarının (versiyon kontrolü, klasör mimarisi, temiz kod) uygulandığı bir portfolyo projesi olarak tasarlanmıştır.

## 🛠️ Teknoloji Yığını ve Ortam

* **RDBMS:** Microsoft SQL Server 2025
* **Geliştirme Ortamı (IDE):** SQL Server Management Studio (SSMS 22)
* **Sorgu Dili:** T-SQL (Transact-SQL)
* **Versiyon Kontrolü:** Git & GitHub

## 📂 Portfolyo Projeleri ve Mimari Standart

Çalışmalar, yapısal bir bütünlük sağlamak adına senaryo bazlı klasörlenmiş ve **5 aşamalı DDL/DML endüstri standardına** (`01_ddl_init`, `02_ddl_alter`, `03_dml_insert`, `04_dml_operations`, `05_dql_reports`) göre standartlaştırılmıştır.

* 🛒 **[e-ticaret-app](./e-ticaret-app/):** Stok, fiyatlandırma ve kullanıcı aktiflik durumlarını yöneten, veri kaybı olmadan şema güncellemeleri (`ALTER`) barındıran e-ticaret veritabanı simülasyonu.
* 🎮 **[game-server-app](./game-server-app/):** Çoklu UPDATE sorguları, dinamik sıralamalar (`DESC`) ve mantıksal operatörlerle hileci (Ban) kontrolü yapan MMO oyun sunucusu arka planı.
* 🏢 **[hr-analytics-app](./hr-analytics-app/):** Kümeleme fonksiyonları (`SUM`, `COUNT`), gruplama (`GROUP BY`) ve metin filtrelemeleri (`LIKE`) ile şirket verilerini analiz eden "Read-Only" İnsan Kaynakları raporlama mimarisi.

*(Not: Tüm `.sql` betikleri GitHub Linguist tarafından T-SQL olarak algılanacak şekilde yapılandırılmıştır.)*

## 🌿 Git İş Akışı (Branching Strategy)

Bu projede kodların güvenliğini ve sürdürülebilirliğini sağlamak için sektör standardı olan **Feature Branching** stratejisi uygulanmaktadır:

* **`main` Branch:** Sadece test edilmiş, tamamen çalışan ve son haline getirilmiş (production-ready) kodları barındıran vitrin dalıdır.
* **`chucker-out` Branch:** Laboratuvar görevlerinin yapıldığı, yeni T-SQL komutlarının test edildiği ve hataların ayıklandığı aktif geliştirme (dev/sandbox) dalıdır. İşlemler tamamlandıktan sonra `main` dalına merge (birleştirme) edilir.
* Depodaki tüm commit geçmişi, okunabilirliği artırmak adına **Conventional Commits** (`feat`, `docs`, `chore`, `refactor` vb.) standartlarına uygun olarak tutulmaktadır.

## 🚀 Gelişim Yol Haritası

- [x] Temel Veri Tanımlama (DDL) ve Veri İşleme (DML) operasyonları
- [x] Mantıksal operatörler ile koşullu veri filtreleme (`WHERE`, `AND`, `OR`)
- [x] Karmaşık veri toplama fonksiyonları (`Aggregate Functions` & `GROUP BY`)
- [ ] İlişkisel veri modeli tasarımı ve Joins (`Inner`, `Left`, `Right`)
- [ ] Saklı Yordamlar (`Stored Procedures`), Tetikleyiciler (`Triggers`) ve Görünümler (`Views`)
- [ ] Veritabanı optimizasyonu ve İndeksleme (`Indexing`)

---
*Bu depo, veri mühendisliği yolculuğunda teknik yetkinlikleri belgelemek amacıyla sürekli olarak güncellenmektedir.*