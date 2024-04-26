USE firma2;

--a
ALTER TABLE ksiegowosc.pracownicy
ADD n_telefon VARCHAR(16);

UPDATE ksiegowosc.pracownicy
SET n_telefon = CONCAT('(+48)', telefon);

ALTER TABLE ksiegowosc.pracownicy
DROP COLUMN telefon;

SELECT * FROM ksiegowosc.pracownicy;

--b
UPDATE ksiegowosc.pracownicy
SET n_telefon = CONCAT(
	SUBSTRING(n_telefon, 1,8), '-',
	SUBSTRING(n_telefon, 9,3), '-',
	SUBSTRING(n_telefon, 12,3));

--c
SELECT TOP 1 id_pracownika,imie,UPPER(nazwisko) AS nazwisko_u, adres, n_telefon
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) DESC;

--d
SELECT p.id_pracownika, p.imie, p.nazwisko, HASHBYTES('MD5', CONVERT(VARCHAR, pn.kwota)) AS md5_pensja 
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja pn ON w.id_pensji = pn.id_pensji

--f
SELECT p.id_pracownika, p.imie, p.nazwisko, pn.kwota AS pensja, pr.kwota AS premia
FROM ksiegowosc.pracownicy p
LEFT JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika = p.id_pracownika
LEFT JOIN ksiegowosc.pensja pn ON pn.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premia pr ON pr.id_premii = w.id_premii

--g
SELECT CONCAT('Pracownik ', p.imie, ' ', p.nazwisko, ', w dniu ', w.data_, ' otrzyma³/a pensjê ca³kowit¹ na kwotê ',
(pn.kwota+pr.kwota), ' z³, gdzie wynagrodzenie zasadnicze wynosi³o: ', pn.kwota, ' z³, premia: ',
pr.kwota, ' z³, nadgodziny: ', CASE WHEN godz.liczba_godzin > 160 THEN (godz.liczba_godzin - 160) ELSE 0 END, ' godz.')
AS raport
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON p.id_pracownika = w.id_pracownika
JOIN ksiegowosc.pensja pn ON w.id_pensji = pn.id_pensji
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
JOIN ksiegowosc.godziny godz ON w.id_godziny = godz.id_godziny


