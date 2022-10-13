-- Ejercicio 4

type SectorId = Int
type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)

{- 
    INV.REP: Para (ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado))
        * Cuando se borra el empleado del sector, se borra
          en los registros.
        * Si el empleado esta en m1 entonces esta en m2 y viseversa.
        * Un empleado puede estar en mas de un conjunto.
        * La CUIL es unica por empleado.


-}

consEmpresa :: Empresa
-- Propósito: construye una empresa vacía.
-- Costo: O(1)
consEmpresa = ConsE (emptyM) (emptyM)

buscarPorCUIL :: CUIL -> Empresa -> Empleado
-- Propósito: devuelve el empleado con dicho CUIL.
-- Costo: O(log E)
-- Precond: Existe el empleado con el cuil dado en la empresa
buscarPorCUIL c (ConsE m1 m2) = case lookupM c m2 of
                                     Nothing -> error "No existe el empleado" 
                                     Just e  -> e

empleadosDelSector :: SectorId -> Empresa -> [Empleado]
-- Propósito: indica los empleados que trabajan en un sector dado.
-- Costo: O(logS + E)
-- Precond: existe un sector con el id dado
empleadosDelSector r (ConsE m1 m2) = case lookupM r m1 of 
                                          Nothing -> error "No existe un sector con ese id"
                                          Just st  -> setToList st

todosLosCUIL :: Empresa -> [CUIL]
-- Propósito: indica todos los CUIL de empleados de la empresa.
-- Costo: O(E)
todosLosCUIL (ConsE m1 m2) = keys m2

todosLosSectores :: Empresa -> [SectorId]
-- Propósito: indica todos los sectores de la empresa.
-- Costo: O(S)
todosLosSectores (ConsE m1 m2) = keys m1

agregarSector :: SectorId -> Empresa -> Empresa
-- Propósito: agrega un sector a la empresa, inicialmente sin empleados.
-- Costo: O(logS)
agregarSector r (ConsE m1 m2) = (ConsE (assocM r emptyS m1) m2)

agregarEmpleado :: [SectorId] -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un empleado a la empresa, en el que trabajará en dichos sectores y tendrá
-- el CUIL dado.
-- Costo: O(S + logE)
agregarEmpleado rs c (ConsE m1 m2) = let emp = incorporarSectores rs (consEmpleado c)
                                         m2' = assocM c emp m2
                                         in ConsE (agregarEmpleado' rs emp m1) m2'

incorporarSectores :: [SectorId] -> Empleado -> Empleado
-- ############################### 


agregarEmpleado' :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
agregarEmpleado' [] emp m     = m
agregarEmpleado' (r:rs) emp m = case lookupM r m of
                                     Nothing -> agregarEmpleado' rs emp m 
                                     Just st -> agregarEmpleado' rs emp (assocM r (addS emp st) m)


agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un sector al empleado con dicho CUIL.
-- Costo: (logS + logE)
agregarASector sid c (ConsE m1 m2) = let emp = fromJust (lookupM c m2)
                                         st  = fromJust (lookupM sid m1)
                                         in assocM sid (addS emp st) m1 

borrarEmpleado :: CUIL -> Empresa -> Empresa
-- Propósito: elimina al empleado que posee dicho CUIL.
-- Costo: calcular
borrarEmpleado c (ConsE m1 m2) = let (emp, m2') = splitEmpleado c m2
                                     in ConsE (sacarEmpleadoEn emp m1) m2'

splitEmpleado :: CUIL -> Map CUIL Empleado -> (Empleado, Map CUIL Empleado)
splitEmpleado c mp -> (fromJust (lookupM c mp), deleteM c mp)

sacarEmpleadoEn :: Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
sacarEmpleadoEn emp m1 -> eliminarEmpleado (sectores emp) emp m1

eliminarEmpleado :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
eliminarEmpleado [] emp m1     = m1 
eliminarEmpleado (r:rs) emp m1 = eliminarEmpleado rs emp (assocM r (removeS emp (fromJust (lookupM r m1))) m1)


{- agregarEmpleado, agregarSector, borrarEmpleado
    * Falta manipular los SectorId dentro del empleado
    * El empleado tiene en su estructura una lista de sectorId
      que son todos los sectores en el que trabaja el Empleado.
   
   FALTA CALCULAR LOS COSTOS!!! 
   
 -}

