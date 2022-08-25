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
                        then fst (n, m)
                        else snd (n, m)

{- 2.De 4 ejemplos de expresiones diferentes que denoten el número 10, utilizando en cada expresión 
     a todas las funciones del punto anterior.
     Ejemplo: maxDePar (divisionYResto (suma 5 5) (sucesor 0)) -}

-- (1)
-- sumar (maxDelPar (8, 2)) (fst (divisionYResto (8, (sucesor 3))))

-- (2)

 
