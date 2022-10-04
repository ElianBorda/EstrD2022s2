-- 1. Pizzas

data Pizza = Prepizza
           | Capa Ingrediente Pizza
    deriving Show

data Ingrediente = Salsa
                 | Queso
                 | Jamon
                 | Aceitunas Int
    deriving Show


pizza = (Capa Jamon (Capa Queso (Capa Salsa Prepizza)))

pizza2 = (Capa (Aceitunas 2) (Capa Jamon (Capa Queso (Capa Salsa Prepizza))))
-- funciones

-- Dada una pizza devuelve la cantidad de ingredientes
cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza   = 0
cantidadDeCapas (Capa _ p) = 1 + cantidadDeCapas p

-- Dada una lista de ingredientes construye una pizza
armarPizza :: [Ingrediente] -> Pizza
armarPizza []     = Prepizza
armarPizza (i:is) = Capa i (armarPizza is)

-- Le saca los ingredientes que sean jamón a la pizza
sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza   = Prepizza
sacarJamon (Capa i p) = if esIngrediente Jamon i 
                            then sacarJamon p
                            else (Capa i (sacarJamon p))

esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _     = False                            

-- Dice si una pizza tiene salsa y queso
tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso p = tieneIngrediente Salsa p && tieneIngrediente Queso p

tieneIngrediente :: Ingrediente -> Pizza -> Bool
tieneIngrediente i Prepizza     = False
tieneIngrediente i (Capa ing p) = esIngrediente ing i || tieneIngrediente i p

esIngrediente :: Ingrediente -> Ingrediente -> Bool
esIngrediente Queso Queso                 = True
esIngrediente Jamon Jamon                 = True
esIngrediente Salsa Salsa                 = True
esIngrediente (Aceitunas _) (Aceitunas _) = True
esIngrediente _ _                         = False

-- Recorre cada ingrediente y si es aceitunas duplica su cantidad
duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza   = Prepizza
duplicarAceitunas (Capa i p) = Capa (duplicarCantSiAceitunas i) (duplicarAceitunas p)

duplicarCantSiAceitunas :: Ingrediente -> Ingrediente
duplicarCantSiAceitunas (Aceitunas n) = (Aceitunas (n*2))
duplicarCantSiAceitunas i             = i  


-- Dada una lista de pizzas devuelve un par donde la primera componente es la cantidad de
-- ingredientes de la pizza, y la respectiva pizza como segunda componente.
cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
cantCapasPorPizza []     = []
cantCapasPorPizza (p:ps) = agregarPizza p (cantCapasPorPizza ps)

agregarPizza :: Pizza -> [(Int, Pizza)] -> [(Int, Pizza)]
agregarPizza p nps = (cantidadDeCapas p, p):nps 
 
-- 2. Mapa de tesoros (con bifurcaciones)

data Dir = Izq | Der
    deriving Show

data Objeto = Tesoro | Chatarra
    deriving Show

data Cofre = Cofre [Objeto]
    deriving Show

data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa
    deriving Show

mapa1 = (Bifurcacion 
            (Cofre [Chatarra]) 
            (Fin (Cofre [Chatarra])) 
            (Fin (Cofre [Tesoro])))

mapa2 = (Bifurcacion 
            (Cofre [Chatarra,Tesoro,Tesoro,Tesoro]) 
            (Fin 
                (Cofre [Chatarra,Tesoro,Tesoro])) 
            (Bifurcacion 
                (Cofre [Tesoro,Tesoro]) 
                (Bifurcacion 
                    (Cofre [Chatarra,Tesoro,Tesoro,Tesoro,Tesoro]) 
                    (Fin (Cofre [Chatarra,Tesoro])) 
                    (Bifurcacion 
                        (Cofre [Chatarra,Tesoro]) 
                        (Fin 
                            (Cofre [Chatarra,Tesoro,Tesoro])) 
                        (Fin 
                            (Cofre [Chatarra])))) 
                (Fin 
                    (Cofre [Chatarra,Tesoro,Tesoro]))))

-- 1. Indica si hay un tesoro en alguna parte del mapa.

hayTesoro :: Mapa -> Bool
hayTesoro (Fin c)               = poseeAlgunTesoro c
hayTesoro (Bifurcacion c m1 m2) = poseeAlgunTesoro c || hayTesoro m1 || hayTesoro m2

