📚 Temel Veritabanı İşlemleri (Öğrenciler Tablosu)

Bu doküman, T-SQL kullanılarak gerçekleştirilen ilk temel veritabanı laboratuvar çalışmasının kayıtlarını içerir. Çalışma kapsamında sıfırdan bir tablo inşa edilmiş, veriler girilmiş ve çeşitli iş senaryolarına (ve acil kriz durumlarına!) yanıt veren sorgular yazılmıştır.

🛠️ Kullanılan SQL Komutları ve Mimari Kararlar

Bu çalışmada veritabanı temellerini atmak için aşağıdaki DDL, DML ve DQL komutları kullanılmıştır:

1. Tablo Kurulumu ve Güvenlik (CREATE TABLE)

Sistemin ilk tablosu olan OGRENCILER inşa edilirken veri bütünlüğünü korumak için kritik kısıtlamalar (constraints) kullanılmıştır:

PRIMARY KEY IDENTITY (1,1): Öğrenci ID'si sisteme birincil anahtar olarak tanımlanmış ve sistemin bu numarayı 1'den başlayarak otomatik (otomatik artan) vermesi sağlanmıştır. Bu sayede manuel hataların önüne geçilmiştir.

NOT NULL: Ad, soyad ve bölüm gibi temel bilgilerin boş bırakılması fiziksel olarak engellenmiştir.

2. Temel Sorgulama Operasyonları (SELECT)

Sistemden veri çekerken ihtiyaca göre farklı okuma yöntemleri kullanılmıştır:

Tüm Veriyi Okuma: SELECT * komutu ile tablonun genel durumu (Görev 1 ve 12) gözlemlenmiştir.

Projesiyon (Sütun Seçimi): Sadece istenen bilgileri (AD_SOYAD, BOLUM) getirerek sistem performansı optimize edilmiştir (Görev 2).

3. Mantıksal Filtrelemeler (WHERE)

Farklı veri tiplerine göre çeşitli filtrelemeler uygulanmıştır:

Metin Filtreleme: Bölüm ve Şehir isimlerine göre kesin eşleşmeler aranmıştır (BOLUM = 'Yönetim Bilişim Sistemleri').

Sayısal Filtreleme: Sınıf (SINIF = 2) ve Öğrenci No gibi tam sayı kontrolleri yapılmıştır.

Büyüklük/Küçüklük Kontrolü: Not ortalaması 3'ün üzerinde (> 3) veya 2.50'nin altında (< 2.50) olan öğrenciler tespit edilmiştir.

4. Tablo Şemasını Revize Etme (DDL Operasyonları)

İçi veri dolu olan bir tablonun iskeletine çalışma zamanında müdahaleler yapılmıştır:

Sütun Ekleme: ALTER TABLE ... ADD komutu ile sisteme e-posta ve telefon bilgisi entegre edilmiştir.

Sütun Silme: Gelen revize talebi ("80'ler aradı...") üzerine ALTER TABLE ... DROP COLUMN komutu ile telefon sütunu sistemden fiziksel olarak kaldırılmıştır.

Sütun Yeniden İsimlendirme: Daha okunaklı bir yapı için sp_rename prosedürü kullanılarak "SEHIR" sütununun adı "IKAMET_SEHRI" olarak güncellenmiştir.

🚨 Kriz Yönetimi Senaryosu (Açlık Grevi)

Üniversite çalışanlarının eylemi sırasında sistemin durmaması için acil müdahale sorguları yazılmıştır. Bu kapsamda WHERE filtreleri kullanılarak:

Akademik risk altındaki öğrenciler (Not < 2.50)

Mezuniyet aşamasındaki öğrenciler (Sınıf = 4)

Başkentte ikamet eden öğrenciler (İkamet Şehri = Ankara)
başarıyla tespit edilmiş ve kriz masasına sunulmuştur.