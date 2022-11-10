#include <iostream>
#include "ArrayList.h"
using namespace std;

int main(){
    ArrayList xs = newArrayListWith(4);
    set(0, 29, xs);
    set(1, 99, xs);
    set(2, 82, xs);
    
    add(35, xs);

    cout << "posicion 0: " << get(0, xs) << endl;
    cout << "posicion 1: " << get(1, xs) << endl;
    cout << "posicion 2: " << get(2, xs) << endl;
    cout << "posicion 3: " << get(3, xs) << endl;
}