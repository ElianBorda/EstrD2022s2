module StackV1
        (Stack,emptyS,isEmptyS,push,top,pop,lenS)
    where

data Stack = S [a] Int

emptyS :: Stack a
-- Crea una pila vacía.
emptyS = (Sa [] 0)

isEmptyS :: Stack a -> Bool
-- Dada una pila indica si está vacía.
isEmptyS (Sa xs n) = null xs

push :: a -> Stack a -> Stack a
-- Dados un elemento y una pila, agrega el elemento a la pila.
push x (Sa ys n) = Sa (x:ys) (n+1)

top :: Stack a -> a
-- Dada un pila devuelve el elemento del tope de la pila.
top (Sa ys n) = head ys

pop :: Stack a -> Stack a
-- Dada una pila devuelve la pila sin el primer elemento.
pop (Sa ys n) = (Sa (tail ys) (n-1))

lenS :: Stack a -> Int
-- Dada la cantidad de elementos en la pila.
-- Costo: constante.
lenS (Sa ys n) = n 
