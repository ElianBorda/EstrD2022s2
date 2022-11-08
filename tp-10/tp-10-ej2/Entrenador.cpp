#include<iostream>
#include "Entrenador.h"
using namespace std;

struct EntrenadorSt {
    string nombre;
    Pokemon* pokemon;
    int cantPokemon;
};

Entrenador consEntrenador(string nombre, int cantidad, Pokemon* pokemon){
    Entrenador e = new EntrenadorSt;
    e->nombre = nombre;
    e->cantPokemon = cantidad;
    e->pokemon = new Pokemon[cantidad];
    return e;
}

string nombreDeEntrenador(Entrenador e){
    return e->nombre;
}

int cantidadDePokemon(Entrenador e){
    return e->cantPokemon;
}

int cantidadDePokemonDe(TipoDePokemon tipo, Entrenador e){
    int x = 0;
    for (int i = 0; i < e->cantPokemon; i++){
        if(tipoDePokemon(e->pokemon[i]) == tipo){
            x++;
        }
    }

    return x;
}

Pokemon pokemonNro(int i, Entrenador e){
   return e->pokemon[i];
}


