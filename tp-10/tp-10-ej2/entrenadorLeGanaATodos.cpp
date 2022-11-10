#include<iostream>
#include "Entrenador.h"
#include "Pokemon.h"
using namespace std;

int main(){
    Pokemon* pokemones = new Pokemon[3];
    pokemones[0] = consPokemon("Agua");
    pokemones[1] = consPokemon("Fuego");

    //Aun no esta terminado

    cout << "poke: " << pokemones[0] << endl;
    cout << "poke: " << pokemones[1] << endl;
    cout << "poke: " << pokemones[2] << endl;
    
}