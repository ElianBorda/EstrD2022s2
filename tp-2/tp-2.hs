-- ##### 1. Recursión sobre listas #####

------------------------------------------

-- 1. Dada una lista de enteros devuelve la suma de todos sus elementos
sumatoria :: [Int] -> Int
sumatoria [] = 0
sumatoria (n:ns) = n + sumatoria ns

------------------------------------------

-- 2. Dada una lista de elementos de algún tipo devuelve el largo de esa lista, es decir, la cantidad
-- de elementos que posee.
longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

------------------------------------------

-- 3. Dada una lista de enteros, devuelve la lista de los sucesores de cada entero.
sucesores :: [Int] -> [Int]
sucesores []     = []
sucesores (n:ns) = n+1 : sucesores ns 

------------------------------------------

-- 4. Dada una lista de booleanos devuelve True si todos sus elementos son True.
conjuncion :: [Bool] -> Bool
conjuncion []     = True
conjuncion (b:bs) = b && conjuncion bs

------------------------------------------

-- 5. Dada una lista de booleanos devuelve True si alguno de sus elementos es True.
disyuncion :: [Bool] -> Bool
disyuncion []     = False
disyuncion (b:bs) = b || disyuncion bs  

------------------------------------------

-- 6. Dada una lista de listas, devuelve una única lista con todos sus elementos.
aplanar :: [[a]] -> [a]
aplanar [] = []
aplanar (xs:xss) = agregar xs (aplanar xss)

-- Otra solucion
aplanar' :: [[a]] -> [a]
aplanar' [] = []
aplanar' (xs:xss) = xs ++ aplanar' xss
-- CORREGIDO

------------------------------------------

-- 7. Dados un elemento e y una lista xs devuelve True si existe un elemento en xs que sea igual
-- a e.
pertenece :: Eq a => a -> [a] -> Bool
pertenece _ []     = False
pertenece x (y:ys) = (x==y) || pertenece x ys

------------------------------------------

-- 8. Dados un elemento e y una lista xs cuenta la cantidad de apariciones de e en xs.
apariciones :: Eq a => a -> [a] -> Int
apariciones _ []       = 0
apariciones x (y:ys)   =  if x==y 
                            then 1+(apariciones x ys)
                            else apariciones x ys
------------------------------------------

-- 9. Dados un número n y una lista xs, devuelve todos los elementos de xs que son menores a n.
losMenoresA :: Int -> [Int] -> [Int]
losMenoresA _ []     = []
losMenoresA n (m:ms) =  if m<n 
                            then m : losMenoresA n ms  
                            else losMenoresA n ms

------------------------------------------

-- 10. Dados un número n y una lista de listas, devuelve la lista de aquellas listas que tienen más
-- de n elementos.
lasDeLongitudMayorA :: Int -> [[a]] -> [[a]]
lasDeLongitudMayorA _ []     = []
lasDeLongitudMayorA n (x:xs) = if (longitud x)>n 
                                    then  x : lasDeLongitudMayorA n xs
                                    else lasDeLongitudMayorA n xs

------------------------------------------

-- 11. Dados una lista y un elemento, devuelve una lista con ese elemento agregado al final de la
-- lista.
agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal [] y = y:[]
agregarAlFinal (x:xs) y =  x : agregarAlFinal xs y 

------------------------------------------

-- 12. Dadas dos listas devuelve la lista con todos los elementos de la primera lista y todos los
-- elementos de la segunda a continuación. Definida en Haskell como (++).
agregar :: [a] -> [a] -> [a]
agregar [] ys = ys
agregar (x:xs) ys = x : agregar xs ys

------------------------------------------

-- 13. Dada una lista devuelve la lista con los mismos elementos de atrás para adelante. Definida
-- en Haskell como reverse.
reversa :: [a] -> [a]
reversa []     = []
reversa (x:xs) =  agregarAlFinal (reversa xs) x 

------------------------------------------

-- 14. Dadas dos listas de enteros, devuelve una lista donde el elemento en la posición n es el
-- máximo entre el elemento n de la primera lista y de la segunda lista, teniendo en cuenta que
-- las listas no necesariamente tienen la misma longitud.
zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos [] _          = []
zipMaximos _ []          = []
zipMaximos (x:xs) (y:ys) = maxDelPar (x,y) : zipMaximos xs ys

