--clienti

INSERT INTO clienti (nume, prenume, telefon, email)
VALUES ('Popescu', 'Ion', '0712345678', 'ion.popescu@example.com');
	
INSERT INTO clienti (nume, prenume, telefon, email)
VALUES ('Ionescu', 'Maria', '0722345678', 'maria.ionescu@example.com');

INSERT INTO clienti (nume, prenume, telefon, email)
VALUES ('Marinescu', 'Ioana', '0731234567', 'ioana.marinescu@example.com');

INSERT INTO clienti (nume, prenume, telefon, email)
VALUES ('Dumitru', 'Victor', '0745234567', 'victor.dumitru@example.com');

INSERT INTO clienti (nume, prenume, telefon, email)
VALUES ('Ciobanu', 'Ana', '0756234567', 'ana.ciobanu@example.com');



--colaboratori
INSERT INTO colaboratori (nume, prenume, serviciu, telefon, pfa, email)
VALUES ('Georgescu', 'Alex', 'DJ', '0734567890', 'DJAlexPFA', 'dj.alex@example.com');

INSERT INTO colaboratori (nume, prenume, serviciu, telefon, pfa, email)
VALUES ('Popa', 'Andrei', 'Inginer Sunet', '0745678901', 'SoundEngineerPFA', 'sound.andrei@example.com');

INSERT INTO colaboratori (nume, prenume, serviciu, telefon, pfa, email)
VALUES ('Vasilescu', 'Elena', 'Solist', '0756789012', 'ElenaSingerPFA', 'elena.vasilescu@example.com');

INSERT INTO colaboratori (nume, prenume, serviciu, telefon, pfa, email)
VALUES ('Pitic', 'Emanuel', 'Instrumentist', '0767890123', 'EmanuelInstrumentistPFA', 'emanuel.pitic@student.tuiasi.ro');

INSERT INTO colaboratori (nume, prenume, serviciu, telefon, pfa, email)
VALUES ('Pitic', 'Sebastian', 'Instrumentist', '0767890456', 'SebastianInstrumentistPFA', 'sebastian.pitic@student.tuiasi.ro');

--locatii
INSERT INTO locatii (id_locatie, nume_locatie, adresa, contact_locatie)
VALUES (1, 'Locatie Nunta', 'Strada Nunti, nr. 10', '0734000000');

INSERT INTO locatii (id_locatie, nume_locatie, adresa, contact_locatie)
VALUES (2, 'Locatie Botez', 'Strada Botezuri, nr. 15', '0734555555');

INSERT INTO locatii (id_locatie, nume_locatie, adresa, contact_locatie)
VALUES (3, 'Sala Deluxe', 'Strada Evenimente, nr. 20', '0744555555');

INSERT INTO locatii (id_locatie, nume_locatie, adresa, contact_locatie)
VALUES (4, 'Gradina Eden', 'Strada Paradis, nr. 5', '0734999999');

INSERT INTO locatii (id_locatie, nume_locatie, adresa, contact_locatie)
VALUES (5, 'Terrace Lux', 'Strada Panoramei, nr. 18', '0744333333');


--evenimente
INSERT INTO evenimente (id_client, ora_inceput, ora_final, numar_invitati)
VALUES (
    (SELECT id_client FROM clienti WHERE email = 'ion.popescu@example.com'),
    TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-05-16 02:00', 'YYYY-MM-DD HH24:MI'),
    120
);

INSERT INTO evenimente (id_client, ora_inceput, ora_final, numar_invitati)
VALUES (
    (SELECT id_client FROM clienti WHERE email = 'maria.ionescu@example.com'),
    TO_DATE('2025-06-20 17:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-06-21 01:00', 'YYYY-MM-DD HH24:MI'),
    80
);

INSERT INTO evenimente (id_client, ora_inceput, ora_final, numar_invitati)
VALUES (
    (SELECT id_client FROM clienti WHERE email = 'ion.popescu@example.com'),
    TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-07-10 18:00', 'YYYY-MM-DD HH24:MI'),
    90
);
INSERT INTO evenimente (id_client, ora_inceput, ora_final, numar_invitati)
VALUES (
    (SELECT id_client FROM clienti WHERE email = 'ioana.marinescu@example.com'),
    TO_DATE('2025-08-15 19:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-08-16 01:00', 'YYYY-MM-DD HH24:MI'),
    150
);

INSERT INTO evenimente (id_client, ora_inceput, ora_final, numar_invitati)
VALUES (
    (SELECT id_client FROM clienti WHERE email = 'victor.dumitru@example.com'),
    TO_DATE('2025-09-10 17:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-09-10 23:00', 'YYYY-MM-DD HH24:MI'),
    100
);



