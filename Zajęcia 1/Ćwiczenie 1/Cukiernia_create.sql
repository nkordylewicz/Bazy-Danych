-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-03-14 19:40:55.178

-- tables
-- Table: Artykuly
CREATE TABLE Artykuly (
    IDZamowienia char  NOT NULL,
    IDPudelka char  NOT NULL,
    Sztuk int  NOT NULL,
    CONSTRAINT Artykuly_pk PRIMARY KEY (IDPudelka)
);

-- Table: Czekoladki
CREATE TABLE Czekoladki (
    IdCzekoladki char  NOT NULL,
    Nazwa varchar  NOT NULL,
    Sztuk int  NOT NULL,
    RodzajCzekolady varchar  NOT NULL,
    RodzajOrzechow varchar  NOT NULL,
    RodzajNadzienia varchar  NOT NULL,
    Opis varchar  NOT NULL,
    Koszt money  NOT NULL,
    Masa int  NOT NULL,
    CONSTRAINT Czekoladki_pk PRIMARY KEY (IdCzekoladki)
);

-- Table: Klienci
CREATE TABLE Klienci (
    IDKlienta char  NOT NULL,
    Nazwa char  NOT NULL,
    Ulica char  NOT NULL,
    Miejscowosc char  NOT NULL,
    Kod char  NOT NULL,
    Telefon char  NOT NULL,
    CONSTRAINT Klienci_pk PRIMARY KEY (IDKlienta)
);

-- Table: Pudelka
CREATE TABLE Pudelka (
    IDPudelka char  NOT NULL,
    Nazwa char  NOT NULL,
    Opis varchar  NOT NULL,
    Cena money  NOT NULL,
    Stan varchar  NOT NULL,
    CONSTRAINT Pudelka_pk PRIMARY KEY (IDPudelka)
);

-- Table: Zamowienia
CREATE TABLE Zamowienia (
    IDKlienta char  NOT NULL,
    IDZamowienia char  NOT NULL,
    DataRealizacji date  NOT NULL,
    CONSTRAINT Zamowienia_pk PRIMARY KEY (IDZamowienia)
);

-- Table: Zawartosc
CREATE TABLE Zawartosc (
    IDPudelka char  NOT NULL,
    IdCzekoladki char  NOT NULL,
    Sztuk int  NOT NULL,
    CONSTRAINT Zawartosc_pk PRIMARY KEY (IdCzekoladki)
);

-- foreign keys
-- Reference: Artykuly_Zamowienia (table: Artykuly)
ALTER TABLE Artykuly ADD CONSTRAINT Artykuly_Zamowienia
    FOREIGN KEY (IDZamowienia)
    REFERENCES Zamowienia (IDZamowienia)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Czekoladki_Zawartosc (table: Czekoladki)
ALTER TABLE Czekoladki ADD CONSTRAINT Czekoladki_Zawartosc
    FOREIGN KEY (IdCzekoladki)
    REFERENCES Zawartosc (IdCzekoladki)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Pudelka_Artykuly (table: Pudelka)
ALTER TABLE Pudelka ADD CONSTRAINT Pudelka_Artykuly
    FOREIGN KEY (IDPudelka)
    REFERENCES Artykuly (IDPudelka)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Zamowienia_Klienci (table: Zamowienia)
ALTER TABLE Zamowienia ADD CONSTRAINT Zamowienia_Klienci
    FOREIGN KEY (IDKlienta)
    REFERENCES Klienci (IDKlienta)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Zawartosc_Pudelka (table: Zawartosc)
ALTER TABLE Zawartosc ADD CONSTRAINT Zawartosc_Pudelka
    FOREIGN KEY (IDPudelka)
    REFERENCES Pudelka (IDPudelka)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