maxDelPar :: (Int, Int) -> Int
maxDelPar (n, m) =  if n > m
                        then n
                        else m

------------------------------------------

-- 15. Dada una lista devuelve el mínimo
elMinimo :: Ord a => [a] -> a
elMinimo (x:[]) = x
elMinimo (x:xs) = if x<(elMinimo xs) 
                       then x
                       else elMinimo xs
--CORREGIDO 

------------------------------------------

-- #####  2. Recursión sobre números #####

------------------------------------------

-- 1. Dado un número n se devuelve la multiplicación de este número y todos sus anteriores hasta
-- llegar a 0. Si n es 0 devuelve 1. La función es parcial si n es negativo.
factorial :: Int -> Int
factorial 0 = 1
factorial n = if n>=0
                then n * factorial (n-1)
                else error "El valor es negativo"

------------------------------------------

-- 2. Dado un número n devuelve una lista cuyos elementos sean los números comprendidos entre
-- n y 1 (incluidos). Si el número es inferior a 1, devuelve la lista vacía.
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva 0 = []
cuentaRegresiva n = if n>=1
                        then n : cuentaRegresiva (n-1)
                        else []

------------------------------------------

-- 3. Dado un número n y un elemento e devuelve una lista en la que el elemento e repite n veces.
repetir ::  Int -> a -> [a]
repetir 0 _ = []
repetir n x = x : repetir (n-1) x

------------------------------------------

-- 4. Dados un número n y una lista xs, devuelve una lista con los n primeros elementos de xs.
-- Si la lista es vacía, devuelve una lista vacía.
losPrimeros :: Int -> [a] -> [a]
losPrimeros 0 _      = []
losPrimeros _ []     = []
losPrimeros n (x:xs) = x : losPrimeros (n-1) xs

------------------------------------------

-- 5. Dados un número n y una lista xs, devuelve una lista sin los primeros n elementos de lista
-- recibida. Si n es cero, devuelve la lista completa.
sinLosPrimeros :: Int -> [a] -> [a]
sinLosPrimeros 0 xs = xs
sinLosPrimeros _ [] = []
sinLosPrimeros n (x:xs) = sinLosPrimeros (n-1) xs

-------------------------------------------

-- ##### 3. Registros #####

-------------------------------------------

-- 1. Definir el tipo de dato Persona, como un nombre y la edad de la persona.

data Persona = P  String Int
               -- nombre edad
    deriving Show

juan, jose, miguel, roberto :: Persona
juan = P "Juan" 20
jose = P "Jose" 35
miguel = P "Miguel" 28
roberto = P "Roberto" 27

-------------------------------------------

-- Dados una edad y una lista de personas devuelve a las personas mayores a esa edad
mayoresA :: Int -> [Persona] -> [Persona]
mayoresA _ [] = []
mayoresA ed (p:ps) = if (edad p)>ed
                        then p : mayoresA ed ps
                        else mayoresA ed ps

edad :: Persona -> Int
edad (P _ ed) = ed 

-------------------------------------------

-- Dada una lista de personas devuelve el promedio de edad entre esas personas. Precon-
-- dición: la lista al menos posee una persona.
promedioEdad :: [Persona] -> Int
promedioEdad ps = promedio (edades ps)


edades :: [Persona] -> [Int]
edades [] = []
edades (p:ps) = edad p : edades ps


promedio :: [Int] -> Int
promedio ns = div (sumatoria ns) (longitud ns)

-------------------------------------------

-- Dada una lista de personas devuelve la persona más vieja de la lista. Precondición: la
-- lista al menos posee una persona.
elMasViejo :: [Persona] -> Persona
elMasViejo (p:[]) = p
elMasViejo (p:ps) =  laQueEsMayor p (elMasViejo ps)
--CORREGIDO

esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra (P _ ed) (P _ ed1) = ed>ed1

laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor p1 p2 = if esMayorQueLaOtra p1 p2
                         then p1
                         else p2 
--CORREGIDO

-------------------------------------------

-- 2. Modificaremos la representación de Entreador y Pokemon de la práctica anterior de la siguiente
-- manera:
data TipoDePokemon = Agua | Fuego | Planta
    deriving Show
data Pokemon = ConsPokemon TipoDePokemon Int
    deriving Show
data Entrenador = ConsEntrenador String [Pokemon]
    deriving Show

