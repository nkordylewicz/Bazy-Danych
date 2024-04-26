
--k
USE firma2;
SELECT stanowisko, COUNT (*) AS l_pracownikow 
FROM ksiegowosc.pensja
GROUP BY stanowisko;

--l
SELECT 
	AVG(kwota) AS srednia_placa,
	MIN(kwota) AS min_placa,
	MAX(kwota) AS max_placa
FROM ksiegowosc.pensja
WHERE stanowisko LIKE 'Kierownik';

--m
SELECT SUM(pn.kwota) + SUM(pr.kwota) AS suma_wynagrodzen
FROM ksiegowosc.pensja pn
JOIN ksiegowosc.wynagrodzenie w ON pn.id_pensji = w.id_pensji
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii;

--f
SELECT stanowisko, 
       SUM(pn.kwota) + SUM(CASE WHEN pr.kwota > 0 THEN pr.kwota ELSE 0 END) AS suma_wynagrodzen
FROM ksiegowosc.pensja pn
JOIN ksiegowosc.wynagrodzenie w ON pn.id_pensji = w.id_pensji
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
GROUP BY stanowisko;

--g
SELECT pn.stanowisko,
	COUNT(pr.kwota) AS suma_premii
FROM ksiegowosc.pensja pn
JOIN ksiegowosc.wynagrodzenie w ON pn.id_pensji = w.id_pensji
JOIN ksiegowosc.premia pr ON w.id_premii = pr.id_premii
WHERE pr.kwota IS NOT NULL
GROUP BY pn.stanowisko;

--h
DELETE p
FROM ksiegowosc.pracownicy p
JOIN ksiegowosc.wynagrodzenie w ON w.id_pracownika=p.id_pracownika
JOIN ksiegowosc.pensja pn ON pn.id_pensji = w.id_pensji
WHERE pn.kwota <'1200'