--detalii evenimente
INSERT INTO detalii_evenimente (id_eveniment, pret_formatie, tip_eveniment, numar_invitati)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:MI')),
    7000, 'Nunta', 120
);

INSERT INTO detalii_evenimente (id_eveniment, pret_formatie, tip_eveniment, numar_invitati)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-06-20 17:00', 'YYYY-MM-DD HH24:MI')),
    5000, 'Botez', 80
);

INSERT INTO detalii_evenimente (id_eveniment, pret_formatie, tip_eveniment, numar_invitati)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI')),
    6000, 'Botez', 90
);

INSERT INTO detalii_evenimente (id_eveniment, pret_formatie, tip_eveniment, numar_invitati)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-08-15 19:00', 'YYYY-MM-DD HH24:MI')),
    7500, 'Nunta', 150
);

INSERT INTO detalii_evenimente (id_eveniment, pret_formatie, tip_eveniment, numar_invitati)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-09-10 17:00', 'YYYY-MM-DD HH24:MI')),
    6500, 'Petrecere', 100
);


--evenimente-locatii
INSERT INTO event_loc (id_eveniment, id_locatie, tip_locatie, ora_inceput, ora_final)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:MI')),
    1, 'Sala de Nunti',
    TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-05-16 02:00', 'YYYY-MM-DD HH24:MI')
);

INSERT INTO event_loc (id_eveniment, id_locatie, tip_locatie, ora_inceput, ora_final)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-06-20 17:00', 'YYYY-MM-DD HH24:MI')),
    2, 'Sala de Botezuri',
    TO_DATE('2025-06-20 17:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-06-21 01:00', 'YYYY-MM-DD HH24:MI')
);

INSERT INTO event_loc (id_eveniment, id_locatie, tip_locatie, ora_inceput, ora_final)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI')),
    1, 'Sala de Nunti',
    TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-07-10 15:00', 'YYYY-MM-DD HH24:MI')
);

INSERT INTO event_loc (id_eveniment, id_locatie, tip_locatie, ora_inceput, ora_final)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI')),
    3, 'Sala Deluxe',
    TO_DATE('2025-07-10 15:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-07-10 18:00', 'YYYY-MM-DD HH24:MI')
);

INSERT INTO event_loc (id_eveniment, id_locatie, tip_locatie, ora_inceput, ora_final)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-08-15 19:00', 'YYYY-MM-DD HH24:MI')),
    4, 'Gradina Eden',
    TO_DATE('2025-08-15 19:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-08-16 01:00', 'YYYY-MM-DD HH24:MI')
);

INSERT INTO event_loc (id_eveniment, id_locatie, tip_locatie, ora_inceput, ora_final)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-09-10 17:00', 'YYYY-MM-DD HH24:MI')),
    5, 'Terrace Lux',
    TO_DATE('2025-09-10 17:00', 'YYYY-MM-DD HH24:MI'),
    TO_DATE('2025-09-10 23:00', 'YYYY-MM-DD HH24:MI')
);


--colab-evenimente
--1
INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Georgescu' AND prenume = 'Alex'),
    1200
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Popa' AND prenume = 'Andrei'),
    1000
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Vasilescu' AND prenume = 'Elena'),
    800
);
--2
INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-06-20 17:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Popa' AND prenume = 'Andrei'),
    300
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-06-20 17:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Pitic' AND prenume = 'Emanuel'),
    1150
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-06-20 17:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Pitic' AND prenume = 'Sebastian'),
    1050
);
--3

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Vasilescu' AND prenume = 'Elena'),
    850
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Pitic' AND prenume = 'Emanuel'),
    1150
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Pitic' AND prenume = 'Sebastian'),
    1050
);
--4
INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-08-15 19:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Popa' AND prenume = 'Andrei'),
    300
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-08-15 19:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Georgescu' AND prenume = 'Alex'),
    1150
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-08-15 19:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Vasilescu' AND prenume = 'Elena'),
    1050
);
--5
INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-09-10 17:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Pitic' AND prenume = 'Emanuel'),
    450
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-09-10 17:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Pitic' AND prenume = 'Sebastian'),
    150
);

INSERT INTO colab_event (id_eveniment, id_colaborator, suma)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-09-10 17:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_colaborator FROM colaboratori WHERE nume = 'Vasilescu' AND prenume = 'Elena'),
    100
);

