programasEnComun :: Persona -> Persona -> Organizador -> Set Checksum
-- Propósito: dadas dos personas y un organizador, denota el conjunto de aquellos programas en las que las personas
-- programaron juntas.
-- Eficiencia: (log P + C log C), P es la cantidad total de personas en el organizador. C es la cantidad total de 
-- programas en el organizador.
programasEnComun p1 p2 o = let sp1 = programasDe o p1
                               sp2 = programasDe o p2
                               in intersection sp1 sp2

esUnGranHacker :: Organizador -> Persona -> Bool
-- Propósito: denota verdadero si la persona indicada aparece como autor de todos los programas del organizador.
-- Eficiencia: (log P + C), porque nroProgramaDePersona es O(log P) y todosLosProgramas es O(C)
esUnGranHacker o p = nroProgramaDePersona o p == sizeS (todosLosProgramas o)
