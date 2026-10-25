USE GameServer_DB;
GO

-- 1. Level Up: 'x' oyuncusunun seviye ve bakiye güncellemesi (Tek sorguda optimize edildi)
UPDATE OYUNCULAR
SET SEVIYE = SEVIYE + 1, ALTIN_BAKIYE = ALTIN_BAKIYE + 500
WHERE KULLANICI_ADI = 'x';
GO

-- 2. Global Event: Banlı olmayanlara ödül altını dağıtımı
UPDATE OYUNCULAR
SET ALTIN_BAKIYE = ALTIN_BAKIYE + 100
WHERE BANLI_MI = 0;
GO

-- 3. Ban Wave: Hilecilerin (Banlı hesapların) sistemden silinmesi
DELETE FROM OYUNCULAR
WHERE BANLI_MI = 1;
GO