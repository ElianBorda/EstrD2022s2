-- a)
tripulantes :: Nave -> Set Tripulante
-- PROPOSITO: Denota los tripulantes de la nave
-- EFICIENCIA: O(S (S log S)) porque el sector que mas fuerza tiene con respecto a los costos es "tripulantesDeLosSectoresEn".
tripulantes n = let ss = sectores n
                in tripulantesDeLosSectoresEn ss n

tripulantesDeLosSectoresEn :: [Sector] -> Nave -> Set Tripulante
-- PROPOSITO: Devuelve todos los tripulantes de los sectores en una nave.
-- PRECONDICION: Los sectores existen en la nave.
-- EFICIENCIA: O(S (S log S)) teniendo S como cada sector, a cada S se le aplica "union setT1 setT2" de costo O(S log S) 
tripulantesDeLosSectoresEn [] n     = emptyS
tripulantesDeLosSectoresEn [s:ss] n = let setT1 = tripulantesDe s n
                                          setT2 = tripulantesDeLosSectoresEn ss n
                                          in union setT1 setT2


-- b)
bajaDeTripulante :: Tripulante -> Nave -> Nave
-- PROPOSITO: Elimina al tripulante de la nave.
-- PISTA: Considere reconstruir la nave sin ese tripulante.
bajaDeTripulante t n = let s  = sectorDe t n
                           ts = tripulantesDeSectorSin s n t 
                           ss = sectores n
                           n' = naveVacia ss 
                           ss'= sectorDe n'
                           in reconstruirNaveCon ss ts ss' n' s

tripulantesDeSectorSin :: Sector -> Nave -> Tripulante -> [Tripulante]
-- PROPOSITO: Devuelve todos los tripulantes que estaban en el sector de la nave sin el tripulante dado.
-- PRECONDICION: El sector esta en la nave. 
tripulantesDeSectorSin s n t = let setT = tripulantesDe s n
                                   in set2list (removeS t setT)


reconstruirNaveCon :: [Sector] -> [Tripulante] -> [Sector] -> Nave -> Sector -> Nave
-- PROPOSITO: Devuelve la nave con los sectores y sus tripulantes, asignandole a un solo sector los tripulantes dados.
-- PRECONDICION: Los sectores dados poseen tripulantes.
reconstruirNaveCon 


-- Esquema de ayuda

transportar :: [Sector] -> Nave -> [Sector] -> Nave -> Nave
-- PROPOSITO: Devuelve una nave cuyos sectores tienen los tripulantes de los sectores de otra nave.
-- PRECONDICION: ss2 tiene mas sectores que ss1.
transportar [] n1 ss2 n2            = n2
transportar (s1:ss1) n1 [s2:ss2] n2 = let ts = set2list (tripulantesDe s1 n1)
                                          in transportar ss1 n1 ss2 (agregarTripulantes ts s2 n2) 

agregarTripulantes :: [Tripulante] -> Sector -> Nave -> Nave
agregarTripulantes [] s n     = n
agregarTripulantes (t:ts) s n = agregarTripulantes ss (agregarTripulante t s n2) 