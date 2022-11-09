#include<iostream>
#include "Entrenador.h"
#include "Pokemon.h"
using namespace std;

int main(){
    Pokemon* pokemones = new Pokemon[2];
    pokemones[0] = consPokemon("Agua");
    pokemones[1] = consPokemon("Fuego");
    pokemones[2] = consPokemon("Fuego");

    //Aun no esta terminado
}