#include<iostream>
#include "Entrenador.h"
#include "Pokemon.h"
using namespace std;

int main(){
    Pokemon* pokemones = new Pokemon[2];
    pokemones[0] = consPokemon("Agua");
    pokemones[1] = consPokemon("Fuego");
    pokemones[2] = consPokemon("Fuego");

    Entrenador e = consEntrenador("Jose", 3, pokemones);

    int x = cantidadDePokemon(e);

    for (int i = 0; i < x; i++){
        cout << "nombre de entrenador: " << nombreDeEntrenador(e) << " pokemon que posee: " << tipoDePokemon(pokemonNro(i,e)) << endl;
    }
}