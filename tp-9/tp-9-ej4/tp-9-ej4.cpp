#include<iostream>
using namespace std;

// Ejercicio 4

// Dar dos implementaciones para las siguientes funciones, una iterativa y otra recursiva, y utilizando
// la menor cantidad posible de variables. Recordar definir subtareas en caso de que sea estrictamente
// necesario.


// Propósito: imprime n veces un string s.

void printN(int n, string s){ //iterativa
    while (n > 0){
        cout << s << endl;
        n--;
    }
    cout << endl;
}

void printN(int n, string s){ //recursiva
    if (n == 0){
        cout << endl;
    } else {
        cout << s << endl;
        printN(n-1, s);
    }
}


