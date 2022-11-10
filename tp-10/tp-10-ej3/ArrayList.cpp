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
    int* array = xs->elementos;
    xs->elementos = new int[capacidad];
    if(xs->capacidad <= capacidad && xs->cantidad <= capacidad){
        for (int i = 0; i < xs->cantidad; i++){
            xs->elementos[i] = array[i];
        }
    } else {
        for(int i = 0; i < capacidad; i++){
            xs->elementos[i] = array[i];
        }
        xs->cantidad = capacidad;
    }
    xs->capacidad = capacidad;


    
}

void add(int x, ArrayList xs){
        xs->cantidad++;
        int i = 0;
        while(i<xs->cantidad){
            i++;
        }
        xs->elementos[i] = x;
}

void remove(ArrayList xs){
    int i = 0;
    while (i<xs->cantidad){
        i++;
    }
    delete (xs->elementos + i);
}