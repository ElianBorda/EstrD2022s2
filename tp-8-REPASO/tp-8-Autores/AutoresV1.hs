module AutoresV1
        (Organizador,nuevo,agregarPrograma,todosLosProgramas,autoresDe,programasDe,programaronJuntas,nroProgramasDePersona)
    where

data Organizador = MkO (Map Checksum (Set Persona)) (Map Persona (Set Checksum))

nuevo :: Organizador
-- Propósito: Un organizador vacío.
-- Eficiencia: O(1)
nuevo = MkO emptyM emptyM

agregarPrograma :: Organizador -> Checksum -> Set Persona -> Organizador
-- Propósito: Agrega al organizador un programa con el Checksum indicado; el conjunto es el conjunto de personas autores
-- de dicho programa.
-- Precondición: el identificador del programa que se agrega no fue usado previamente en el organizador, y el Set de personas
-- no está vacío.
-- Eficiencia: O(log C + P log P), O(log C) en (assocM c sp m1)

agregarPrograma (MkO m1 m2) c sp = let ps = set2List sp
                                       in MkO (assocM c sp m1) (agregarAPersonasElChecksum c ps m2)

agregarAPersonasElChecksum :: Checksum -> [Persona] -> Map Persona (Set Checksum) -> Map Persona (Set Checksum)
agregarAPersonasElChecksum c [] m2     = m2
agregarAPersonasElChecksum c (p:ps) m2 = agregarAPersonasElChecksum c ps (assocM p c m2)

todosLosProgramas :: Organizador -> [Checksum]
-- Propósito: denota una lista con todos y cada uno de los códigos identificadores de programas del organizador.
-- Eficiencia: O(C) en peor caso, donde C es la cantidad de códigos en el organizador.

autoresDe :: Organizador -> Checksum -> Set Persona
-- Propósito: denota el conjunto de autores que aparecen en un programa determinado.
-- Precondición: el Checksum debe corresponder a un programa del organizador.
-- Eficiencia: O(log C) en peor caso, donde C es la cantidad total de programas del organizador.

programasDe :: Organizador -> Persona -> Set Checksum
-- Propósito: denota el conjunto de programas en los que participó una determinada persona.
-- Precondición: la persona debe existir en el organizador.
-- Eficiencia: O(log P) en peor caso, donde P es la cantidad total de personas del organizador.

programaronJuntas :: Organizador -> Persona -> Persona -> Bool
-- Propósito: dado un organizador y dos personas, denota verdadero si ambas son autores de algún software en común.
-- Precondición: las personas deben ser distintas.
-- -- Eficiencia: O(log P + C log C) en peor caso, donde P es la cantidad de personas distintas que aparecen en todos los
-- programas del organizador, y C la cantidad total de programas.

nroProgramasDePersona :: Organizador -> Persona -> Int
-- Propósito: dado un organizador y una persona, denota la cantidad de programas distintos en los que aparece.
-- Eficiencia: O(log P) en peor caso, donde P es la cantidad de personas del organizador.