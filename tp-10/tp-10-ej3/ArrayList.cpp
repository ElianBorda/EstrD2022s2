#include<iostream>
#include "ArrayList.h"
using namespace std;

struct ArrayListSt {
    int cantidad; // cantidad de elementos
    int* elementos; // array de elementos
    int capacidad; // tamaño del array
};

ArrayList newArrayList(){
    ArrayList xs = new ArrayListSt;
    xs->cantidad = 0;
    xs->elementos = new int[15];
    xs->capacidad = 16;

    return xs;
}

ArrayList newArrayListWith(int capacidad){
    ArrayList xs = new ArrayListSt;
    xs->cantidad = 0;
    xs->elementos = new int[capacidad];
    xs->capacidad = capacidad;

    return xs;
}

int lengthAL(ArrayList xs){
    return xs->cantidad;
}

int get(int i, ArrayList xs){
    return xs->elementos[i];
}

void set(int i, int x, ArrayList xs){
     xs->elementos[i] = x;
}

void resize(int capacidad, ArrayList xs){
}