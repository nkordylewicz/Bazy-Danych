--1
CREATE DATABASE firma2;
GO
--2
USE firma2;
GO
CREATE SCHEMA ksiegowosc;
GO

--4
CREATE TABLE ksiegowosc.pracownicy(
id_pracownika INT PRIMARY KEY, 
imie VARCHAR(50) NOT NULL,
nazwisko VARCHAR(50) NOT NULL,
adres VARCHAR(100) NOT NULL,
telefon INT NOT NULL,
);

CREATE TABLE ksiegowosc.godziny(
id_godziny INT PRIMARY KEY,
data_ DATE NOT NULL,
liczba_godzin INT,
id_pracownika INT NOT NULL,
FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
);

CREATE TABLE ksiegowosc.pensja(
id_pensji INT PRIMARY KEY,
stanowisko VARCHAR(50) NOT NULL,
kwota FLOAT NOT NULL,
);

CREATE TABLE ksiegowosc.premia(
id_premii INT PRIMARY KEY,
rodzaj VARCHAR(50),
kwota FLOAT NOT NULL,
);

CREATE TABLE ksiegowosc.wynagrodzenie(
id_wynagrodzenia INT PRIMARY KEY,
data_ DATE NOT NULL,
id_pracownika INT NOT NULL,
id_godziny INT NOT NULL,
id_pensji INT NOT NULL,
id_premii INT NOT NULL,
FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika),
FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny),
FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji),
FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii),
);

--5
INSERT INTO ksiegowosc.pracownicy(id_pracownika,imie,nazwisko,adres,telefon)
VALUES
(1, 'Joanna', 'Nowak', 'ul. Brzozowa 10', 667826550),
(2, 'Mateusz', 'Karolak', 'Plac Wolnoœci 5', 771436872),
(3, 'Amelia', 'Mickiewicz', 'Aleja Niepodleg³oœci 15', 600543322),
(4, 'Tomasz', 'Pilarczyk', 'ul. Lipowa 20', 889661225),
(5, 'Jacek', 'Majerczak', 'S³oneczna 30', 990553278),
(6, 'Aneta', 'Wita', 'Plac Narutowicza 18', 155763987),
(7, 'Karolina', 'GwóŸdŸ', 'ul. Piêkna 40', 534662031),
(8, 'Andrzej', 'Kuc', 'Aleja Pokoju 14', 887654223),
(9, 'Olga', 'Niemczuk', 'ul. Jagielloñska 8', 667552430),
(10, 'Tymoteusz', 'Kowalski', 'ul. Leœnicza 80', 445667325);

INSERT INTO ksiegowosc.godziny(id_godziny,data_,liczba_godzin,id_pracownika)
VALUES
(1,	'11-04-2024', 180, 1),
(2,	'11-04-2024', 170, 10),
(3,	'11-04-2024', 160, 9),
(4,	'11-04-2024', 170, 4),
(5,	'11-04-2024', 150, 6),
(6,	'11-04-2024', 160, 5),
(7,	'11-04-2024', 165, 7),
(8,	'11-04-2024', 170, 8),
(9,	'11-04-2024', 190, 3),
(10,'11-04-2024', 140, 2);

INSERT INTO ksiegowosc.pensja(id_pensji,stanowisko,kwota)
VALUES
(1, 'Kierownik', 10000),
(2, 'Specjalista ds. marketingu', 7000),
(3, 'Ksiêgowy', 8000),
(4, 'Doradca klienta', 6500),
(5, 'Administrator', 4500),
(6, 'Asystent', 5750),
(7, 'Analityk danych', 8800),
(8, 'Logistyk', 6300),
(9, 'Grafik', 7100),
(10, 'In¿ynier oprogramowania', 9000);

