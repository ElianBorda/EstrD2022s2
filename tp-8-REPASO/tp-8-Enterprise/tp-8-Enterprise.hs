-- a)
tripulantes :: Nave -> Set Tripulante
-- PROPOSITO: Denota los tripulantes de la nave
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