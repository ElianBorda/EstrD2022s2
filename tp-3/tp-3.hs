-- 1. Tipos recursivos simples

-- 1.1. Celdas con bolitas

data Color = Azul | Rojo
data Celda = Bolita Color Celda | CeldaVacia

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