INSERT INTO ksiegowosc.premia(id_premii,rodzaj,kwota)
VALUES
(1, 'efektywnoœæ', 500),
(2, 'pozyskiwanie klientów', 800),
(3, 'wyniki', 300),
(4, 'brak', 0),
(5, 'zaanga¿owanie', 400),
(6, 'osi¹gniêcia', 300),
(7, 'brak', 0),
(8, 'wyniki', 200),
(9, 'osi¹gniêcia', 300),
(10, 'zaagna¿owanie', 450);

INSERT INTO ksiegowosc.wynagrodzenie(id_wynagrodzenia,data_,id_pracownika,id_godziny,id_pensji,id_premii)
VALUES
(1,	'11-04-2024', 1, 1, 1, 1),
(2,	'11-04-2024', 2, 2, 2, 2),
(3,	'11-04-2024', 3, 3, 3, 3),
(4,	'11-04-2024', 4, 4, 4, 4),
(5,	'11-04-2024', 5, 5, 5, 5),
(6,	'11-04-2024', 6, 6, 6, 6),
(7,	'11-04-2024', 7, 7, 7, 7),
(8,	'11-04-2024', 8, 8, 8, 8),
(9,	'11-04-2024', 9, 9, 9, 9),
(10,'11-04-2024', 10, 10, 10, 10);

--6
--a
SELECT id_pracownika,nazwisko FROM ksiegowosc.pracownicy;

--b
SELECT prac.id_pracownika 
FROM ksiegowosc.pracownicy prac
JOIN ksiegowosc.wynagrodzenie wyn
ON prac.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.pensja pn
ON wyn.id_pensji = pn.id_pensji
WHERE pn.kwota > 1000

--c
SELECT prac.id_pracownika
FROM ksiegowosc.pracownicy prac
JOIN ksiegowosc.wynagrodzenie wyn
ON prac.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.pensja pn
ON wyn.id_pensji = pn.id_pensji
JOIN ksiegowosc.premia pr
ON wyn.id_premii = pr.id_premii
WHERE (pr.kwota = 0) AND pn.kwota > 2000

--d
SELECT * FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%' 

--e
SELECT * FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a'
 
 --f
 SELECT prac.imie, prac.nazwisko, SUM(godz.liczba_godzin - 160) AS nadgodziny
 FROM ksiegowosc.pracownicy prac
 JOIN ksiegowosc.wynagrodzenie wyn
 ON prac.id_pracownika = wyn.id_pracownika
 JOIN ksiegowosc.godziny godz
 ON wyn.id_godziny = godz.id_godziny
	WHERE godz.liczba_godzin > 160
GROUP BY prac.imie, prac.nazwisko;

--g
SELECT prac.imie, prac.nazwisko
FROM ksiegowosc.pracownicy prac
JOIN ksiegowosc.wynagrodzenie wyn
ON prac.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.pensja pn
ON wyn.id_pensji = pn.id_pensji
WHERE pn.kwota > 1500 AND pn.kwota < 3000

--h
SELECT prac.imie, prac.nazwisko FROM ksiegowosc.pracownicy prac
JOIN ksiegowosc.wynagrodzenie wyn ON prac.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.godziny godz ON wyn.id_godziny = godz.id_godziny
JOIN ksiegowosc.premia prem ON wyn.id_premii = prem.id_premii
WHERE godz.liczba_godzin > 160 AND prem.kwota = 0

--i
SELECT prac.imie, prac.nazwisko, pn.kwota 
FROM ksiegowosc.pracownicy prac
JOIN ksiegowosc.wynagrodzenie wyn ON prac.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.pensja pn ON wyn.id_pensji = pn.id_pensji
ORDER BY pn.kwota 

--j
SELECT prac.imie, prac.nazwisko, pn.kwota AS pensja, pr.kwota AS premia 
FROM ksiegowosc.pracownicy prac
JOIN ksiegowosc.wynagrodzenie wyn ON prac.id_pracownika = wyn.id_pracownika
JOIN ksiegowosc.pensja pn ON wyn.id_pensji = pn.id_pensji
JOIN ksiegowosc.premia pr ON wyn.id_premii = pr.id_premii
ORDER BY pn.kwota, pr.kwota

