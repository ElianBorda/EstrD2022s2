-- ##### #2 Numeros Enteros #####


-- 1. DEFINA LAS SIGUIENTES FUNCIONES

-- a)

-- Dado un numero devuelve su sucesor
sucesor :: Int -> Int
sucesor x = x+1

-- b)

-- Dado dos numeros devuelve su suma usando la operacion +
sumar :: Int -> Int -> Int
sumar n m = n+m

-- c)

{- Dado dos números, devuelve un par donde la primera componente es la división del
primero por el segundo, y la segunda componente es el resto de dicha división. Nota:
para obtener el resto de la división utilizar la función mod :: Int -> Int -> Int,
provista por Haskell. -}
divisionYResto :: Int -> Int -> (Int, Int)
 -- PRECONDICION: m debe ser m /= 0
divisionYResto n m = (div n m, mod n m)

-- d)

-- Dado un par de números devuelve el mayor de estos. 
maxDelPar :: (Int, Int) -> Int
maxDelPar (n, m) =  if n > m
                        then n
                        else m
-- CORREGIDO

{- 2.De 4 ejemplos de expresiones diferentes que denoten el número 10, utilizando en cada expresión 
     a todas las funciones del punto anterior.
     Ejemplo: maxDePar (divisionYResto (suma 5 5) (sucesor 0)) -}

-- (1)
-- sumar (maxDelPar (8, 2)) (fst (divisionYResto 8 (sucesor 3)))

-- (2)
-- maxDelPar ((sumar (maxDelPar (3, 4)) (fst (divisionYResto 12 2))), (fst (divisionYResto 4 (sucesor 1))))

-- (3)
-- fst (divisionYResto (sumar 10 (sucesor 9)) (sucesor 1))

-- (4)
-- sumar (fst (divisionYResto (maxDelPar (8, (sumar 5 (fst (divisionYResto 27 3))))) 2)) (sumar (sucesor 1) 1)


 
-- ##### #3 Tipos Enumerativos #####



{- 1. Definir el tipo de dato Dir, con las alternativas Norte, Sur, Este y Oeste. Luego implementar
las siguientes funciones: -}

data Dir = Norte | Sur | Este | Oeste
     deriving Show

-- a) Dada una dirección devuelve su opuesta.
opuesto :: Dir -> Dir
opuesto Norte = Sur
opuesto Sur = Norte
opuesto Este = Oeste
opuesto Oeste = Este

-- b) Dadas dos direcciones, indica si son la misma. Nota: utilizar pattern matching y no ==.
iguales :: Dir -> Dir -> Bool
iguales Este Este = True
iguales Oeste Oeste = True
iguales Norte Norte = True
iguales Sur Sur = True
iguales _ _ = False

{- c) Dada una dirección devuelve su siguiente, en sentido horario, y suponiendo que no existe
la siguiente dirección a Oeste. ¿Posee una precondición esta función? ¿Es una función
total o parcial? ¿Por qué? -}

siguiente :: Dir -> Dir
-- Precond: Solamente norte, sur y este tiene direcciones siguientes  
siguiente Norte = Este
siguiente Este = Sur
siguiente Sur = Oeste
siguiente _ = error "Oeste no tiene siguiente"

{- 2. Definir el tipo de dato DiaDeSemana, con las alternativas Lunes, Martes, Miércoles, Jueves,
Viernes, Sabado y Domingo. Supongamos que el primer día de la semana es lunes, y el último
es domingo. Luego implementar las siguientes funciones: -}

data DiaDeSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo 
     deriving Show

{- a) Devuelve un par donde la primera componente es el primer día de la semana, y la
segunda componente es el último día de la semana. Considerar definir subtareas útiles
que puedan servir después. -}

primeroYUltimoDia :: (DiaDeSemana, DiaDeSemana)
primeroYUltimoDia = (primerDia, ultimoDia)

primerDia :: DiaDeSemana
primerDia = Lunes

ultimoDia :: DiaDeSemana
ultimoDia = Domingo

{- b) Dado un día de la semana indica si comienza con la letra M. -}

empiezaConM :: DiaDeSemana -> Bool
empiezaConM Miercoles = True
empiezaConM Martes = True
empiezaConM _ = False

