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

    cout << "nombre de entrenador: " << nombreDeEntrenador(e) << " Cantidad de tipo Agua: " << cantidadDePokemonDe("Agua", e) << endl;
    cout << "nombre de entrenador: " << nombreDeEntrenador(e) << " Cantidad de tipo Fuego: " << cantidadDePokemonDe("Fuego", e) << endl;
    cout << "nombre de entrenador: " << nombreDeEntrenador(e) << " Cantidad de tipo Planta: " << cantidadDePokemonDe("Planta", e) << endl;

}