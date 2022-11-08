#include<iostream>
#include "Pokemon.h"
using namespace std;

int main(){
    Pokemon p = consPokemon("Agua");
    perderEnergia(20, p);
    cout << "tipo: " << tipoDePokemon(p) << " energia: " << energia(p) << endl;
}