#include<iostream>
#include "ArrayList.h"
using namespace std;

int sumatoria(ArrayList xs) {
    int n = 0;
    for (int i = 0; i < lengthAL(xs); i++){
        n = n + get(i, xs);
    }
    return n; 
    
}
// Devuelve la suma de todos los elementos.

void sucesores(ArrayList xs){
    for (int i = 0; i < lengthAL(xs); i++){
       set(i,get(i, xs)+1, xs);
    }
}
// Incrementa en uno todos los elementos.

bool pertenece(int x, ArrayList xs){
    int i = 0;
    while (i<lengthAL(xs) && x!=get(i, xs)){
        i++;
    }
    return x==get(i, xs);
}
// Indica si el elemento pertenece a la lista.

int apariciones(int x, ArrayList xs){
    int n = 0;
    for (int i = 0; i < lengthAL(xs); i++){
        n = n + unoSiCeroSino(x==get(i, xs));
    }
    return n;
}
// Indica la cantidad de elementos iguales a x.

int unoSiCeroSino(bool x){
    if (x){
        return 1;
    } else {
        return 0;
    }
}

ArrayList append(ArrayList xs, ArrayList ys){
    ArrayList al = newArrayListWith(lengthAL(xs) + lengthAL(ys));

    for (int i = 0; i < lengthAL(xs); i++){
        add(get(i, xs), al);
    }
    for (int i = lengthAL(xs); i < (lengthAL(ys)+lengthAL(xs)); i++){
        add(get(i, ys), al);
    }
    return al;  
}
// Crea una nueva lista a partir de la primera y la segunda (en ese orden).

int minimo(ArrayList xs){}
// Devuelve el elemento más chico de la lista.