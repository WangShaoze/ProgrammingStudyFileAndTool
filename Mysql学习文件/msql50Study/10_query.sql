SELECT * FROM all_words
WHERE LENGTH(单词) >=5;
SELECT root_or_affix AS "词根词缀", 意思 FROM `root_and_affix`;