-- 1. Testare PK: Încercare de adăugare a unui client cu același ID
-- Așteptat: ORA-00001: unique constraint (CLIENTI_PK) violated
INSERT INTO clienti (id_client, nume, prenume, telefon, email)
VALUES (1, 'Test', 'Duplicat', '0712345678', 'test.duplicat@example.com');
--Error report -ORA-00001: unique constraint (BDP.CLIENTI_PK) violated


--2.  Testare NN: Încercare de adăugare a unui colaborator fără nume
--Așteptat: ORA-01400: cannot insert NULL into ("COLABORATORI"."NUME")
INSERT INTO colaboratori ( prenume, serviciu, telefon, pfa, email)
VALUES ( 'Test', 'Inginer Sunet', '0723456789', 'TestPFA', 'test.pfa@example.com')
-- Eroare primita: Error report -ORA-01400: cannot insert NULL into ("BDP"."COLABORATORI"."NUME")

--3. Testare UK: Încercare de adăugare a unui client cu email duplicat
--Așteptat: ORA-00001: unique constraint (CLIENTI_EMAIL_UN) violated
INSERT INTO clienti (id_client, nume, prenume, email, telefon, data_eveniment)
VALUES (3001, 'Popescu', 'Mircea', 'ion.popescu@example.com', '0723456789', TO_DATE('2025-06-01', 'YYYY-MM-DD'));
-- Eroare primita: Error report -ORA-00001: unique constraint (BDP.CLIENTI_EMAIL_UN) violated
--aceasta apare si la colaboratori

--4. Testare CK: Încercare de adăugare a unui preț negativ pentru colaborator
--Așteptat: ORA-02290: check constraint (COL_EV_SUMA_NEGOCIATA_CK) violated
INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (40000, 1, -2000);
-- Eroare primita: Error report -ORA-02290: check constraint (BDP.COLAB_EVENT_SUMA_NEGOCIATA_CK) violated

--5. Testare FK: Încercare de adăugare a unui eveniment cu un client inexistent
--Așteptat: ORA-02291: integrity constraint (EVENIMENTE_CLIENTI_FK) violated
INSERT INTO evenimente (id_eveniment, id_client, ora_inceput, ora_final, numar_invitati)
VALUES (3, 9999, TO_DATE('2025-06-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2025-06-01 23:00:00', 'YYYY-MM-DD HH24:MI:SS'), 100);
-- Eroare primita: Error report -ORA-02291: integrity constraint (BDP.EVENIMENTE_CLIENTI_FK) violated - parent key not found

--6 Testare Regex: Incercare de adaugare client cu email fals:
--Așteptat: ORA-02290: check constraint (BDP.CLIENTI_EMAIL_CK) violated
INSERT INTO clienti ( nume, prenume, telefon, email)
VALUES ( 'Test', 'Duplicat', '0712345678', 'test.duplicat');
--Eroare primita: Error report - ORA-02290: check constraint (BDP.CLIENTI_EMAIL_CK) violated

--7 Testare UK: testare de UK de PFA
--Așteptat:ORA-00001: unique constraint (BDP.COLABORATORI_PFA_UN) violated
insert into colaboratori (id_colaborator, nume, prenume, serviciu, telefon, pfa, email)
values
(10, '1', '2', 'DJ', '0749598182', 'DJAlexPFA', 'proba@email.csk');
--Eroare primita: Error report - ORA-00001: unique constraint (BDP.COLABORATORI_PFA_UN) violated
--apare si la clienti

--8 Testare CK: verifica regex gama melodie
--Asteptat: ORA-02290: check constraint (BDP.MELODII_GAMA_CK) violated
insert into melodii (titlu_melodie, gama, bmp)
values ('PROBA', 'asdfg', 200);
--Eroare primita: Error report -ORA-02290: check constraint (BDP.MELODII_GAMA_CK) violated


--9 Testare CK: verifica bmp gama melodie
--Asteptat:ORA-02290: check constraint (BDP.MELODII_BMP_CK) violated
insert into melodii (titlu_melodie, gama, bmp)
values ('PROBA', 'A', 250);
--Eroare primita:  Error report -ORA-02290: check constraint (BDP.MELODII_BMP_CK) violated

--10 Testare Ck: Playlist de tip invalid
--Asteptat:ORA-02290: check constraint (BDP.PLAYLISTURI_GEN_PLAYLIST_CK) violated
insert into melodii (titlu_melodie, gama, bmp)
values ('PROBA', 'A', 250);
--Eroare primita:  Error report -ORA-02290: check constraint BDP.PLAYLISTURI_GEN_PLAYLIST_CK) violated