--melodii
INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Song of Joy', 'C', 120);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Summer Vibes', 'G', 130);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Romantic Ballad', 'A', 90);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Rock Anthem', 'E', 140);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Evening Serenade', 'D', 100);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Pop Hit', 'F', 125);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Classical Piece', 'Bb', 80);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Dance Fever', 'A#', 150);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Jazz Groove', 'Eb', 110);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Chill Out', 'C#', 95);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Hora Miresii', 'G', 120);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Ciuleandra', 'A', 140);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Sarba Olteneasca', 'D', 130);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Cantec de Petrecere', 'C', 110);

INSERT INTO melodii (titlu_melodie, gama, bmp)
VALUES ('Doina Dunarii', 'F', 90);


-- playlist
INSERT INTO playlisturi (nume_playlist, gen_playlist)
VALUES ('Muzica de Taraf', 'Populara');

INSERT INTO playlisturi (nume_playlist, gen_playlist)
VALUES ('Upbeat Tunes', 'Modern');

INSERT INTO playlisturi (nume_playlist, gen_playlist)
VALUES ('Wedding Classics', 'Clasic');

INSERT INTO playlisturi (nume_playlist, gen_playlist)
VALUES ('Party Hits', 'Modern');

INSERT INTO playlisturi (nume_playlist, gen_playlist)
VALUES ('Relaxing Tunes', 'Muzica de fundal');

-- "Wedding Classics"
INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Wedding Classics'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Romantic Ballad')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Wedding Classics'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Evening Serenade')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Wedding Classics'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Classical Piece')
);

-- "Party Hits"
INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Party Hits'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Rock Anthem')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Party Hits'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Dance Fever')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Party Hits'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Pop Hit')
);

-- "Relaxing Tunes"
INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Relaxing Tunes'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Chill Out')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Relaxing Tunes'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Jazz Groove')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Relaxing Tunes'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Song of Joy')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Muzica de Taraf'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Hora Miresii')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Muzica de Taraf'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Ciuleandra')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Muzica de Taraf'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Sarba Olteneasca')
);


INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Muzica de Taraf'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Cantec de Petrecere')
);

INSERT INTO playlist_melodie (id_playlist, id_melodie)
VALUES (
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Muzica de Taraf'),
    (SELECT id_melodie FROM melodii WHERE titlu_melodie = 'Doina Dunarii')
);



--eveniment_playlist

-- "Wedding Classics" la "Nunta" 
-- "Wedding Classics" la "Nunta" 
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:Mi')),
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Wedding Classics')
);

--  "Party Hits" la "Nunta"
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-05-15 18:00', 'YYYY-MM-DD HH24:Mi')),
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Party Hits')
);

-- "Relaxing Tunes" la "Botez" 
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE id_client = 
        (SELECT id_client FROM clienti WHERE nume = 'Ionescu')),
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Relaxing Tunes')
);

--  "Party Hits" la "Botez" 
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE id_client = 
        (SELECT id_client FROM clienti WHERE nume = 'Ionescu')),
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Party Hits')
);
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
VALUES (
    (SELECT id_eveniment FROM evenimente WHERE ora_inceput = TO_DATE('2025-07-10 12:00', 'YYYY-MM-DD HH24:MI')),
    (SELECT id_playlist FROM playlisturi WHERE nume_playlist = 'Relaxing Tunes')
);

-- Muzica de Taraf la toate Nuntile
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
SELECT e.id_eveniment, p.id_playlist
FROM evenimente e
JOIN detalii_evenimente de ON e.id_eveniment = de.id_eveniment
JOIN playlisturi p ON p.nume_playlist = 'Muzica de Taraf'
WHERE de.tip_eveniment = 'Nunta';

-- Muzica de Taraf la toate Botez
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
SELECT e.id_eveniment, p.id_playlist
FROM evenimente e
JOIN detalii_evenimente de ON e.id_eveniment = de.id_eveniment
JOIN playlisturi p ON p.nume_playlist = 'Muzica de Taraf'
WHERE de.tip_eveniment = 'Botez';

-- Muzica de Taraf la Petrecere
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
SELECT e.id_eveniment, p.id_playlist
FROM evenimente e
JOIN detalii_evenimente de ON e.id_eveniment = de.id_eveniment
JOIN playlisturi p ON p.nume_playlist = 'Muzica de Taraf'
WHERE de.tip_eveniment = 'Petrecere';

-- Party Hits la Petrecere
INSERT INTO eveniment_playlisturi (id_eveniment, id_playlist)
SELECT e.id_eveniment, p.id_playlist
FROM evenimente e
JOIN detalii_evenimente de ON e.id_eveniment = de.id_eveniment
JOIN playlisturi p ON p.nume_playlist = 'Party Hits'
WHERE de.tip_eveniment = 'Petrecere';




