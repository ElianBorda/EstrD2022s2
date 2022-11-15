#include <iostream>
#include <string.h>
using namespace std;

#include "MapCR.h"
#include "Ruta.h"
#include "Cliente.h"
#include "Clientes.h"

int main() {
    Cliente maria     = cliente("Maria");
    Cliente juan      = cliente("Juan");
    Cliente constanza = cliente("Constanza");
    Cliente luisa     = cliente("Luisa");
    Cliente pedro     = cliente("Pedro");
    Cliente kevin     = cliente("Kevin");
    Cliente tatiana   = cliente("Tatiana");
    Cliente ana       = cliente("Ana");
    Cliente diana     = cliente("Diana");

    Ruta ruta0 = rutaVacia();
    Ruta ruta1 = rutaVacia();
    ConsBoca(Boca1, ruta1);
    ConsBoca(Boca2, ruta1);

    Ruta ruta2 = copiarRuta(ruta1);
    ConsBoca(Boca2, ruta2);

    Ruta ruta3 = copiarRuta(ruta2);
    ConsBoca(Boca1, ruta3);
    ConsBoca(Boca1, ruta3);

    Ruta ruta4 = copiarRuta(ruta3);
    ConsBoca(Boca2, ruta4);

    MapCR mcr = emptyMCR();
    AddMCR(juan     , ruta0, mcr);
    AddMCR(maria    , ruta1, mcr);
    AddMCR(constanza, ruta2, mcr);
    AddMCR(kevin    , ruta3, mcr);
    AddMCR(luisa    , ruta3, mcr);
    AddMCR(pedro    , ruta4, mcr);
    AddMCR(tatiana  , ruta0, mcr);
    AddMCR(ana      , ruta0, mcr);
    AddMCR(diana    , ruta2, mcr);
    
    ShowClientes(keysMCR(mcr)); cout << "\n";
    ShowMapCR(mcr, 3);
    ShowMapAsBST(mcr, 1);
}