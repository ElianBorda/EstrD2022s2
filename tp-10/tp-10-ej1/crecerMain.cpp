#include<iostream>
#include "Persona.h"
using namespace std;

int main(){
    Persona jose = consPersona("Jose", 30);
    crecer(jose);
    cout << jose << " nombre: " << nombre(jose) << " edad: " << edad(jose) << endl;
}