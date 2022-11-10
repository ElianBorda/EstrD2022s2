#include <iostream>
#include "ArrayList.h"
using namespace std;

int main(){
    ArrayList xs = newArrayList();
    set(0, 29, xs);
    set(1, 99, xs);
    set(2, 82, xs);
    set(3, 5, xs);
    
    cout << "posicion 2: " << get(2, xs) << endl;
}