-- DATOS
suicune, squirtle, charmander, vulpix, tangela, chikorita, charizard, bulbasor :: Pokemon
suicune    = ConsPokemon Agua   21
squirtle   = ConsPokemon Agua   31
vulpix     = ConsPokemon Fuego  54
charmander = ConsPokemon Fuego  71
charizard  = ConsPokemon Fuego  25
tangela    = ConsPokemon Planta 18
chikorita  = ConsPokemon Planta 29
bulbasor   = ConsPokemon Planta 50

erika, kiawe, misty :: Entrenador
erika = ConsEntrenador "Erika" [squirtle, chikorita,suicune ]
kiawe = ConsEntrenador "Kiawe" [charmander, vulpix, charizard]
misty = ConsEntrenador "Misty" [tangela, bulbasor]

-------------------------------------------

-- * Devuelve la cantidad de Pokémon que posee el entrenador.
cantPokemon :: Entrenador -> Int
cantPokemon e = longitud (pokemones e) 

pokemones :: Entrenador -> [Pokemon]
pokemones (ConsEntrenador _ ps) = ps
-------------------------------------------

-- * Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
{- cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
cantPokemonDe t e = longitud (listarPorTipo (pokemones e) t)

listarPorTipo :: [Pokemon] -> TipoDePokemon -> [Pokemon]
listarPorTipo [] _     = []
listarPorTipo (p:ps) t = if esDeTipo p t
                             then p : listarPorTipo ps t
                             else listarPorTipo ps t

esDeTipo :: Pokemon -> TipoDePokemon -> Bool
esDeTipo p t = esIgualTipoQue (tipoDePokemon p) t

esIgualTipoQue :: TipoDePokemon -> TipoDePokemon -> Bool
esIgualTipoQue Agua Agua = True
esIgualTipoQue Fuego Fuego = True
esIgualTipoQue Planta Planta = True
esIgualTipoQue _ _ = False 

tipoDePokemon :: Pokemon -> TipoDePokemon
tipoDePokemon (ConsPokemon t _) = t -}

cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
cantPokemonDe t e = cantPokemonDeTipoEn (pokemones e) t 

cantPokemonDeTipoEn :: [Pokemon] -> TipoDePokemon -> Int
cantPokemonDeTipoEn [] _     = 0
cantPokemonDeTipoEn (p:ps) t = unoSi (esDeTipo p t) + cantPokemonDeTipoEn ps t

unoSi :: Bool -> Int
unoSi True  = 1
unoSi False = 0


-- CORREGIDO

-------------------------------------------

-- * Dados dos entrenadores, indica la cantidad de Pokemon de cierto tipo, que le ganarían
-- a los Pokemon del segundo entrenador.
{- losQueLeGanan :: TipoDePokemon -> Entrenador -> Entrenador -> Int
losQueLeGanan t e e2 = longitud  (pokemonesQueGanaronA (listarPorTipo (pokemones e) t) (pokemones e2))

pokemonesQueGanaronA :: [Pokemon] -> [Pokemon] -> [Pokemon]
pokemonesQueGanaronA [] _       = []
pokemonesQueGanaronA _ []       = []
pokemonesQueGanaronA (p:ps) ps2 = if superaEnPoderATodos p ps2
                                      then p : pokemonesQueGanaronA ps ps2
                                      else pokemonesQueGanaronA ps ps2

superaEnPoderATodos :: Pokemon -> [Pokemon] -> Bool
superaEnPoderATodos p (p2:[])  = superaEnPoderA p p2
superaEnPoderATodos p (p2:ps2) = superaEnPoderA p p2 && superaEnPoderATodos p ps2 

superaEnPoderA :: Pokemon -> Pokemon -> Bool
superaEnPoderA p p2 = elPoderEsMayorQue (poderDePokemon p) (poderDePokemon p2)

poderDePokemon :: Pokemon -> Int
poderDePokemon (ConsPokemon _ d) = d

elPoderEsMayorQue :: Int -> Int -> Bool
elPoderEsMayorQue n m = n>m -}

losQueLeGanan :: TipoDePokemon -> Entrenador -> Entrenador -> Int
losQueLeGanan t e1 e2 = deTipoQueGananA t (pokemones e1) (pokemones e2)

