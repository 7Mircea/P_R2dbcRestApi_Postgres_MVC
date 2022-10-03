ALTER TABLE IF EXISTS INVOICE
    DROP CONSTRAINT IF EXISTS FK_CES_IN_VENDOR;
ALTER TABLE IF EXISTS INVOICE
    DROP CONSTRAINT IF EXISTS FK_CES_IN_EMPLOYEE;
ALTER TABLE IF EXISTS INVOICE
    DROP CONSTRAINT IF EXISTS FK_CES_IN_BUYER;
ALTER TABLE IF EXISTS PRODUCTS
    DROP CONSTRAINT IF EXISTS FK_CES_P;
ALTER TABLE IF EXISTS ITEM
    DROP CONSTRAINT IF EXISTS FK_P_IT;
ALTER TABLE IF EXISTS ITEM
    DROP CONSTRAINT IF EXISTS FK_IN_IT;
ALTER TABLE IF EXISTS CHARACTERISTIC
    DROP CONSTRAINT IF EXISTS FK_P_C;
DROP TABLE IF EXISTS CUSTOMER_EMPLOYEE_SUPPLIER;
DROP TABLE IF EXISTS PRODUCTS;
DROP TABLE IF EXISTS CHARACTERISTIC;
DROP TABLE IF EXISTS INVOICE;
DROP TABLE IF EXISTS ITEM;

CREATE TABLE CUSTOMER_EMPLOYEE_SUPPLIER
(
    id_ces   INTEGER                NOT NULL,
    name     CHARACTER VARYING(40)  NOT NULL,
    EIN      CHARACTER VARYING(10)  NULL,
    type_ces CHAR(1)                NOT NULL,
    address  CHARACTER VARYING(100) NULL,
    IBAN     CHARACTER VARYING(34)  NOT NULL,
    SSN      CHARACTER VARYING(13)  NULL,
    CONSTRAINT PK_CUSTOMER_EMPLOYEE_SUPPLIER PRIMARY KEY (id_ces)
)
;

CREATE TABLE INVOICE
(
    nr           INTEGER       NOT NULL,
    invoice_date DATE          NOT NULL,
    id_vendor    INTEGER       NOT NULL,
    type         CHAR(1)       NOT NULL,
    value        decimal(9, 2) NOT NULL,
    VAT          decimal(9, 2) NOT NULL,
    id_employee  INTEGER       NOT NULL,
    id_buyer     INTEGER       NOT NULL,
    CONSTRAINT PK_INVOICE PRIMARY KEY (invoice_date, nr)
)
;

CREATE TABLE PRODUCTS
(
    id_prod      INTEGER                NOT NULL,
    prod_name    CHARACTER VARYING(50)  NOT NULL,
    id_supplier  INTEGER                NOT NULL,
    availability CHARACTER VARYING(20)  NOT NULL,
    category     CHARACTER VARYING(20)  NOT NULL,
    add_info     CHARACTER VARYING(100) NULL,
    CONSTRAINT PK_PRODUCTS PRIMARY KEY (id_prod)
)
;

CREATE TABLE ITEM
(
    invoice_nr   INTEGER              NOT NULL,
    invoice_date DATE                 NOT NULL,
    id_item      INTEGER              NOT NULL,
    id_prod      INTEGER              NOT NULL,
    unit         CHARACTER VARYING(5) NOT NULL,
    quantity     INTEGER              NOT NULL,
    unit_price   decimal(7, 2)        NOT NULL,
    CONSTRAINT PK_ITEM PRIMARY KEY (invoice_nr, invoice_date, id_item)
)
;

CREATE TABLE CHARACTERISTIC
(
    id_prod           INTEGER                NOT NULL,
    id_characteristic INTEGER                NOT NULL,
    name              CHARACTER VARYING(50)  NOT NULL,
    value             CHARACTER VARYING(150) NOT NULL,
    CONSTRAINT PK_CHARACTERISTIC PRIMARY KEY (id_prod, id_characteristic)
)
;

ALTER TABLE INVOICE
    ADD
        CONSTRAINT FK_CES_IN_VENDOR FOREIGN KEY
            (id_vendor)
            REFERENCES CUSTOMER_EMPLOYEE_SUPPLIER
                (id_ces)
;

ALTER TABLE INVOICE
    ADD
        CONSTRAINT FK_CES_IN_EMPLOYEE FOREIGN KEY
            (id_employee)
            REFERENCES CUSTOMER_EMPLOYEE_SUPPLIER
                (id_ces)
;

ALTER TABLE INVOICE
    ADD
        CONSTRAINT FK_CES_IN_BUYER FOREIGN KEY
            (id_buyer)
            REFERENCES CUSTOMER_EMPLOYEE_SUPPLIER
                (id_ces)
;

ALTER TABLE PRODUCTS
    ADD
        CONSTRAINT FK_CES_P FOREIGN KEY
            (id_supplier)
            REFERENCES CUSTOMER_EMPLOYEE_SUPPLIER
                (id_ces)
;

ALTER TABLE ITEM
    ADD
        CONSTRAINT FK_P_IT FOREIGN KEY
            (id_prod)
            REFERENCES PRODUCTS
                (id_prod)
;

ALTER TABLE ITEM
    ADD
        CONSTRAINT FK_IN_IT FOREIGN KEY
            (invoice_date, invoice_nr)
            REFERENCES INVOICE
                (invoice_date, nr)
