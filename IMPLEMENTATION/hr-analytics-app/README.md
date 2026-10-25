# 🏢 HR Analytics Veritabanı Mimarisi & SQL Çalışma Rehberi

![SQL Server](https://img.shields.io/badge/SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![T-SQL](https://img.shields.io/badge/T--SQL-005C84?style=for-the-badge&logo=microsoft-sql-server&logoColor=white) ![Study Guide](https://img.shields.io/badge/Exam_Prep-10B981?style=for-the-badge&logo=bookmeter&logoColor=white)

Bu proje, bir şirketin İnsan Kaynakları (HR) departmanının çalışan performans, yaş, departman ve maaş metriklerini analiz ettiği kurumsal bir "Salt Okunur (Read-Only)" raporlama mimarisi simülasyonudur. Şirket geneli istatistikler ve veri kümeleme fonksiyonlarına (Aggregations) odaklanır.

## 📂 Proje Klasör Yapısı (Read-Only Standart)
Proje tamamen analiz odaklı olduğu için (veri güncelleme veya tablo yapısı değiştirme senaryosu içermediğinden) mimaride `02_ddl_alter` ve `04_dml_operations` fazları kasıtlı olarak atlanmıştır:
* `01_ddl_init.sql` -> Veritabanı oluşturma ve `EKIP` tablosunun inşası (`CREATE`).
* `03_dml_insert.sql` -> Çalışan verilerinin sisteme girişi (`INSERT`).
* `05_dql_reports.sql` -> Gruplama, kümeleme ve metin filtreleme sorguları (`SELECT`).

---

## 🔍 FAZ 1: Hedefli Filtreleme (`BETWEEN` & `AS`)

* **Aralık Filtresi (`BETWEEN`):** `WHERE YAS BETWEEN 25 AND 32;`
  * *Mantık:* Başlangıç ve bitiş değerleri analize **dahildir**. `>= 25 AND <= 32` yazmak yerine kodu çok daha okunaklı hale getirir.
* **Geçici İsimlendirme (`AS` - Alias):** `SELECT AD_SOYAD AS 'CALISAN_ISMI'`
  * *Mantık:* Veritabanındaki orijinal tablo mimarisini bozmadan, sadece rapor ekranında (sonuç tablosunda) sütun isimlerine estetik bir makyaj yapar.

---

## 📈 FAZ 2: Şirket Geneli Metrikler (Kümeleme / Aggregations)
Tek bir `SELECT` sorgusu içinde tüm şirketin röntgenini çeken istatistiksel fonksiyonlardır:
* **`COUNT(*)`**: Tablodaki toplam çalışan (satır) sayısını hesaplar.
* **`SUM(MAAS)`**: Şirketin kasasından çıkan toplam maaş giderini (toplam maliyeti) verir.
* **`MIN(...)` / `MAX(...)`**: Belirtilen sütundaki (örn: Performans Puanı) en düşük ve en yüksek değerleri tespit eder.

---

## 👥 FAZ 3: Departman Bazlı Analiz (`GROUP BY`)
* ❌ **Hatalı Kullanım:** `SELECT DEPARTMAN, COUNT(*) FROM EKIP;` (SQL hata verir).
* ✅ **Doğru Kullanım:** `SELECT DEPARTMAN, COUNT(*) FROM EKIP GROUP BY DEPARTMAN;`
  * *Altın Kural:* `SELECT` yanına yazdığın ama bir kümeleme fonksiyonunun (`COUNT`, `SUM` vb.) içine almadığın YALIN sütun adlarını (bu örnekte `DEPARTMAN`), mutlaka `GROUP BY` yanına da yazmak zorundasın.

---

## 🔤 FAZ 4: Metin Arama ve Joker Karakterler (`LIKE` & `%`)
Bilinmeyen veya eşleşmesi istenen metin parçalarını filtrelemek için kullanılır. `%` işareti "burada herhangi bir karakter/karakterler olabilir" anlamına gelir.
* **Başlangıca Göre Arama:** `WHERE AD_SOYAD LIKE 'C%'` -> Adı 'C' ile başlasın, gerisi ne olursa olsun. (Örn: Can, Ceren)
* **Bitişe Göre Arama:** `WHERE AD_SOYAD LIKE '%K'` -> Başı ne olursa olsun, son harfi 'K' olsun. (Örn: Burak, Ak)
* **İçermeye Göre Arama:** `WHERE DEPARTMAN LIKE '%ZIL%'` -> Kelimenin herhangi bir yerinde 'ZIL' hecesi geçsin. (Örn: Ya**zıl**ım)

---
## 🎯 Sınav İçin Son Hatırlatmalar
1. `BETWEEN` kullanırken yazdığınız ilk ve son sayıların filtrelemeye DAHİL edildiğini unutmayın.
2. `GROUP BY` sorularında, `SELECT` kısmındaki düz sütunların `GROUP BY` komutunun yanında olup olmadığını mutlaka kontrol edin.
3. `LIKE` aramalarında Joker (`%`) karakterinin konumu, aramanın yönünü (başından, sonundan, içinden) belirler.