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

