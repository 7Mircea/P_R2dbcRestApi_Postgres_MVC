ALTER TABLE IF EXISTS FACTURA
    DROP CONSTRAINT IF EXISTS FK_CAF_F_emit;
ALTER TABLE IF EXISTS FACTURA
    DROP CONSTRAINT IF EXISTS FK_CAF_F_angajat;
ALTER TABLE IF EXISTS FACTURA
    DROP CONSTRAINT IF EXISTS FK_CAF_F_beneficiar;
ALTER TABLE IF EXISTS Produse
    DROP CONSTRAINT IF EXISTS FK_CAF_P;
ALTER TABLE IF EXISTS ITEM
    DROP CONSTRAINT IF EXISTS FK_P_I;
ALTER TABLE IF EXISTS ITEM
    DROP CONSTRAINT IF EXISTS FK_F_I;
ALTER TABLE IF EXISTS CARACTERISTICA
    DROP CONSTRAINT IF EXISTS FK_P_C;

DROP TABLE IF EXISTS CLIENT_ANGAJAT_FURNIZOR;
DROP TABLE IF EXISTS PRODUSE;
DROP TABLE IF EXISTS CARACTERISTICA;
DROP TABLE IF EXISTS FACTURA;
DROP TABLE IF EXISTS ITEM;


CREATE TABLE CLIENT_ANGAJAT_FURNIZOR
(
    ID_caf  integer                NOT NULL,
    Nume    character varying(40)  NOT NULL,
    CIF     character varying(10)  NULL,
    Tip_caf CHAR(1)                NOT NULL,
    Adresa  character varying(100) NULL,
    Iban    character varying(34)  NOT NULL,
    CNP     character varying(13)  NULL,
    CONSTRAINT PK_CLIENT_ANGAJAT_FURNIZOR PRIMARY KEY (ID_caf)
)
;

CREATE TABLE FACTURA
(
    Nr         integer       NOT NULL,
    Data_fact  DATE          NOT NULL,
    Id_emit    integer       NOT NULL,
    Tip        CHAR(1)       NOT NULL,
    Valoare    decimal(9, 2) NOT NULL,
    TVA        decimal(9, 2) NOT NULL,
    Id_angajat integer       NOT NULL,
    Id_benef   integer       NOT NULL,
    CONSTRAINT PK_FACTURA PRIMARY KEY (Data_fact, Nr)
);

CREATE TABLE Produse
(
    Id_prod         integer                NOT NULL,
    Den_prod        character varying(50)  NOT NULL,
    Id_furnizor     integer                NOT NULL,
    Disponibilitate character varying(20)  NOT NULL,
    Categorie       character varying(20)  NOT NULL,
    Info_supl       character varying(100) NULL,
    CONSTRAINT PK_Produse PRIMARY KEY (Id_prod)
);

CREATE TABLE ITEM
(
    Nr_fact      integer              NOT NULL,
    Data_fact    DATE                 NOT NULL,
    Id_item      integer              NOT NULL,
    Id_prod      integer              NOT NULL,
    UM           character varying(5) NOT NULL,
    Cantitate    integer              NOT NULL,
    Pret_unitate decimal(7, 2)        NOT NULL,
    CONSTRAINT PK_ITEM PRIMARY KEY (Nr_fact, Data_fact, Id_item)
);

CREATE TABLE CARACTERISTICA
(
    Id_prod           integer                NOT NULL,
    Id_caracteristica integer                NOT NULL,
    Denumire          character varying(50)  NOT NULL,
    Valoare           character varying(150) NOT NULL,
    CONSTRAINT PK_CARACTERISTICA PRIMARY KEY (Id_prod, Id_caracteristica)
)
;

ALTER TABLE FACTURA
    ADD
        CONSTRAINT FK_CAF_F_emit FOREIGN KEY
            (Id_emit)
            REFERENCES CLIENT_ANGAJAT_FURNIZOR
                (ID_caf)
;

ALTER TABLE FACTURA
    ADD
        CONSTRAINT FK_CAF_F_angajat FOREIGN KEY
            (Id_angajat)
            REFERENCES CLIENT_ANGAJAT_FURNIZOR
                (ID_caf)
;

ALTER TABLE FACTURA
    ADD
        CONSTRAINT FK_CAF_F_beneficiar FOREIGN KEY
            (Id_benef)
            REFERENCES CLIENT_ANGAJAT_FURNIZOR
                (ID_caf)
;

ALTER TABLE Produse
    ADD
        CONSTRAINT FK_CAF_P FOREIGN KEY
            (Id_furnizor)
            REFERENCES CLIENT_ANGAJAT_FURNIZOR
                (ID_caf)
;

ALTER TABLE ITEM
    ADD
        CONSTRAINT FK_P_I FOREIGN KEY
            (Id_prod)
            REFERENCES Produse
                (Id_prod)
;

ALTER TABLE ITEM
    ADD
        CONSTRAINT FK_F_I FOREIGN KEY
            (Data_fact, Nr_fact)
            REFERENCES FACTURA
                (Data_fact, Nr)
;

