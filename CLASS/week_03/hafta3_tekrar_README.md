🎓 Öğrenci Bilgi Sistemi (Student Management System)

Bu proje, bir üniversitenin Öğrenci Bilgi Sistemi (ÖBS) veritabanı altyapısının T-SQL kullanılarak simüle edildiği bir laboratuvar çalışmasıdır. Veritabanı üzerinde temel DDL (Veri Tanımlama), DML (Veri İşleme) ve DQL (Veri Sorgulama) operasyonları gerçek dünya senaryolarına dayandırılarak uygulanmıştır.

🛠️ Kullanılan SQL Komutları ve Senaryolar

Bu çalışmada aşağıdaki SQL Server (T-SQL) komutları kullanılmış ve veri mühendisliği standartlarına uygun şekilde yapılandırılmıştır:

1. Tablo Mimarisinin Kurulması (CREATE TABLE)

Sistemin iskeletini oluşturmak için kullanılmıştır. Sütunların veri tipleri, içerecekleri verilere göre optimize edilmiştir.

DECIMAL(3,2): Not ortalaması (GPA) gibi küsuratlı değerlerin (örn: 3.90) sıfır veri kaybıyla tutulması için tercih edilmiştir.

NVARCHAR(n): Ad, soyad ve bölüm gibi Türkçe karakter (ş, ğ, ç vb.) içerebilecek metin verilerini güvenle saklamak için kullanılmıştır.

2. Veri Girişi (INSERT INTO ... VALUES)

Çoklu Satır (Multi-row) Ekleme: Performansı artırmak amacıyla başlangıç verileri tek bir yığın (batch) halinde sisteme yüklenmiştir.

Tekli Satır Ekleme: "Yatay geçiş yapan yeni öğrenci" senaryosunda tabloya sonradan tekil bir kayıt eklenmiştir.

3. Koşullu Veri Filtreleme (SELECT ... WHERE ... AND)

Senaryo (Rektörlük Raporu): Sadece belirli bir bölümdeki, aktif ve belirli bir not ortalamasının üzerindeki öğrencileri bulmak için yazılmıştır.

AND mantıksal operatörü ile üç farklı kuralın (Bölüm, Kayıt Durumu ve Not) aynı anda sağlanması zorunlu kılınmıştır.

4. Güvenli Veri Güncelleme (UPDATE ... SET ... WHERE)

Veritabanındaki en riskli komutlardan biri olan güncelleme işlemi, etkileme alanını daraltmak için sıkı koşullara bağlanmıştır.

Senaryo (Sınıf Atlatma): Sadece 'Yönetim Bilişim Sistemleri' bölümünde ve sadece '3.' sınıfta olan öğrencilerin sınıfı '4' olarak güncellenmiştir. Koşulsuz kullanımın önüne geçilmiştir.

5. Sıralama ve Sınırlandırma (SELECT TOP ... ORDER BY)

Senaryo (Onur Belgesi Töreni): Tüm okuldaki en başarılı ilk 3 öğrenciyi tespit etmek için kullanılmıştır.

ORDER BY ... DESC: Verileri not ortalamasına göre en yüksekten en düşüğe (azalan) sıralamıştır.

TOP 3: Bu sıralı listenin sadece en üstteki 3 kaydının (satırının) getirilmesini sağlamıştır.

6. Tablo Şemasını Güncelleme (ALTER TABLE ... ADD)

Senaryo (Burs Sistemi Entegrasyonu): İçi veri dolu olan ve aktif çalışan bir tabloya, sonradan "Burslu Mu" (BURSLU_MU) adında yeni bir sütun eklenmiştir.

BIT Veri Tipi: Burs durumu bir "Evet/Hayır" (1 veya 0) sorusu olduğu için disk alanından tasarruf sağlamak amacıyla en küçük veri tipi olan BIT tercih edilmiştir. Ardından başarılı öğrencilere UPDATE komutuyla 1 (Burslu) değeri atanmıştır.