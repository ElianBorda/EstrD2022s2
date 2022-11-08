#include<iostream>
#include "Pokemon.h"
using namespace std;

struct PokeSt {
    TipoDePokemon tipo;
    int vida;
};

Pokemon consPokemon(TipoDePokemon tipo){
    Pokemon p = new PokeSt;
    p->tipo = tipo;
    p->vida = 100;
    return p;
}

TipoDePokemon tipoDePokemon(Pokemon p){
    return p->tipo;
}

int energia(Pokemon p){
    return p->vida;
}

void perderEnergia(int energia, Pokemon p){
    if(p->vida > energia){
        p->vida - energia;
    }
    else{
        p->vida = 0;
    }
}

bool superaA(Pokemon p1, Pokemon p2){
    
    if(p1->tipo == "Agua" && p2->tipo == "Fuego"){
        return true;
    } 
    else if (p1->tipo == "Fuego" && p2->tipo == "Planta"){
        return true;
    }
    else if (p1->tipo == "Planta" && p2->tipo == "Agua"){
        return true;
    }
    else {
        return false;
    }
    
}