ALTER TABLE CARACTERISTICA
    ADD
        CONSTRAINT FK_P_C FOREIGN KEY
            (Id_prod)
            REFERENCES Produse
                (Id_prod)
;

INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (0, 'Gheoace Mircea', null, 'c', 'Bucuresti, sector 5, str Pitulicea', 'RO95RNCB007513848271991',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (1, 'Georgescu Victor', null, 'c', 'Bucuresti, sector 4, str George Bacovia', 'RO95RNCB007513848271992',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (2, 'Curcan Ionescu', null, 'c', 'Bucuresti, sector 3, str Tudor Arghezi', 'RO95RNCB007513848271993',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (3, 'Popescu Vlad', null, 'c', 'Bucuresti, sector 2, str George Enescu', 'RO95RNCB007513848271994',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (4, 'Marin Ioana', null, 'c', 'Bucuresti, sector 1, str Vasile Alecsandri', 'RO95RNCB007513848271995',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (5, 'Popescu Violeta', null, 'a', 'Bucuresti, sector 6, str Ion Creanga', 'RO95RNCB007513848271996',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (6, 'Marinescu David', null, 'a', 'Bucuresti, sector 5, str Mihai Viteazul', 'RO95RNCB007513848271997',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (7, 'Lupescu Dana', null, 'a', 'Bucuresti, sector 5, str Mircea cel Bătrân', 'RO95RNCB007513848271998',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (8, 'Aboabei Florica', null, 'a', 'Bucuresti, sector 5, str Puțul cu tei', 'RO95RNCB007513848271998',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (9, 'Stanescu Ana', null, 'a', 'Bucuresti, sector 6, Blv Iuliu Maniu', 'RO95RNCB0075138482719910',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (10, 'Ubisoft', 'RO26747601', 'c', 'Bucuresti, sector 4, str Stoian Militaru', 'RO95RNCB007513848271911',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (11, 'Tremend', 'RO26747602', 'c', 'Bucuresti, sector 6, str Preciziei', 'RO95RNCB007513848271912',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (12, 'Oracle', 'RO26747603', 'c', 'Bucuresti, sector 6, str Moinesti', 'RO95RNCB007513848271913',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (13, 'Echipamente de securitate', 'RO26747604', 'c', 'Bucuresti, sector 6, str Valea Lunga',
        'RO95RNCB007513848271914', '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (14, 'BGS', 'RO26747605', 'c', 'Bucuresti, Sector 3, Calea Vitan nr. 293', 'RO95RNCB007513848271915',
        '1990713420044');
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (15, 'iSTYLE Băneasa', 'RO26747606', 'f', 'Bucuresti, sector 5, Sos. Bucuresti-Ploiesti, nr. 42D',
        'RO95RNCB007513848271916', null);
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (16, 'Samsung Electronics(UK)', 'RO26747607', 'f', 'UK, Isle of Man, Channel Islands or Republic of Ireland',
        'RO95RNCB007513848271917', null);
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (17, 'ROLV ONLINE SRL', 'RO26747608', 'f', 'Bulevardul Pipera, Nr. 1-IA, Corp A, Etaj 8, Judetul Ilfov',
        'RO95RNCB007513848271918', null);
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (18, 'Asus', 'RO26747609', 'f', 'Taiwan, Taipei', 'TW95RNCB007513848271919', null);
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (19, 'Acer', 'RO26747610', 'f', 'Taiwan, Taipei', 'TW95RNCB007513848271920', null);
INSERT INTO CLIENT_ANGAJAT_FURNIZOR
VALUES (20, 'MagazinIT', 'RO26747611', 'm', 'Bucuresti, Splaiul Unirii', 'RO95RNCB007513848271921', null);
COMMIT;

INSERT INTO Produse
VALUES (0, 'Iphone 13 Pro', 15, 'In magazin', 'Telefoane', 'superb');
INSERT INTO Produse
VALUES (1, 'Samsung s22 ultra', 16, 'In magazin', 'Telefoane', 'extraordianar');
INSERT INTO Produse
VALUES (2, 'Redmi Note 10s', 17, 'In depozit', 'Telefoane', 'incantator');
INSERT INTO Produse
VALUES (3, 'Asus Vivobook Pro 14', 18, 'In magazin', 'Laptopuri', 'uimitor');
INSERT INTO Produse
VALUES (4, 'Asus Zenfone 8', 18, 'In magazin', 'Telefoane', 'exuberant');
INSERT INTO Produse
VALUES (5, 'Acer Nitro 5', 19, 'In magazin', 'Laptopuri', 'superlativ');
INSERT INTO Produse
VALUES (6, 'Asus Rog Zephyrus GX501', 18, 'Indisponibil', 'Telefoane', 'gaming');
INSERT INTO Produse
VALUES (7, 'Iphone 12', 15, 'In magazin', 'Telefoane', 'stil');
INSERT INTO Produse
VALUES (8, 'Samsung A32', 16, 'In magazin', 'Telefoane', 'mid-range');
INSERT INTO Produse
VALUES (9, 'Xiaomi 12 Pro', 17, 'Retras definitiv', 'Telefoane', 'top of the line');
COMMIT;