--11 Testare ck: Eveniment de tip ivalid
-- proba
--Asteptat:ORA-02290: check constraint (BDP.DET_EVENT_TIP_EVENIMENT_CK) violated
INSERT INTO evenimente (id_client, ora_inceput, ora_final, numar_invitati)
VALUES (
    (SELECT id_client FROM clienti WHERE email = 'ion.popescu@example.com'),
    TO_DATE('2025-06-15 18:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-06-16 02:00', 'YYYY-MM-DD HH24:MI'),
    120
);
INSERT INTO detalii_evenimente (id_eveniment, pret_formatie, tip_eveniment, numar_invitati)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-06-15 18:00', 'YYYY-MM-DD HH24:MI')),
    7000, 'PROBA', 120
);
--si acuma stergem intrarile
delete from evenimente where ora_inceput = TO_DATE('2025-06-15 18:00', 'YYYY-MM-DD HH24:MI');
--Primit: ORA-02290: check constraint (BDP.DET_EVENT_TIP_EVENIMENT_CK) violated


--12 --testare sysdate pentru ora_inceput si ora_final
--testare ora_inceput > SYSDATE
insert into evenimente(id_client, ora_inceput, ora_final, numar_invitati)
values
(1, SYSDATE - 1, SYSDATE + 1, 190);
--eroare asteptata la trigger
--SQL Error: ORA-20001: ora_inceput trebuie sa fie in viitor.
--ORA-06512: at "BDP.TRG_CHECK_EVENT_TIMES", line 4
--ORA-04088: error during execution of trigger 'BDP.TRG_CHECK_EVENT_TIMES'

--13--testare ora_final > ora_inceput
insert into evenimente(id_client, ora_inceput, ora_final, numar_invitati)
values
(1, SYSDATE + 2, SYSDATE + 1, 190);
--eroare asteptata la trigger
--SQL Error: ORA-20002: ora_final trebuie sa fie mai mare decat ora_inceput.
--ORA-06512: at "BDP.TRG_CHECK_EVENT_TIMES", line 9
--ORA-04088: error during execution of trigger 'BDP.TRG_CHECK_EVENT_TIMES'


--14-- Testare ck: Suma formatie
--Asteptat:ORA-02290: check constraint (BDP.DETALII_EVENT_PRET_FORMATIE_CK) violated --intre 2000 si 
INSERT INTO evenimente (id_client, ora_inceput, ora_final, numar_invitati)
VALUES (
    (SELECT id_client FROM clienti WHERE email = 'ion.popescu@example.com'),
    TO_DATE('2025-06-15 18:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-06-16 02:00', 'YYYY-MM-DD HH24:MI'),
    120
);
INSERT INTO detalii_evenimente (id_eveniment, pret_formatie, tip_eveniment, numar_invitati)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-06-15 18:00', 'YYYY-MM-DD HH24:MI')),
    0,'Nunta', 120
);
--si acuma stergem intrarile
delete from evenimente where ora_inceput = TO_DATE('2025-06-15 18:00', 'YYYY-MM-DD HH24:MI');

--Eroare primita:  Error report -ORA-02290: check constraint  (BDP.DETALII_EVENT_PRET_FORMATIE_CK) violated

--15 Testare FK: Încercare de adăugare a unei legaturi colab_event cu colaborator inexistent
--Așteptat: ORA-02291: integrity constraint (COLABORATORI_FK) violated
insert into colab_event 
values (1, 99, 100);
-- Eroare primita: Error report -ORA-02291: integrity constraint (BDP.COLABORATORI_FK) violated - parent key not found


--16 Testare FK: Încercare de adăugare a unui detalii_eveniment cu eveniment inexistent
--Așteptat: ORA-02291: integrity constraint (EVENIMENTE_FKV3) violated
insert into detalii_evenimente
values(1, 5000, 'Nunta', 150, 'Proba sa vedem ca nu merge');
-- Eroare primita: Error report -ORA-02291: integrity constraint (BDP.EVENIMENTE_FKV3) violated - parent key not found


--17 Testare FK: Încercare de adăugare a unei legaturi event_loc cu locatie inexistenta
--Așteptat: ORA-02291: integrity constraint (LOCATII_FK) violated
insert into event_loc
values(1001, 99, 'Salon', SYSDATE+1, SYSDATE+2);
-- Eroare primita: Error report -ORA-02291: integrity constraint (BDP.LOCATII_FK) violated - parent key not found


--18 Testare FK: Incercare inserare in PLAYLIST_MELODIE cu id melodie fals, apoi cu id playlist fals
--a) melodii
--Așteptat: ORA-02291: integrity constraint (MELODII_FK) violated
insert into PLAYLIST_MELODIE
values(35000, 1);
-- Eroare primita: Error report -ORA-02291: integrity constraint (BDP.MELODII_FK) violated - parent key not found
--b) playlist
--Așteptat: ORA-02291: integrity constraint (PLAYLISTURI_FKV2) violated
insert into PLAYLIST_MELODIE
values(1, 25000);
-- Eroare primita: Error report -ORA-02291: integrity constraint (BDP.PLAYLISTURI) violated - parent key not found

--19 Testare Ck: Incercare inserare tip invalid de Playlsit
--Asteptat:ORA-02290: check constraint (BDP.MELODII_BMP_CK) violated
INSERT INTO playlisturi (nume_playlist, gen_playlist)
VALUES ('Proba', 'De Proba');
-- Eroare primita: Error report -ORA-02290: check constraint (BDP.PLAYLISTURI_GEN_PLAYLIST_CK) violated











