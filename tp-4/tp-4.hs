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