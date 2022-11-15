#include<iostream>
#include "LinkedList.h"
using namespace std;

struct NodoL {
    int elem; // valor del nodo
    NodoL* siguiente; // puntero al siguiente nodo
};

struct LinkedListSt {
    // INV.REP.: cantidad indica la cantidad de nodos que se pueden recorrer
    // desde primero por siguiente hasta alcanzar a NULL

    int cantidad; // cantidad de elementos
    NodoL* primero; // puntero al primer nodo
};

struct IteratorSt {
    NodoL* current;
};

LinkedList nil(){
    LinkedList xs = new LinkedListSt;
    xs->cantidad = 0;
    xs->primero = NULL;
    return xs;
}

bool isEmpty(LinkedList xs){
    return xs->cantidad == 0;
}

int head(LinkedList xs){
    return xs->primero->elem;
}

void Cons(int x, LinkedList xs){
    NodoL* n = new NodoL;
    n->siguiente = xs->primero;
    n->elem = x;
    xs->primero = n;
    xs->cantidad++
}

void Tail(LinkedList xs){
    NodoL* n = xs->primero;
    xs->primero = xs->primero->siguiente;
    delete n; 
    xs->cantidad--
}

int length(LinkedList xs){
    return xs->cantidad;
}

void Snoc(int x, LinkedList xs){ 
    NodoL* nodo = new NodoL;
    nodo->elem = x;
    nodo->siguiente = xs->primero;

    while (nodo->siguiente != NULL){
        nodo = nodo->siguiente;
    }
    nodo = nodo->siguiente;
    xs->cantidad++;
}

ListIterator getIterator(LinkedList xs){
    ListIterator g = new IteratorSt;
    g->current = xs->primero;
    return g;
}

int current(ListIterator ixs){
    return ixs->current->elem;
}

void SetCurrent(int x, ListIterator ixs){
    ixs->current->elem = x;
}

void Next(ListIterator ixs){
    ixs->current = ixs->current->siguiente;
}

bool atEnd(ListIterator ixs){
    return (ixs->current == NULL) || (ixs->current->siguiente == NULL);
}

void DisposeIterator(ListIterator ixs){
    delete ixs;
}

void DestroyL(LinkedList xs){
    NodoL* u;
    while(xs->primero != NULL){
         u = xs->primero;
         xs->primero = xs->primero->siguiente;
         delete u;
    }
    delete xs;
}

void Append(LinkedList xs, LinkedList ys){
    NodoL* u = xs->primero;
    while ( u->siguiente != NULL){
        u = u->siguiente;
    }
    u->siguiente = ys->primero;
    xs->cantidad += ys->cantidad;
    DestroyL(ys);
}