;

ALTER TABLE CHARACTERISTIC
    ADD
        CONSTRAINT FK_P_C FOREIGN KEY
            (id_prod)
            REFERENCES PRODUCTS
                (id_prod)
;

INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (0, 'Gheoace Mircea', null, 'c', 'Bucuresti, sector 5, str Pitulicea', 'RO95RNCB007513848271991',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (1, 'Georgescu Victor', null, 'c', 'Bucuresti, sector 4, str George Bacovia', 'RO95RNCB007513848271992',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (2, 'Curcan Ionescu', null, 'c', 'Bucuresti, sector 3, str Tudor Arghezi', 'RO95RNCB007513848271993',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (3, 'Popescu Vlad', null, 'c', 'Bucuresti, sector 2, str George Enescu', 'RO95RNCB007513848271994',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (4, 'Marin Ioana', null, 'c', 'Bucuresti, sector 1, str Vasile Alecsandri', 'RO95RNCB007513848271995',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (5, 'Popescu Violeta', null, 'a', 'Bucuresti, sector 6, str Ion Creanga', 'RO95RNCB007513848271996',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (6, 'Marinescu David', null, 'a', 'Bucuresti, sector 5, str Mihai Viteazul', 'RO95RNCB007513848271997',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (7, 'Lupescu Dana', null, 'a', 'Bucuresti, sector 5, str Mircea cel Bătrân', 'RO95RNCB007513848271998',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (8, 'Aboabei Florica', null, 'a', 'Bucuresti, sector 5, str Puțul cu tei', 'RO95RNCB007513848271998',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (9, 'Stanescu Ana', null, 'a', 'Bucuresti, sector 6, Blv Iuliu Maniu', 'RO95RNCB0075138482719910',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (10, 'Ubisoft', 'RO26747601', 'c', 'Bucuresti, sector 4, str Stoian Militaru', 'RO95RNCB007513848271911',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (11, 'Tremend', 'RO26747602', 'c', 'Bucuresti, sector 6, str Preciziei', 'RO95RNCB007513848271912',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (12, 'Oracle', 'RO26747603', 'c', 'Bucuresti, sector 6, str Moinesti', 'RO95RNCB007513848271913',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (13, 'Echipamente de securitate', 'RO26747604', 'c', 'Bucuresti, sector 6, str Valea Lunga',
        'RO95RNCB007513848271914', '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (14, 'BGS', 'RO26747605', 'c', 'Bucuresti, Sector 3, Calea Vitan nr. 293', 'RO95RNCB007513848271915',
        '1990713420044');
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (15, 'iSTYLE Băneasa', 'RO26747606', 'f', 'Bucuresti, sector 5, Sos. Bucuresti-Ploiesti, nr. 42D',
        'RO95RNCB007513848271916', null);
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (16, 'Samsung Electronics(UK)', 'RO26747607', 'f', 'UK, Isle of Man, Channel Islands or Republic of Ireland',
        'RO95RNCB007513848271917', null);
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (17, 'ROLV ONLINE SRL', 'RO26747608', 'f', 'Bulevardul Pipera, Nr. 1-IA, Corp A, Etaj 8, Judetul Ilfov',
        'RO95RNCB007513848271918', null);
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (18, 'Asus', 'RO26747609', 'f', 'Taiwan, Taipei', 'TW95RNCB007513848271919', null);
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (19, 'Acer', 'RO26747610', 'f', 'Taiwan, Taipei', 'TW95RNCB007513848271920', null);
INSERT INTO CUSTOMER_EMPLOYEE_SUPPLIER
VALUES (20, 'MagazinIT', 'RO26747611', 'm', 'Bucuresti, Splaiul Unirii', 'RO95RNCB007513848271921', null);
COMMIT;

INSERT INTO PRODUCTS
VALUES (0, 'Iphone 13 Pro', 15, 'In magazin', 'Telefoane', 'superb');
INSERT INTO PRODUCTS
VALUES (1, 'Samsung s22 ultra', 16, 'In magazin', 'Telefoane', 'extraordianar');
INSERT INTO PRODUCTS
VALUES (2, 'Redmi Note 10s', 17, 'In depozit', 'Telefoane', 'incantator');
INSERT INTO PRODUCTS
VALUES (3, 'Asus Vivobook Pro 14', 18, 'In magazin', 'Laptopuri', 'uimitor');
INSERT INTO PRODUCTS
VALUES (4, 'Asus Zenfone 8', 18, 'In magazin', 'Telefoane', 'exuberant');
INSERT INTO PRODUCTS
VALUES (5, 'Acer Nitro 5', 19, 'In magazin', 'Laptopuri', 'superlativ');
INSERT INTO PRODUCTS
VALUES (6, 'Asus Rog Zephyrus GX501', 18, 'Indisponibil', 'Telefoane', 'gaming');
INSERT INTO PRODUCTS
VALUES (7, 'Iphone 12', 15, 'In magazin', 'Telefoane', 'stil');
INSERT INTO PRODUCTS
VALUES (8, 'Samsung A32', 16, 'In magazin', 'Telefoane', 'mid-range');
INSERT INTO PRODUCTS
VALUES (9, 'Xiaomi 12 Pro', 17, 'Retras definitiv', 'Telefoane', 'top of the line');
COMMIT;

