-- Generated by Oracle SQL Developer Data Modeler 24.3.0.240.1210
--   at:        2024-12-11 10:11:30 EET
--   site:      Oracle Database 11g
--   type:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE clienti (
    id_client NUMBER(4) NOT NULL,
    nume      VARCHAR2(25) NOT NULL,
    prenume   VARCHAR2(25) NOT NULL,
    telefon   VARCHAR2(12) NOT NULL,
    email     VARCHAR2(50)
);

ALTER TABLE clienti
    ADD CONSTRAINT clienti_email_ck CHECK ( REGEXP_LIKE ( email,
                                                          '^[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}$' ) );

ALTER TABLE clienti ADD CONSTRAINT clienti_pk PRIMARY KEY ( id_client );

ALTER TABLE clienti ADD CONSTRAINT clienti_email_un UNIQUE ( email );

CREATE TABLE colab_event (
    id_eveniment   NUMBER(4) NOT NULL,
    id_colaborator NUMBER(2) NOT NULL,
    suma           NUMBER(6, 2) NOT NULL
);

ALTER TABLE colab_event
    ADD CONSTRAINT colab_event_suma_negociata_ck CHECK ( suma BETWEEN 0 AND 1500 );

ALTER TABLE colab_event ADD CONSTRAINT colaboratori_eveniment_pk PRIMARY KEY ( id_eveniment,
                                                                               id_colaborator );

CREATE TABLE colaboratori (
    id_colaborator NUMBER(2) NOT NULL,
    nume           VARCHAR2(25) NOT NULL,
    prenume        VARCHAR2(25) NOT NULL,
    serviciu       VARCHAR2(25) NOT NULL,
    telefon        VARCHAR2(12) NOT NULL,
    pfa            VARCHAR2(25) NOT NULL,
    email          VARCHAR2(50)
);

ALTER TABLE colaboratori
    ADD
        CHECK ( serviciu IN ( 'DJ', 'Inginer Sunet', 'Inginer de Ilumini', 'Instrumentist', 'Solist' ) );

ALTER TABLE colaboratori
    ADD CONSTRAINT colaboratori_email_ck CHECK ( REGEXP_LIKE ( email,
                                                               '^[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}$' ) );

ALTER TABLE colaboratori ADD CONSTRAINT colaboratori_pk PRIMARY KEY ( id_colaborator );

ALTER TABLE colaboratori ADD CONSTRAINT colaboratori_email_un UNIQUE ( email );

ALTER TABLE colaboratori ADD CONSTRAINT colaboratori_pfa_un UNIQUE ( pfa );

CREATE TABLE detalii_evenimente (
    id_eveniment         NUMBER(4) NOT NULL,
    pret_formatie        NUMBER(7, 2) NOT NULL,
    tip_eveniment        VARCHAR2(50) NOT NULL,
    numar_invitati       NUMBER(4) NOT NULL,
    detalii_suplimentare VARCHAR2(50)
);

ALTER TABLE detalii_evenimente
    ADD CONSTRAINT detalii_event_pret_formatie_ck CHECK ( pret_formatie BETWEEN 3000 AND 20000 );

ALTER TABLE detalii_evenimente
    ADD CONSTRAINT det_event_tip_eveniment_ck
        CHECK ( tip_eveniment IN ( 'Bal', 'Botez', 'Cununie', 'Nunta', 'Petrecere',
                                   'Revelion' ) );

ALTER TABLE detalii_evenimente
    ADD CONSTRAINT det_ev_numar_invitati_ck CHECK ( numar_invitati BETWEEN 0 AND 1000 );

ALTER TABLE detalii_evenimente ADD CONSTRAINT detalii_evenimente_pk PRIMARY KEY ( id_eveniment );

CREATE TABLE eveniment_playlisturi (
    id_eveniment NUMBER(4) NOT NULL,
    id_playlist  VARCHAR2(30) NOT NULL
);

ALTER TABLE eveniment_playlisturi ADD CONSTRAINT eveniment_playlisturi_pk PRIMARY KEY ( id_eveniment,
                                                                                        id_playlist );

CREATE TABLE evenimente (
    id_eveniment   NUMBER(4) NOT NULL,
    id_client      NUMBER(4) NOT NULL,
    ora_inceput    DATE NOT NULL,
    ora_final      DATE NOT NULL,
    numar_invitati NUMBER(4) NOT NULL
);

ALTER TABLE evenimente ADD CONSTRAINT evenimente_pk PRIMARY KEY ( id_eveniment );

CREATE TABLE event_loc (
    id_eveniment NUMBER(4) NOT NULL,
    id_locatie   NUMBER(4) NOT NULL,
    tip_locatie  VARCHAR2(20) NOT NULL,
    ora_inceput  DATE NOT NULL,
    ora_final    DATE NOT NULL
);

ALTER TABLE event_loc ADD CONSTRAINT eveniment_locatii_pk PRIMARY KEY ( id_eveniment,
                                                                        id_locatie );

CREATE TABLE locatii (
    id_locatie      NUMBER(4) NOT NULL,
    nume_locatie    VARCHAR2(25) NOT NULL,
    adresa          VARCHAR2(50) NOT NULL,
    contact_locatie VARCHAR2(20)
);

ALTER TABLE locatii ADD CONSTRAINT locatii_pk PRIMARY KEY ( id_locatie );

CREATE TABLE melodii (
    id_melodie    NUMBER(6) NOT NULL,
    titlu_melodie VARCHAR2(20) NOT NULL,
    gama          VARCHAR2(5) NOT NULL,
    bmp           NUMBER(4, 1) NOT NULL
);

