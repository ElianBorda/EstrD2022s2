-- Ejercicio 4

type SectorId = Int
type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)

{- 
    INV.REP: Para (ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado))
        * Map es un BST
        * Set es un BST
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
                                          Just s  -> setToList s

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
-- Costo: calcular.
agregarEmpleado rs c (ConsE m1 m2) = let emp = consEmpleado c
                                         m2' = assocM c emp m2 
                                         in ConsE (agregarEmpleado' rs emp m1) m2'

agregarEmpleado' :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
agregarEmpleado' [] emp m
agregarEmpleado' (r:rs) emp m = let s = 


agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
-- Propósito: agrega un sector al empleado con dicho CUIL.
-- Costo: calcular.

borrarEmpleado :: CUIL -> Empresa -> Empresa
-- Propósito: elimina al empleado que posee dicho CUIL.
-- Costo: calcular
                      