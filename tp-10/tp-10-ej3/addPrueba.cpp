#include <iostream>
#include "ArrayList.h"
using namespace std;

int main(){
    ArrayList xs = newArrayListWith(4);
    add(35, xs);
    add(20, xs);
    add(50, xs);
    add(100, xs);


    cout << "posicion 0: " << get(0, xs) << endl;
    cout << "posicion 1: " << get(1, xs) << endl;
    cout << "posicion 2: " << get(2, xs) << endl;
    cout << "posicion 3: " << get(3, xs) << endl;
}