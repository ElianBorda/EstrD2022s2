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
aplanar (x:xs) = agregar x (aplanar xs)

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
elMinimo (x:x2:xs) = if x<x2
                        then elMinimo (x:xs)
                        else elMinimo (x2:xs)

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


