-- a)
tripulantes :: Nave -> Set Tripulante
-- PROPOSITO: Denota los tripulantes de la nave
-- EFICIENCIA: O(S (S log S)) porque el sector que mas fuerza tiene con respecto a los costos es "tripulantesDeLosSectoresEn".
tripulantes n = let ss = sectores n
                in tripulantesDeLosSectoresEn ss n

tripulantesDeLosSectoresEn :: [Sector] -> Nave -> Set Tripulante
-- PROPOSITO: Devuelve todos los tripulantes de los sectores en una nave.
-- PRECONDICION: Los sectores existen en la nave.
-- EFICIENCIA: O(s(log S + T log T)) 
tripulantesDeLosSectoresEn [] n     = emptyS
tripulantesDeLosSectoresEn [s:ss] n = let setT1 = tripulantesDe s n
                                          setT2 = tripulantesDeLosSectoresEn ss n
                                          in union setT1 setT2

-- b)
bajaDeTripulante :: Tripulante -> Nave -> Nave
-- PROPOSITO: Elimina al tripulante de la nave.
-- PISTA: Considere reconstruir la nave sin ese tripulante.
-- PRECONDICION: El tripulante existe en la nave.
bajaDeTripulante t n = let s = sectorDe t n
                           in bajaDeTripulanteDeSector t n s

bajaDeTripulanteDeSector :: Tripulante -> Nave -> Sector -> Nave
-- PROPOSITO: Elimina al tripulante del sector dado de la nave.
-- PRECONDICION: * El tripulante esta en el sector de la nave dada.
bajaDeTripulanteDeSector t n s = let n'   = naveVacia (sectores n)
                                     setT = tripulantesDeSectorSin s n t
                                     in cambiarTripulantesDeNaveSinElSector n (agregarTripulantes setT s n') s

tripulantesDeSectorSin :: Sector -> Nave -> Tripulante -> Set Tripulante
-- PROPOSITO: Devuelve los tripulantes del sector dado en la nave dada sin el tripulante dado
tripulantesDeSectorSin s n t = let setT = tripulantesDe s n
                                   in removeS t setT

agregarTripulantes :: Set Tripulante -> Sector -> Nave -> Nave
-- PROPOSITO: Los tripulantes dados se agregan al sector de la nave dada.
-- PRECONDICION: El sector existe en la nave dada.
agregarTripulantes setT s n = let ts = set2list setT
                                  in agregarTodosLosTripulantes ts s n

agregarTodosLosTripulantes :: [Tripulante] -> Sector -> Nave -> Nave
-- PROPOSITO: Los tripulantes de la lista dada se agregan al sector de la nave dada.
-- PRECONDICION: El sector existe en la nave dada.
agregarTodosLosTripulantes [] s n     = n
agregarTodosLosTripulantes (t:ts) s n = let n' = agregarTripulante t s n
                                        in agregarTodosLosTripulantes ts s n'

cambiarTripulantesDeNaveSinElSector :: Nave -> Nave -> Sector -> Nave
-- PROPOSITO: Devuelve una nave con todos los tripulantes de n1 en n2, excepto aquellos
--            que pertenecen al sector dado
-- PRECONDICION: Ambas naves dadas poseen los mismos sectores.
cambiarTripulantesDeNaveSinElSector n1 n2 s = let ss'= sinElSector (sectores n1) s
                                                  in cambiarTripulantesDe n1 n2 ss' 

sinElSector :: [Sector] -> Sector -> [Sector]
-- PROPOSITO: Devuelve una lista de sectores sin el dado
sinElSector [] s2       = []
sinElSector (s1:ss1) s2 = if s1==s2
                             then ss1
                             else s1 : sinElSector ss1 s2                                   

cambiarTripulantesDe :: Nave -> Nave -> [Sector] -> Nave
-- PROPOSITO: Devuelve una nave con los tripulantes de n1 en n2 en los sectores dados
-- PRECONDICION: Ambas naves tienen los sectores dados
cambiarTripulantesDe n1 n2 []     = n2
cambiarTripulantesDe n1 n2 (s:ss) = let setT = tripulantesDe s n1
                                        n2'  = agregarTripulantes setT s n2 
                                        in cambiarTripulantesDe n1 n2' ss




















































-- bajaDeTripulante :: Tripulante -> Nave -> Nave
-- -- PROPOSITO: Elimina al tripulante de la nave.
-- -- PISTA: Considere reconstruir la nave sin ese tripulante.
-- bajaDeTripulante t n = let s  = sectorDe t n
--                            ts = tripulantesDeSectorSin s n t 
--                            ss = sectores n
--                            n' = naveVacia ss 
--                            ss'= sectorDe n'
--                            in reconstruirNaveCon ss ts ss' n' s

-- tripulantesDeSectorSin :: Sector -> Nave -> Tripulante -> [Tripulante]
-- -- PROPOSITO: Devuelve todos los tripulantes que estaban en el sector de la nave sin el tripulante dado.
-- -- PRECONDICION: El sector esta en la nave. 
-- tripulantesDeSectorSin s n t = let setT = tripulantesDe s n
--                                    in set2list (removeS t setT)


-- reconstruirNaveCon :: [Sector] -> [Tripulante] -> [Sector] -> Nave -> Sector -> Nave
-- -- PROPOSITO: Devuelve la nave con los sectores y sus tripulantes, asignandole a un solo sector los tripulantes dados.
-- -- PRECONDICION: Los sectores dados poseen tripulantes.
-- reconstruirNaveCon 


-- -- Esquema de ayuda

-- transportar :: [Sector] -> Nave -> [Sector] -> Nave -> Nave
-- -- PROPOSITO: Devuelve una nave cuyos sectores tienen los tripulantes de los sectores de otra nave.
-- -- PRECONDICION: ss2 tiene mas sectores que ss1.
-- transportar [] n1 ss2 n2            = n2
-- transportar (s1:ss1) n1 [s2:ss2] n2 = let ts = set2list (tripulantesDe s1 n1)
--                                           in transportar ss1 n1 ss2 (agregarTripulantes ts s2 n2) 

-- agregarTripulantes :: [Tripulante] -> Sector -> Nave -> Nave
-- agregarTripulantes [] s n     = n
-- agregarTripulantes (t:ts) s n = agregarTripulantes ss (agregarTripulante t s n2) 