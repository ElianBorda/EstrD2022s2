using namespace std;
#include<iostream>
#include "Par.h"

int main(){
    Par p;
    p = consPar(10, 3);
    cout << "Primer componente: " << fst(p) << endl; 
    cout << "Segundo componente: " << snd(p) << endl; 
    cout << "El maximo componente: " << maxDelPar(p) << endl; 
    cout << "Antes de swap: " << "(" << fst(p) << ", " << snd(p) << ")" << endl;
    cout << "despues de swap: " << "(" << fst(swap(p)) << ", " << snd(swap(p)) << ")" << endl; 
    cout << "Division de 10/3: " << "(" << fst(divisionYResto(10, 3)) << ", " << snd(divisionYResto(10, 3)) << ")" << endl; 
}