poseeAlgunTesoro :: Cofre -> Bool
poseeAlgunTesoro (Cofre objs) = tieneTesoro objs

tieneTesoro :: [Objeto] -> Bool
tieneTesoro []         = False
tieneTesoro (obj:objs) = esTesoro obj || tieneTesoro objs

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

-- 2. Indica si al final del camino hay un tesoro. Nota: el final de un camino se representa con una
-- lista vacía de direcciones.
hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn [] mp     = tieneTesoroEsteFinal mp  
hayTesoroEn (d:ds) mp = hayTesoroEn ds (desplazarA mp d)

desplazarA :: Mapa -> Dir -> Mapa
desplazarA (Bifurcacion _ m1 _) Izq = m1
desplazarA (Bifurcacion _ _ m2) Der = m2
desplazarA m _                      = m 

tieneTesoroEsteFinal :: Mapa -> Bool
tieneTesoroEsteFinal (Bifurcacion c _ _) = poseeAlgunTesoro c
tieneTesoroEsteFinal (Fin c)             = poseeAlgunTesoro c

-- 3. Indica el camino al tesoro. Precondición: existe un tesoro y es único.
{- caminoAlTesoro :: Mapa -> [Dir]
caminoAlTesoro Fin -}

-- 4. Indica el camino de la rama más larga.
caminoDeLaRamaMasLarga :: Mapa -> [Dir]
caminoDeLaRamaMasLarga (Fin c)               = []
caminoDeLaRamaMasLarga (Bifurcacion _ c1 c2) = obtenerCaminoLargo c1 c2 ++ elegirGrande (caminoDeLaRamaMasLarga c1) (caminoDeLaRamaMasLarga c2)

obtenerCaminoLargo :: Mapa -> Mapa -> [Dir]
obtenerCaminoLargo (Fin c1) (Fin c)              = []           
obtenerCaminoLargo (Bifurcacion _ c1 c2) (Fin c) = [Izq]
obtenerCaminoLargo _ _                           = [Der]

elegirGrande :: [a] -> [a] -> [a]
elegirGrande xs ys = if longitud xs > longitud ys
                        then xs 
                        else ys

longitud :: [a] -> Int
longitud []     = 0
longitud (x:xs) = 1 + longitud xs


-- 5. Devuelve los tesoros separados por nivel en el árbol.
tesorosPorNivel :: Mapa -> [[Objeto]]
tesorosPorNivel (Fin c)               = [tesorosDeCofre c]   
tesorosPorNivel (Bifurcacion c t1 t2) = tesorosDeCofre c : unirTPorNivel (tesorosPorNivel t1) (tesorosPorNivel t2)

tesorosDeCofre :: Cofre -> [Objeto]
tesorosDeCofre (Cofre xs) = tesoros xs

tesoros :: [Objeto] -> [Objeto]
tesoros []     = []
tesoros (x:xs) = if esTesoro x 
                    then x : tesoros xs 
                    else tesoros xs
unirTPorNivel :: [[Objeto]] -> [[Objeto]] -> [[Objeto]]
unirTPorNivel [] yss           = yss
unirTPorNivel xss []           = xss 
unirTPorNivel (xs:xss) (ys:yss)= (xs++ys) : unirTPorNivel xss yss 

{-
tesorosPorNivel t1 = [[T1,T1,T1] [T2,T2,T2,T2,T2,T2] [T3,T3,T3,T3,T3]] = tesoros a1 tesoros a2

tesoros a1 = [[T2,T2,T2] [T3 T3]] = tesoros a4 tesoro a0
tesoros a2 = [[T2,T2,T2] [T3,T3,T3]] = teosro a5 tesoro a9

tesoros a4 = [[T3,T3]]
teosoro a0 = []

tesoros a5 = [[T3,t3,t3]]
tesoroa9 = [] -}

-- 6. Devuelve todos lo caminos en el mapa.
todosLosCaminos :: Mapa -> [[Dir]]
todosLosCaminos Mapa
todosLosCaminos Mapa





type Presa = String -- nombre de presa
type Territorio = String -- nombre de territorio
type Nombre = String -- nombre de lobo
data Lobo = Cazador Nombre [Presa] Lobo Lobo Lobo | Explorador Nombre [Territorio] Lobo Lobo | Cria Nombre
data Manada = M Lobo

