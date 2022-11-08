#include<iostream>
#include "Persona.h"
using namespace std;

int main(){
    Persona carlos = consPersona("Carlos", 20);
    cout << carlos << " nombre: " << nombre(carlos) << " edad: " << edad(carlos) << endl;
}
