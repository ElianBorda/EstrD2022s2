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







