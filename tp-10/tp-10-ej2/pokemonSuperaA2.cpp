#include<iostream>
#include "Pokemon.h"
using namespace std;

int main(){
    Pokemon p1 = consPokemon("Fuego");
    Pokemon p2 = consPokemon("Agua");
    cout << "el primer pokemon supera al primero:  " << superaA(p1, p2) << endl;
}