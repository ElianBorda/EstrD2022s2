#include<iostream>
#include "Persona.h"
using namespace std;

int main(){
    Persona elian = consPersona("Elian", 19);
    cambioDeNombre("Camilo", elian);
    cout << elian << " nombre: " << nombre(elian) << " edad: " << edad(elian) << endl;
}