deTipoQueGananA :: TipoDePokemon -> [Pokemon] -> [Pokemon] -> Int
deTipoQueGananA _ _ []              = 0
deTipoQueGananA _ [] _              = 0
deTipoQueGananA t (p1:ps1) (p2:ps2) = unoSi (esDeTipoQueSuperaA t p1 p2) + deTipoQueGananA t ps1 ps2

esDeTipoQueSuperaA :: TipoDePokemon -> Pokemon -> Pokemon -> Bool
esDeTipoQueSuperaA t p1 p2 = superaA p1 p2 && esDeTipo p1 t

esDeTipo :: Pokemon -> TipoDePokemon -> Bool
esDeTipo p t = esIgualTipoQue (tipoDePokemon p) t

esIgualTipoQue :: TipoDePokemon -> TipoDePokemon -> Bool
esIgualTipoQue Agua Agua = True
esIgualTipoQue Fuego Fuego = True
esIgualTipoQue Planta Planta = True
esIgualTipoQue _ _ = False 

tipoDePokemon :: Pokemon -> TipoDePokemon
tipoDePokemon (ConsPokemon t _) = t

superaA :: Pokemon -> Pokemon -> Bool
superaA (ConsPokemon t1 _) (ConsPokemon t2 _) = elTipoSuperaA t1 t2

elTipoSuperaA :: TipoDePokemon -> TipoDePokemon -> Bool
elTipoSuperaA Agua Fuego = True
elTipoSuperaA Fuego Planta = True
elTipoSuperaA Planta Agua = True
elTipoSuperaA _ _ = False


-------------------------------------------

--Dado un entrenador, devuelve True si posee al menos un Pokémon de cada tipo posible.
esMaestroPokemon :: Entrenador -> Bool
esMaestroPokemon e = tieneTodosLosTiposPokemon (pokemones e)

tieneTodosLosTiposPokemon :: [Pokemon] -> Bool
tieneTodosLosTiposPokemon ps = (tienePokemonDeTipo ps Agua)
                               &&
                               (tienePokemonDeTipo ps Fuego)
                               &&
                               (tienePokemonDeTipo ps Planta)
                               
tienePokemonDeTipo :: [Pokemon] -> TipoDePokemon -> Bool
tienePokemonDeTipo [] _ = False
tienePokemonDeTipo (p:ps) t = esDeTipo p t || tienePokemonDeTipo ps t

-------------------------------------------

-- 3. El tipo de dato Rol representa los roles (desarollo o management) de empleados IT dentro
-- de una empresa de software, junto al proyecto en el que se encuentran. Así, una empresa es
-- una lista de personas con diferente rol. La definición es la siguiente:

data Seniority = Junior | SemiSenior | Senior
 deriving Show
data Proyecto = ConsProyecto String
 deriving Show
data Rol = Developer Seniority Proyecto | Management Seniority Proyecto
 deriving Show
data Empresa = ConsEmpresa [Rol]
 deriving Show

-- DATOS
nttData, cisco, henry, mercadoLibre, oracle :: Empresa
nttData      = ConsEmpresa [(Developer Junior paginaWeb1), (Developer Junior paginaWeb2)]
cisco        = ConsEmpresa [(Management SemiSenior crud1), (Management Junior api1), (Management Senior paginaWeb3)]
henry        = ConsEmpresa [(Management Senior crud2), (Developer SemiSenior api2), (Developer Senior crud2)]
mercadoLibre = ConsEmpresa [(Developer Senior api2)]
oracle       = ConsEmpresa [(Management Junior paginaWeb3), (Developer Senior paginaWeb3), (Management Junior api2), (Developer Senior paginaWeb1), (Management Senior crud1)]

paginaWeb1, paginaWeb2, paginaWeb3, crud1, crud2, api1, api2 :: Proyecto
paginaWeb1 = ConsProyecto "PaginaWeb1"
paginaWeb2 = ConsProyecto "PaginaWeb2"
paginaWeb3 = ConsProyecto "PaginaWeb3"
crud1      = ConsProyecto "Crud1"
crud2      = ConsProyecto "Crud2"
api1       = ConsProyecto "Api1"
api2       = ConsProyecto "Api2"



------------------------------------------

-- Dada una empresa denota la lista de proyectos en los que trabaja, sin elementos repetidos.
proyectos :: Empresa -> [Proyecto]
proyectos e = sinProyectosRepetidos( pedirProyectosDeRoles (roles e))

