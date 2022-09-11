-- 1. Tipos recursivos simples

-- 1.1. Celdas con bolitas

data Color = Azul | Rojo
    deriving Show
data Celda = Bolita Color Celda | CeldaVacia
    deriving Show

celda1 = Bolita Rojo (Bolita Azul (Bolita Rojo (Bolita Azul CeldaVacia)))

-- Dados un color y una celda, indica la cantidad de bolitas de ese color. Nota: pensar si ya
-- existe una operación sobre listas que ayude a resolver el problema.
nroBolitas :: Color -> Celda -> Int
nroBolitas _ CeldaVacia       = 0
nroBolitas c (Bolita col cel) = unoSi (esColor col c) + nroBolitas c cel

unoSi :: Bool -> Int
unoSi True = 1
unoSi False = 0

esColor :: Color -> Color -> Bool
esColor Azul Azul = True
esColor Rojo Rojo = True
esColor _ _       = False

-- Dado un color y una celda, agrega una bolita de dicho color a la celda.
poner :: Color -> Celda -> Celda
poner c cel = Bolita c cel

-- Dado un color y una celda, quita una bolita de dicho color de la celda. Nota: a diferencia de
-- Gobstones, esta función es total.
sacar :: Color -> Celda -> Celda
sacar _ CeldaVacia       = CeldaVacia
sacar c (Bolita col cel) = if esColor col c
                              then cel
                              else Bolita col (sacar c cel)

-- Dado un número n, un color c, y una celda, agrega n bolitas de color c a la celda.
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 _ cel = cel 
ponerN n c cel = ponerN (n-1) c (poner c cel) 


-- 1.2. Camino hacia el tesoro

data Objeto = Cacharro | Tesoro
data Camino = Fin | Cofre [Objeto] Camino | Nada Camino

camino1 = Cofre [Cacharro, Cacharro] (Nada (Cofre [Cacharro] (Cofre [Cacharro,Tesoro] Fin)))
camino2 = Cofre [Cacharro, Cacharro] (Nada (Cofre [Cacharro] (Cofre [Cacharro] Fin)))
camino3 = Cofre [Cacharro, Cacharro] (Nada (Cofre [Cacharro] (Cofre [Cacharro,Tesoro] (Cofre [Tesoro,Tesoro] (Nada Fin)))))


-- Indica si hay un cofre con un tesoro en el camino.
hayTesoro :: Camino -> Bool
hayTesoro Fin          = False
hayTesoro (Nada c)     = hayTesoro c 
hayTesoro (Cofre os c) = tieneTesoro os || hayTesoro c

tieneTesoro :: [Objeto] -> Bool
tieneTesoro []     = False
tieneTesoro (o:os) = esTesoro o || tieneTesoro os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

-- Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
-- Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
-- Precondición: tiene que haber al menos un tesoro.
pasosHastaTesoro :: Camino -> Int
pasosHastaTesoro Fin            = error "No existe un tesoro"
pasosHastaTesoro (Nada cam)     = 1 + pasosHastaTesoro cam 
pasosHastaTesoro (Cofre os cam) = if tieneTesoro os
                                    then 0
                                    else 1 + pasosHastaTesoro cam

-- Indica si hay al menos “n” tesoros en el camino.
alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros 0 _ = True 
alMenosNTesoros n c = cantidadDeTesoros c>=n

cantidadDeTesoros :: Camino -> Int
cantidadDeTesoros Fin          = 0 
cantidadDeTesoros (Nada c)     = cantidadDeTesoros c
cantidadDeTesoros (Cofre os c) = if tieneTesoro os
                                  then 1 + cantidadDeTesoros c
                                  else cantidadDeTesoros c

-- Dado un rango de pasos, indica la cantidad de tesoros que hay en ese rango. Por ejemplo, si
-- el rango es 3 y 5, indica la cantidad de tesoros que hay entre hacer 3 pasos y hacer 5. Están
-- incluidos tanto 3 como 5 en el resultado.
cantTesorosEntre :: Int -> Int -> Camino -> Int