ALTER TABLE melodii
    ADD CONSTRAINT melodii_gama_ck CHECK ( REGEXP_LIKE ( gama,
                                                         '^[A-Ha-h](#|♭|b)?$' ) );

ALTER TABLE melodii
    ADD CONSTRAINT melodii_bmp_ck CHECK ( bmp BETWEEN 0 AND 200 );

ALTER TABLE melodii ADD CONSTRAINT melodii_pk PRIMARY KEY ( id_melodie );

CREATE TABLE playlist_melodie (
    id_playlist VARCHAR2(30) NOT NULL,
    id_melodie  NUMBER(6) NOT NULL
);

ALTER TABLE playlist_melodie ADD CONSTRAINT playlist_melodie_pk PRIMARY KEY ( id_playlist,
                                                                              id_melodie );

CREATE TABLE playlisturi (
    id_playlist   VARCHAR2(30) NOT NULL,
    nume_playlist VARCHAR2(50) NOT NULL,
    gen_playlist  VARCHAR2(20) NOT NULL
);

ALTER TABLE playlisturi
    ADD CONSTRAINT playlisturi_gen_playlist_ck
        CHECK ( gen_playlist IN ( 'Clasic', 'Club', 'Lent', 'Modern', 'Muzica de fundal',
                                  'Populara' ) );

ALTER TABLE playlisturi ADD CONSTRAINT playlisturi_pk PRIMARY KEY ( id_playlist );

ALTER TABLE colab_event
    ADD CONSTRAINT colaboratori_fk FOREIGN KEY ( id_colaborator )
        REFERENCES colaboratori ( id_colaborator );

ALTER TABLE evenimente
    ADD CONSTRAINT evenimente_clienti_fk FOREIGN KEY ( id_client )
        REFERENCES clienti ( id_client );

ALTER TABLE colab_event
    ADD CONSTRAINT evenimente_fk FOREIGN KEY ( id_eveniment )
        REFERENCES evenimente ( id_eveniment );

ALTER TABLE event_loc
    ADD CONSTRAINT evenimente_fkv2 FOREIGN KEY ( id_eveniment )
        REFERENCES evenimente ( id_eveniment );

ALTER TABLE detalii_evenimente
    ADD CONSTRAINT evenimente_fkv3 FOREIGN KEY ( id_eveniment )
        REFERENCES evenimente ( id_eveniment );

ALTER TABLE eveniment_playlisturi
    ADD CONSTRAINT evenimente_fkv4 FOREIGN KEY ( id_eveniment )
        REFERENCES evenimente ( id_eveniment );

ALTER TABLE event_loc
    ADD CONSTRAINT locatii_fk FOREIGN KEY ( id_locatie )
        REFERENCES locatii ( id_locatie );

ALTER TABLE playlist_melodie
    ADD CONSTRAINT melodii_fk FOREIGN KEY ( id_melodie )
        REFERENCES melodii ( id_melodie );

ALTER TABLE eveniment_playlisturi
    ADD CONSTRAINT playlisturi_fk FOREIGN KEY ( id_playlist )
        REFERENCES playlisturi ( id_playlist );

ALTER TABLE playlist_melodie
    ADD CONSTRAINT playlisturi_fkv2 FOREIGN KEY ( id_playlist )
        REFERENCES playlisturi ( id_playlist );

CREATE SEQUENCE clienti_id_client_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER clienti_id_client_trg BEFORE
    INSERT ON clienti
    FOR EACH ROW
    WHEN ( new.id_client IS NULL )
BEGIN
    :new.id_client := clienti_id_client_seq.nextval;
END;
/

CREATE SEQUENCE colaboratori_id_colaborator START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER colaboratori_id_colaborator BEFORE
    INSERT ON colaboratori
    FOR EACH ROW
    WHEN ( new.id_colaborator IS NULL )
BEGIN
    :new.id_colaborator := colaboratori_id_colaborator.nextval;
END;
/

CREATE SEQUENCE evenimente_id_eveniment_seq START WITH 1000 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER evenimente_id_eveniment_trg BEFORE
    INSERT ON evenimente
    FOR EACH ROW
    WHEN ( new.id_eveniment IS NULL )
BEGIN
    :new.id_eveniment := evenimente_id_eveniment_seq.nextval;
END;
/

CREATE SEQUENCE melodii_id_melodie_seq START WITH 25000 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER melodii_id_melodie_trg BEFORE
    INSERT ON melodii
    FOR EACH ROW
    WHEN ( new.id_melodie IS NULL )
BEGIN
    :new.id_melodie := melodii_id_melodie_seq.nextval;
END;
/

CREATE SEQUENCE playlisturi_id_playlist_seq START WITH 35000 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER playlisturi_id_playlist_trg BEFORE
    INSERT ON playlisturi
    FOR EACH ROW
    WHEN ( new.id_playlist IS NULL )
BEGIN
    :new.id_playlist := playlisturi_id_playlist_seq.nextval;
END;
/

CREATE OR REPLACE TRIGGER trg_check_event_times
BEFORE INSERT OR UPDATE ON evenimente
FOR EACH ROW
BEGIN

  IF :NEW.ora_inceput <= SYSDATE THEN
    RAISE_APPLICATION_ERROR(-20001, 'ora_inceput trebuie sa fie in viitor.');
  END IF;


  IF :NEW.ora_final <= :NEW.ora_inceput THEN
    RAISE_APPLICATION_ERROR(-20002, 'ora_final trebuie sa fie mai mare decat ora_inceput.');
  END IF;
END;



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             34
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           5
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          5
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