roles :: Empresa -> [Rol]
roles (ConsEmpresa rs) = rs

pedirProyectosDeRoles :: [Rol] -> [Proyecto]
pedirProyectosDeRoles []     = []
pedirProyectosDeRoles (r:rs) = proyecto r : pedirProyectosDeRoles rs

proyecto :: Rol -> Proyecto
proyecto (Developer s p)  = p
proyecto (Management s p) = p

sinProyectosRepetidos :: [Proyecto] -> [Proyecto]
sinProyectosRepetidos []     = [] 
sinProyectosRepetidos (p:ps) = if seRepiteEn p ps
                                    then sinProyectosRepetidos ps
                                    else p : sinProyectosRepetidos ps


seRepiteEn :: Proyecto -> [Proyecto] -> Bool
seRepiteEn p ps = (aparicionesProyecto p ps)>=1

aparicionesProyecto :: Proyecto -> [Proyecto] -> Int
aparicionesProyecto _ []      = 0
aparicionesProyecto p (p2:ps) = if esProyectoIgualQue p p2
                                    then 1 + aparicionesProyecto p ps
                                    else aparicionesProyecto p ps
 
esProyectoIgualQue :: Proyecto -> Proyecto -> Bool
esProyectoIgualQue (ConsProyecto n) (ConsProyecto n2) = n==n2

------------------------------------------

-- Dada una empresa indica la cantidad de desarrolladores senior que posee, que pertecen
-- además a los proyectos dados por parámetro.
losDevSenior :: Empresa -> [Proyecto] -> Int
losDevSenior e ps = longitud (rolesConAlgunProyecto (rolesDeveloperDeSeniority (roles e) Senior) ps)

rolesConAlgunProyecto :: [Rol] -> [Proyecto] -> [Rol]
rolesConAlgunProyecto [] _ = []
rolesConAlgunProyecto (r:rs) ps = if tieneAlgunProyectoEn r ps
                                        then r : rolesConAlgunProyecto rs ps
                                        else rolesConAlgunProyecto rs ps

tieneAlgunProyectoEn :: Rol -> [Proyecto] -> Bool
tieneAlgunProyectoEn r (p:[]) = esProyectoIgualQue (proyecto r) p
tieneAlgunProyectoEn r (p:ps) = esProyectoIgualQue (proyecto r) p || tieneAlgunProyectoEn r ps

rolesDeveloperDeSeniority :: [Rol]  -> Seniority -> [Rol]
rolesDeveloperDeSeniority [] _      = []
rolesDeveloperDeSeniority (r:rs) s = if esRolDeveloperDeSeniority r s
                                    then r : rolesDeveloperDeSeniority rs s
                                    else rolesDeveloperDeSeniority rs s

esRolDeveloperDeSeniority :: Rol -> Seniority -> Bool
esRolDeveloperDeSeniority r s = (esRolDeveloper r) 
                                && 
                                (esSeniorityIgualQue (seniority r) s)

esRolDeveloper :: Rol -> Bool
esRolDeveloper (Developer s p)  = True
esRolDeveloper (Management s p) = False

esSeniorityIgualQue :: Seniority -> Seniority -> Bool
esSeniorityIgualQue Junior Junior         = True
esSeniorityIgualQue SemiSenior SemiSenior = True
esSeniorityIgualQue Senior Senior         = True
esSeniorityIgualQue _ _                   = False

seniority :: Rol -> Seniority
seniority (Developer s p)   = s
seniority (Management s p)  = s

------------------------------------------

-- Indica la cantidad de empleados que trabajan en alguno de los proyectos dados.
cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
cantQueTrabajanEn ps e = longitud( rolesConAlgunProyecto (roles e) ps)


-- Devuelve una lista de pares que representa a los proyectos (sin repetir) junto con su
-- cantidad de personas involucradas.
asignadosPorProyecto :: Empresa -> [(Proyecto, Int)]
asignadosPorProyecto e = proyectoConCantDePersonasEn (proyectos e) e

proyectoConCantDePersonasEn :: [Proyecto] -> Empresa -> [(Proyecto, Int)]
proyectoConCantDePersonasEn [] _      = []
proyectoConCantDePersonasEn (p:ps) e  = (p, aparicionesProyecto p (pedirProyectosDeRoles (roles e))) : proyectoConCantDePersonasEn ps e
 