{- c) Dado dos días de semana, indica si el primero viene después que el segundo. Analizar
la calidad de la solución respecto de la cantidad de casos analizados (entre los casos
analizados en esta y cualquier subtarea, deberían ser no más de 9 casos). -}

vieneDespues :: DiaDeSemana -> DiaDeSemana -> Bool
vieneDespues Lunes Martes = True
vieneDespues Martes Miercoles = True
vieneDespues Miercoles Jueves = True
vieneDespues Jueves Viernes = True
vieneDespues Viernes Sabado = True
vieneDespues Sabado Domingo = True
vieneDespues Domingo Lunes = True
vieneDespues _ _ = False

{- d) Dado un día de la semana indica si no es ni el primer ni el ultimo dia. -}

estaEnElMedio :: DiaDeSemana -> Bool
estaEnElMedio Lunes = False
estaEnElMedio Domingo = False
estaEnElMedio _ = True

{-3. Los booleanos también son un tipo de enumerativo. Un booleano es True o False. Defina
las siguientes funciones utilizando pattern matching (no usar las funciones sobre booleanos
ya definidas en Haskell):-}


{- a) Dado un booleano, si es True devuelve False, y si es False devuelve True.
En Haskell ya está definida como not. -}

negar :: Bool -> Bool
negar False = True
negar True = False

{- b) Dados dos booleanos, si el primero es True y el segundo es False, devuelve False, sino
devuelve True. Esta función debe ser tal que implica False (error "Mal") devuelva
True.
Nota: no viene implementada en Haskell. -}

implica :: Bool -> Bool -> Bool
implica True False = False
implica _ _ = True

{- c) Dados dos booleanos si ambos son True devuelve True, sino devuelve False. Esta
función debe ser tal que yTambien False (error "Mal") devuelva False.
En Haskell ya está definida como \&\&. -}

yTambien :: Bool -> Bool -> Bool
yTambien True True = True
yTambien _ _ = False

{- d) Dados dos booleanos si alguno de ellos es True devuelve True, sino devuelve False.
Esta función debe ser tal que oBien True (error "Mal") devuelva True.
En Haskell ya está definida como ||. -}

oBien :: Bool -> Bool -> Bool
oBien False False = False
oBien _ _ = False




-- ##### #4 Registros #####



{- 1. Definir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las
siguientes funciones: -}

data Persona = Perso String Int
     deriving Show
               --      Nombre Edad
     
elian :: Persona
elian = Perso "Elian" 19 

alan :: Persona
alan = Perso "Alan" 17

-- * Devuelve el nombre de una persona
nombre :: Persona -> String
nombre (Perso nom _) = nom

-- * Devuelve la edad de una persona
edad :: Persona -> Int
edad (Perso _ ed) = ed

-- * Aumenta en uno la edad de la persona.
crecer :: Persona -> Persona
crecer (Perso nom ed) = Perso nom (ed+1)

-- * Dados un nombre y una persona, devuelve una persona con la edad de la persona y el nuevo nombre.
cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre x (Perso nom ed) = Perso x ed

-- * Dadas dos personas indica si la primera es mayor que la segunda.
esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra (Perso _ ed) (Perso _ ed1) = ed>ed1

-- CORREGIDO

-- * Dadas dos personas devuelve a la persona que sea mayor.
laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor p1 p2 = if esMayorQueLaOtra p1 p2
                         then p1
                         else p2

-- CORREGIDO 

{- 2. Definir los tipos de datos Pokemon, como un TipoDePokemon (agua, fuego o planta) y un
porcentaje de energía; y Entrenador, como un nombre y dos Pokémon. Luego definir las
siguientes funciones:
 -}

data TipoDePokemon = Agua | Fuego | Planta
     deriving Show
data Pokemon = Pokemon_ TipoDePokemon    Int
     deriving Show
               --       Tipo de Pokemon  Porcentaje de energia
data Entrenador = Entrenador_ String  (Pokemon, Pokemon)
     deriving Show
                  --          nombre  2 pokemones

