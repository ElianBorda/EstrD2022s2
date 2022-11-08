#include<iostream>
#include "Persona.h"
using namespace std;

int main(){
    Persona elian = consPersona("Elian", 19);
    Persona alan = consPersona("Alan", 17);
    cout << "Se retorna el que es mayor " << nombre(laQueEsMayor(elian, alan)) << endl;
}