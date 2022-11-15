#include <iostream>
using namespace std;

#include "BinHeapC.h"
#include "Cliente.h"
#include "Clientes.h"

int main() {
    Cliente maria     = cliente("Maria");
    Cliente juan      = cliente("Juan");
    Cliente constanza = cliente("Constanza");
    Cliente luisa     = cliente("Luisa");
    Cliente pedro     = cliente("Pedro");

    BinHeapC h = emptyHC();
    InsertHC(2, maria    , h);
    InsertHC(5, juan     , h);
    InsertHC(1, constanza, h);
    InsertHC(3, luisa    , h);
    InsertHC(7, pedro    , h);
    cout << "El mínimo es " << nombre(findMinClienteHC(h)) << " con pin " << findMinPinHC(h) << ".\n";
    ShowHC(h, 0);
    DeleteMinHC(h);
    cout << "El mínimo es " << nombre(findMinClienteHC(h)) << " con pin " << findMinPinHC(h) << ".\n";
    ShowHC(h, 1);
    DeleteMinHC(h);
    cout << "El mínimo es " << nombre(findMinClienteHC(h)) << " con pin " << findMinPinHC(h) << ".\n";
    ShowHC(h, 2);
    DeleteMinHC(h);
    cout << "El mínimo es " << nombre(findMinClienteHC(h)) << " con pin " << findMinPinHC(h) << ".\n";
    ShowHC(h, 3);   
}