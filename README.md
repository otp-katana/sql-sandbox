# 🗄️ SQL Sandbox

Bu depo, Yönetim Bilişim Sistemleri (YBS) veritabanı laboratuvar çalışmalarını, veri mühendisliği pratiklerini ve Microsoft SQL Server mimarisi üzerindeki yapısal denemeleri barındıran merkezi çalışma alanımdır. 

Klasik bir ödev deposundan ziyade, profesyonel veri mühendisliği standartlarının (versiyon kontrolü, klasör mimarisi, temiz kod) uygulandığı bir portfolyo projesi olarak tasarlanmıştır.

## 🛠️ Teknoloji Yığını ve Ortam

* **RDBMS:** Microsoft SQL Server 2025
* **Geliştirme Ortamı (IDE):** SQL Server Management Studio (SSMS 22)
* **Sorgu Dili:** T-SQL (Transact-SQL)
* **Versiyon Kontrolü:** Git & GitHub

## 📂 Depo Mimarisi

Çalışmalar, yapısal bir bütünlük sağlamak adına modüler olarak klasörlenmiştir:

* `implementation/`: Haftalık laboratuvar görevleri, veritabanı şema (schema) kurulumları, DDL/DML operasyonları ve iş kurallarına dayalı karmaşık filtreleme senaryolarını barındıran SQL betikleri.
* `*.sql`: Tüm kodlar GitHub Linguist tarafından T-SQL olarak algılanacak şekilde yapılandırılmış ve uzantı standartlarına uygun kaydedilmiştir.

## 🌿 Git İş Akışı (Branching Strategy)

Bu projede kodların güvenliğini ve sürdürülebilirliğini sağlamak için sektör standardı olan **Feature Branching** stratejisi uygulanmaktadır:

* **`main` Branch:** Sadece test edilmiş, tamamen çalışan ve son haline getirilmiş (production-ready) kodları barındıran vitrin dalıdır.
* **`chucker-out` Branch:** Laboratuvar görevlerinin yapıldığı, yeni T-SQL komutlarının test edildiği ve hataların ayıklandığı aktif geliştirme (dev/sandbox) dalıdır. İşlemler tamamlandıktan sonra `main` dalına merge (birleştirme) edilir.
* Depodaki tüm commit geçmişi, okunabilirliği artırmak adına **Conventional Commits** (feat, docs, chore vb.) standartlarına uygun olarak tutulmaktadır.

## 🚀 Gelişim Yol Haritası

- [x] Temel Veri Tanımlama (DDL) ve Veri İşleme (DML) operasyonları
- [x] Mantıksal operatörler ile koşullu veri filtreleme (WHERE, AND, OR)
- [ ] İlişkisel veri modeli tasarımı ve Joins (Inner, Left, Right)
- [ ] Karmaşık veri toplama fonksiyonları (Aggregate Functions & GROUP BY)
- [ ] Saklı Yordamlar (Stored Procedures), Tetikleyiciler (Triggers) ve Görünümler (Views)
- [ ] Veritabanı optimizasyonu ve İndeksleme (Indexing)

---
*Bu depo, veri mühendisliği yolculuğunda teknik yetkinlikleri belgelemek amacıyla sürekli olarak güncellenmektedir.*
