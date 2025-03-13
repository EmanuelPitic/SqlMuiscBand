--afisarea tuturor clientilor si a locatiilor evenimentelor lor
SELECT 
    cl.nume || ' ' || cl.prenume AS client_name,
    de.tip_eveniment,
    l.nume_locatie AS locatie
FROM 
    clienti cl
JOIN 
    evenimente e ON cl.id_client = e.id_client
JOIN 
    detalii_evenimente de ON e.id_eveniment = de.id_eveniment
JOIN 
    event_loc el ON e.id_eveniment = el.id_eveniment
JOIN 
    locatii l ON el.id_locatie = l.id_locatie;
    


--determinarea celor mai cantate melodii
--pentru determinarea la ce tipuri de melodii sa mai pregateasca formatia
SELECT 
    m.titlu_melodie,
    COUNT(pm.id_melodie) AS song_play_count
FROM 
    melodii m
JOIN 
    playlist_melodie pm ON m.id_melodie = pm.id_melodie
JOIN 
    eveniment_playlisturi ep ON pm.id_playlist = ep.id_playlist
JOIN 
    evenimente e ON ep.id_eveniment = e.id_eveniment
GROUP BY 
    m.titlu_melodie
ORDER BY 
    song_play_count DESC;
    

--determinarea colaboratorilor care au obtinut cele mai mari sume
--in ordine descrescatoare 
SELECT 
    c.nume || ' ' || c.prenume AS colaborator_name,
    SUM (ce.suma) as total_colaborator
FROM 
    colaboratori c
JOIN 
    colab_event ce ON c.id_colaborator = ce.id_colaborator
GROUP BY 
    c.nume, c.prenume
ORDER BY 
    total_colaborator DESC;

--determinare profit formatie
SELECT 
    SUM(DISTINCT de.pret_formatie) as venit_total,
    sum(ce.suma) as cheltuilei_colaboratori,
    SUM(DISTINCT de.pret_formatie)  - sum(ce.suma) as profit_net
FROM detalii_evenimente de
JOIN evenimente e ON e.id_eveniment = de.id_eveniment
JOIN colab_event ce ON e.id_eveniment = ce.id_eveniment;


--determinarea celor mai vizitate locatii
--pentru a folosi reclame pentru acestea
SELECT 
    l.nume_locatie,
    COUNT(e.id_eveniment) AS numar_evenimente
FROM 
    locatii l
JOIN 
    event_loc el ON l.id_locatie = el.id_locatie
JOIN 
    evenimente e ON el.id_eveniment = e.id_eveniment
GROUP BY 
    l.nume_locatie
ORDER BY 
    numar_evenimente DESC;

    
--determinarea categoriilor de evenimente
--cel mai des organizate
SELECT 
    de.tip_eveniment,
    COUNT(e.id_eveniment) AS numar_evenimente
FROM 
    detalii_evenimente de
JOIN 
    evenimente e ON de.id_eveniment = e.id_eveniment
GROUP BY 
    de.tip_eveniment
ORDER BY 
    numar_evenimente DESC;




