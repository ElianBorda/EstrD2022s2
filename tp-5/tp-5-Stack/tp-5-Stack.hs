import StackV1


apilar :: [a] -> Stack a
-- Dada una lista devuelve una pila sin alterar el orden de los elementos.
apilar xs = apilarEn xs (emptyS)

apilarEn :: [a] -> Stack a -> Stack a
apilarEn [] s     = s
apilarEn (x:xs) s = apilarEn xs (push x s) 


-- apilar' []     = (emptyS)
-- apilar' (x:xs) = push x (apilar' xs) 


desapilar :: Stack a -> [a]
-- Dada una pila devuelve una lista sin alterar el orden de los elementos.
desapilar  s = if isEmptyS s
                  then []
                  else top s : desapilar (pop s)


insertarEnPos :: Int -> a -> Stack a -> Stack a
-- Dada una posicion válida en la stack y un elemento, ubica dicho elemento en dicha
-- posición (se desapilan elementos hasta dicha posición y se inserta en ese lugar).
insertarEnPos 0 x s = push x s
insertarEnPos n x s = push (top s) (insertarEnPos (n-1) x (pop s))