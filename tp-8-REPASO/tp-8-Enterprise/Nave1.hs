module Nave1
        (Nave,naveVacia,tripulantesDe,sectores,conMayorRango,conMasTripulantes,conRango,sectorDe,agregarTripulante)
    where
        
data Nave = MkN (Map Sector (Set Tripulante)) (Heap Tripulante) (Sector, Int)
{-
    INV.REP:
            * Todos los tripulantes de todos los distintos sectores de la nave estan en (Heap Tripulante) y viseversa
            * Un tripulante esta en solamente un sector
            * Si no hay sectores asociados a ningun tripulante entonces escoje uno cualquiera  

-}

naveVacia :: [Sector] -> Nave
-- Propósito: Crea una nave con todos esos sectores sin tripulantes.
-- Precondición: la lista de sectores no está vacía
-- Costo: O(S log S) siendo S la cantidad de sectores de la lista.
naveVacia ss = MkN (assocAllM ss emptyS emptyM) emptyH (head ss, 0)

assocAllM :: [Sector] -> Set Tripulante -> Map Sector (Set Tripulante) -> Map Sector (Set Tripulante)
-- Proposito: Devuelve todos los sectores sin tripulantes asociados.
-- Costo
assocAllM (s:[]) setT mapS = assocM s setT mapS
assocAllM (s:ss) setT mapS = let mapS' = assocM s setT mapS
                                 in assocAllM ss setT mapS' 

tripulantesDe :: Sector -> Nave -> Ses de un sector.
-- Costo: O(log S) siendo S la cantet Tripulante
-- Propósito: Obtiene los tripulantidad de sectores.

sectores :: Nave -> [Sector]
-- Propósito: Denota los sectores de la nave
-- Costo: O(S) siendo S la cantidad de sectores.

conMayorRango :: Nave -> Tripulante
-- Propósito: Denota el tripulante con mayor rango.
-- Precondición: la nave no está vacía.
-- Costo: O(1).

conMasTripulantes :: Nave -> Sector
-- Propósito: Denota el sector de la nave con más tripulantes.
-- Costo: O(1).

conRango :: Rango -> Nave -> Set Tripulante
-- Propósito: Denota el conjunto de tripulantes con dicho rango.
-- Costo: O(P log P) siendo P la cantidad de tripulantes.

sectorDe :: Tripulante -> Nave -> Sector
-- Propósito: Devuelve el sector en el que se encuentra un tripulante.
-- Precondición: el tripulante pertenece a la nave.
-- Costo: O(S log S log P) siendo S la cantidad de sectores y P la cantidad de tripulantes.

agregarTripulante :: Tripulante -> Sector -> Nave -> Nave
-- Propósito: Agrega un tripulante a ese sector de la nave.
-- Precondición: El sector está en la nave y el tripulante no.
-- Costo: No hay datos (justifique su elección).