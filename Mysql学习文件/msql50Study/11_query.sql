DESC means;   # word_id mean_text
DESC words;   # word_id word ciXin_id

SELECT * FROM means;
SELECT * FROM words;
SELECT * FROM cixin;
SELECT w.word,m.mean_text,w.ciXin_id
FROM words  w JOIN means m ON w.word_id=m.word_id;

SELECT * FROM cet_six_words;