-- DATOS
suicune, squirtle, charmander, vulpix, tangela, chikorita :: Pokemon
suicune    = Pokemon_ Agua   21
squirtle   = Pokemon_ Agua   31
vulpix     = Pokemon_ Fuego  54
charmander = Pokemon_ Fuego  71
tangela    = Pokemon_ Planta 18
chikorita  = Pokemon_ Planta 29

erika, kiawe, misty :: Entrenador
erika = Entrenador_ "Erika" (squirtle, chikorita)
kiawe = Entrenador_ "Kiawe" (charmander, vulpix)
misty = Entrenador_ "Misty" (suicune, tangela)


{- * Dados dos Pokémon indica si el primero, en base al tipo, es superior al segundo. Agua
supera a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso. -}
superaA :: Pokemon -> Pokemon -> Bool
superaA (Pokemon_ tipo ener) (Pokemon_ tipo1 ener1) = elTipoSuperaA tipo tipo1

elTipoSuperaA :: TipoDePokemon -> TipoDePokemon -> Bool
elTipoSuperaA Agua Fuego = True
elTipoSuperaA Fuego Planta = True
elTipoSuperaA Planta Agua = True
elTipoSuperaA _ _ = False

-- * Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe x (Entrenador_ _ pokePar) = cantidadDeTipoPokemon x pokePar

cantidadDeTipoPokemon :: TipoDePokemon -> (Pokemon, Pokemon) -> Int
cantidadDeTipoPokemon x ((Pokemon_ tipoP _), (Pokemon_ tipoP2 _)) = ((unoSiCeroSino (esDelMismoTipo x tipoP)) + 
                                                                    (unoSiCeroSino (esDelMismoTipo x tipoP2)))

esDelMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esDelMismoTipo Planta Planta = True
esDelMismoTipo Agua Agua = True
esDelMismoTipo Fuego Fuego = True
esDelMismoTipo _ _ = False

unoSiCeroSino :: Bool -> Int
unoSiCeroSino True = 1
unoSiCeroSino False = 0




-- * ##### #5 Funciones Polimorficas #####



-- 1.Defina las siguientes funciones polimórficas:

-- a) Dado un elemento de algún tipo devuelve ese mismo elemento.
loMismo :: a -> a
loMismo x = x

-- b) Dado un elemento de algún tipo devuelve el número 7.
siempreSiete :: a -> Int
siempreSiete x = 7

-- c) Dadas una tupla, invierte sus componentes.
swap :: (a,b) -> (b, a)
swap (x, y) = (y, x)

-- 2. Responda la siguiente pregunta: ¿Por qué estas funciones son polimórficas?

{- Estas funciones son polimorficas porque no tienen restricciones de tipo en la definicion. Sus estructuras
pueden trabajar con cualquier tipo de datos, ya que ademas no poseen operaciones no polimorficas. En consecuencia, 
cumplen con la generalizacion de tipos -}

-- * ##### #6 Pattern matching sobre lista #####



{- 1. Defina las siguientes funciones polimórficas utilizando pattern matching sobre listas (no
utilizar las funciones que ya vienen con Haskell): -}

{- 2. Dada una lista de elementos, si es vacía devuelve True, sino devuelve False.
Definida en Haskell como null. -}
estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia (_:_) = False

{- 3. Dada una lista devuelve su primer elemento.
Definida en Haskell como head.
Nota: tener en cuenta que el constructor de listas es :
-}
elPrimero :: [a] -> a
-- PRECOND: La lista no esta vacia
elPrimero (x:_) = x
elPrimero _ = error "La lista esta vacia"

{- 4. Dada una lista devuelve esa lista menos el primer elemento.
Definida en Haskell como tail.
Nota: tener en cuenta que el constructor de listas es :
-}
sinElPrimero :: [a] -> [a]
-- PRECOND: La lista tiene mas de un elemento
sinElPrimero (_:ls) = ls
sinElPrimero _ = error "La lista no tiene mas de un elemento"


{- 5. Dada una lista devuelve un par, donde la primera componente es el primer elemento de la
lista, y la segunda componente es esa lista pero sin el primero.
Nota: tener en cuenta que el constructor de listas es :
-}
splitHead :: [a] -> (a, [a])
splitHead ls = (elPrimero ls, sinElPrimero ls)

-- CORREGIDO
