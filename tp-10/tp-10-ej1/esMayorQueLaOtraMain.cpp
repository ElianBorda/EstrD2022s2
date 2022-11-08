#include<iostream>
#include "Persona.h"
using namespace std;

int main(){
    Persona elian = consPersona("Elian", 19);
    Persona alan = consPersona("Alan", 17);
    cout << nombre(elian) << " es mayor que " << nombre(alan) << " " << esMayorQueLaOtra(elian, alan) << endl;
}