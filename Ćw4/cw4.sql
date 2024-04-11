--1
CREATE DATABASE firma;
GO

--2
CREATE SCHEMA rozliczenia;
GO

--3
USE firma;
CREATE TABLE rozliczenia.pracownicy(
id_pracownika INTEGER NOT NULL PRIMARY KEY,
imie VARCHAR(40) NOT NULL,
nazwisko VARCHAR(40) NOT NULL,
adres VARCHAR(80), 
telefon INTEGER 
);

CREATE TABLE rozliczenia.godziny(
id_godziny INTEGER NOT NULL PRIMARY KEY,
data_ DATE NOT NULL,
liczba_godzin INTEGER NOT NULL,
id_pracownika INTEGER NOT NULL,
);

CREATE TABLE rozliczenia.pensje(
id_pensji INTEGER NOT NULL PRIMARY KEY, 
stanowisko VARCHAR(30) NOT NULL,
kwota MONEY NOT NULL,
id_premii INTEGER,
);

CREATE TABLE rozliczenia.premie(
id_premii INTEGER PRIMARY KEY,
rodzaj VARCHAR(30),
kwota MONEY,
);

--d
ALTER TABLE rozliczenia.godziny
ADD CONSTRAINT id_pracownika
FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy(id_pracownika)

ALTER TABLE rozliczenia.pensje
ADD CONSTRAINT id_premii
FOREIGN KEY (id_premii)
REFERENCES rozliczenia.premie(id_premii)

--4
INSERT INTO rozliczenia.pracownicy(id_pracownika,imie,nazwisko,adres,telefon)
VALUES 
(1, 'Paulina', 'Nowak', 'ul. Brzozowa 10', 667826550),
(2, 'Mateusz', 'Karolak', 'Plac Wolnoœci 5', 771436872),
(3, 'Amelia', 'Mickiewicz', 'Aleja Niepodleg³oœci 15', 600543322),
(4, 'Tomasz', 'Pilarczyk', 'ul. Lipowa 20', 889661225),
(5, 'Dariusz', 'Majerczak', 'S³oneczna 30', 990553278),
(6, 'Aneta', 'Wita', 'Plac Narutowicza 18', 155763987),
(7, 'Karolina', 'GwóŸdŸ', 'ul. Piêkna 40', 534662031),
(8, 'Andrzej', 'Kuc', 'Aleja Pokoju 14', 887654223),
(9, 'Olga', 'Kowalska', 'ul. Jagielloñska 8', 667552430),
(10, 'Tymoteusz', 'Niemczuk', 'ul. Leœnicza 80', 445667325);

INSERT INTO rozliczenia.godziny(id_godziny,data_,liczba_godzin,id_pracownika)
VALUES
(1, '11-04-2024', 10, 1),
(2,	'11-04-2024', 9, 10),
(3,	'11-04-2024', 8, 9),
(4,	'11-04-2024', 9, 4),
(5,	'11-04-2024', 8, 6),
(6,	'11-04-2024', 8, 5),
(7,	'11-04-2024', 8, 7),
(8,	'11-04-2024', 7, 8),
(9,	'11-04-2024', 9, 3),
(10, '11-04-2024', 8, 2);

INSERT INTO rozliczenia.premie(id_premii, rodzaj, kwota)
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

INSERT INTO rozliczenia.pensje(id_pensji,stanowisko,kwota,id_premii)
VALUES
(1, 'Kierownik', 10000, 10),
(2, 'Specjalista ds. marketingu', 7000, 1),
(3, 'Ksiêgowy', 8000, 2),
(4, 'Doradca klienta', 6500, 8),
(5, 'Administrator', 4500, 9),
(6, 'Asystent', 5750, 3),
(7, 'Analityk danych', 8800,4),
(8, 'Logistyk', 6300, 5),
(9, 'Grafik', 7100, 6),
(10, 'In¿ynier oprogramowania', 9000, 7);

--5
SELECT nazwisko,adres FROM rozliczenia.pracownicy;

--6
SELECT 
DATEPART(WEEKDAY, data_) AS dzien_tygodnia,
DATEPART(MONTH, data_) AS miesiac
FROM rozliczenia.godziny;

--7
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

ALTER TABLE rozliczenia.pensje
ADD kwota_netto MONEY;

UPDATE rozliczenia.pensje
SET kwota_netto = kwota_brutto * 0.77;

select * from rozliczenia.pensje;
