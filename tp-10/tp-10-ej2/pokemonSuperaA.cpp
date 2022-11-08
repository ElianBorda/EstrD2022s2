#include<iostream>
#include "Pokemon.h"
using namespace std;

int main(){
    Pokemon p1 = consPokemon("Agua");
    Pokemon p2 = consPokemon("Fuego");
    cout << "el primer pokemon supera al primero:  " << superaA(p1, p2) << endl;
}