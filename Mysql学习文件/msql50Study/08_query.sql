USE word_kao_yan;
CREATE TABLE all_words(单词 VARCHAR(100),词性 VARCHAR(100),意思 VARCHAR(100));
# INSERT INTO wordsKaoYan VALUES("keep", "v.","坚持，保持");

SELECT * FROM all_words;
SELECT * FROM words;
SELECT * FROM wordsKaoYan WHERE 词性="vi.";
SELECT * FROM wordsKaoYan WHERE 单词="TIP";

SELECT * FROM all_words WHERE 意思="%鸡尾%";
SELECT DISTINCT 词性 FROM all_words;
DESC all_words;
SHOW TABLES;

SELECT * FROM all_words WHERE 词性="abbr.";
SELECT * FROM all_words WHERE 单词="Host";
SELECT * FROM all_words WHERE LENGTH(词性)>4;
# delete * FROM all_words WHERE LENGTH(词性)>4;

CREATE TABLE root_and_affix(root_or_affix VARCHAR(50),意思 VARCHAR(100));
INSERT INTO root_and_affix VALUES("attri", "献出，奉献");
SELECT * FROM root_and_affix WHERE root_or_affix="lapid";
SELECT * FROM root_and_affix;

# 模糊查询
SELECT * FROM all_words WHERE 单词 LIKE "%con%";
SELECT * FROM all_words WHERE 意思 LIKE "%鸡尾酒%";

SELECT * FROM all_words WHERE 词性 LIKE "%vi.%" AND 意思 LIKE "%考虑%" AND 单词 LIKE "%con%";





