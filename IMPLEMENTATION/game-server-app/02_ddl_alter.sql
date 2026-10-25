USE GameServer_DB;
GO

-- 1. Hileci kontrolü için BANLI_MI sütunu ekleme
ALTER TABLE OYUNCULAR
ADD BANLI_MI BIT;
GO

-- 2. Sütun adını oyuna uygun şekilde güncelleme
EXEC SP_RENAME 'OYUNCULAR.OYUN_ICI_KREDI', 'ALTIN_BAKIYE', 'COLUMN';
GO