prueba1 = (M (Cazador "A" ["1","2"] 
                (Explorador "Exp1" ["Argentina", "Canada", "Venezuela"] 
                    (Cria "Bebito1") 
                    (Cria "Bebito2")) 
                (Explorador "Exp2" ["Argentina", "Jamaica", "Chile"] 
                    (Explorador "Exp3" ["Argentina", "Venezuela", "Jamaica"] 
                        (Cria "Bebito6") 
                        (Cria "Bebito3")) 
                    (Explorador "Exp4" ["Chile", "Colombia"] 
                        (Cria "Bebito8") 
                        (Cria "Bebito231"))) 
                (Explorador "Exp5" ["Colombia", "Rusia", "Argentina", "Jamaica"] 
                    (Cria "Bebito123") 
                    (Cria "Bebito312"))))

prueba2 = (M (Explorador "Exp5" ["Colombia", "Rusia", "Argentina", "Jamaica"] 
                (Cria "Bebito123") 
                (Cria "Bebito312")))

prueba3 = (M (Explorador "Exp5" ["Colombia", "Rusia", "Argentina", "Jamaica"] 
                (Explorador "Exp1" ["Argentina", "Canada", "Venezuela"] 
                    (Cria "Bebito1") 
                    (Cria "Bebito2")) 
                (Explorador "Exp2" ["Argentina", "Jamaica", "Chile"] 
                    (Explorador "Exp3" ["Argentina", "Venezuela", "Jamaica"] 
                        (Cria "Bebito6") 
                        (Cria "Bebito3")) 
                    (Explorador "Exp4" ["Chile", "Colombia"] 
                        (Cria "Bebito8") 
                        (Cria "Bebito231")))))

pruebaAsig = [("Arg", ["Jose"]), ("Ven", ["Alberto", "Jose"]), ("Rod", ["Mig"]), ("Rus", ["Alberto"])]
tup = ("Rus", ["Jose","Alberto", "Mig"])

list1 = [("Arg", ["Jose"]), ("Ven", ["Alberto", "Ronaldo"]), ("Rus", ["jOSE"])]
list2 = [("Arg", ["Jose"]), ("Ven", ["Alberto", "Jose"]), ("Rus", ["Alberto"])]

exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
-- Propósito:dada una manada, denota la lista de los pares cuyo primer elemento es un 
-- territorio y cuyo segundo elemento es la lista de los nombres de los exploradores
-- que explorarondicho territorio. Los territorios no deben repetirse.
exploradoresPorTerritorio (M l) = lobosConTerritorioExplorado l

lobosConTerritorioExplorado :: Lobo -> [(Territorio, [Nombre])]
lobosConTerritorioExplorado (Cria n)                = []
lobosConTerritorioExplorado (Explorador n ts l1 l2) = combinarTupla (listarNombrePorTerritorio n ts) (combinarTupla (lobosConTerritorioExplorado l1) (lobosConTerritorioExplorado l2))
lobosConTerritorioExplorado (Cazador _ _ l1 l2 l3)  = combinarTupla (lobosConTerritorioExplorado l1) (combinarTupla (lobosConTerritorioExplorado l2) (lobosConTerritorioExplorado l3))

combinarTupla :: [(Territorio, [Nombre])] -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
combinarTupla txs []        = txs
combinarTupla [] tys        = tys
combinarTupla (tx:txs) tys  = combinarTupla txs (asignarLobosEn tx tys)

territorio :: (Territorio, [Nombre]) -> Territorio
territorio (t, ns) = t 

asignarLobosEn :: (Territorio, [Nombre]) -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
asignarLobosEn tx []       = [] 
asignarLobosEn tx ((t, ns):tys) = if (territorio tx)==t
                                     then (t, asignarNombres ns (nombres tx)):tys
                                     else (t, ns) : asignarLobosEn tx tys

nombres :: (Territorio, [Nombre]) -> [Nombre]
nombres (_, ns) = ns

listarNombrePorTerritorio :: Nombre -> [Territorio] -> [(Territorio, [Nombre])]
listarNombrePorTerritorio n []     = []
listarNombrePorTerritorio n (t:ts) = (t, [n]) : listarNombrePorTerritorio n ts

asignarNombres :: [Nombre] -> [Nombre] -> [Nombre]
asignarNombres ns []      = ns
asignarNombres [] ns      = ns
asignarNombres (n:ns) ns2 = if elem n ns2
                                then asignarNombres ns ns2
                                else n : asignarNombres ns ns2
