#include <iostream>
#include <string.h>
using namespace std;

#include "DualNet.h"
#include "Ruta.h"
#include "Rutas.h"
#include "Cliente.h"
#include "Clientes.h"
#include "MapCR.h"
#include "Switch.h"
#include "BinHeapC.h"

int main() {
    Cliente maria     = cliente("Maria");
    Cliente juan      = cliente("Juan");
    Cliente constanza = cliente("Constanza");
    Cliente luisa     = cliente("Luisa");
    Cliente tatiana   = cliente("Tatiana");
    Cliente diana     = cliente("Diana");

    Ruta ruta0 = rutaVacia();
    Ruta ruta1 = rutaVacia();
    ConsBoca(Boca1, ruta1);
    Ruta ruta2 = rutaVacia();
    ConsBoca(Boca2, ruta2);
    Ruta ruta12 = rutaVacia();
    ConsBoca(Boca2, ruta12);
    ConsBoca(Boca1, ruta12);
    Ruta ruta121 = rutaVacia();
    ConsBoca(Boca2, ruta121);
    ConsBoca(Boca1, ruta121);
    ConsBoca(Boca2, ruta121);

    DualNet dn = emptyDN();
    ConectarCliente(ruta0,  maria,   dn);
    ConectarCliente(ruta1,  diana,   dn);
    ConectarCliente(ruta12, tatiana, dn);
        
    ShowDualNet(dn);

    cout << "Minimo de heapC: " << findMinPinHC(pinPorCliente(dn)) << " " << nombre(findMinClienteHC(pinPorCliente(dn))) << endl;

    DesconectarCliente(maria, dn);
    ShowDualNet(dn);

    cout << "estaDisponible: " << estaDisponible(ruta12, dn) << endl;

    cout << "Minimo de heapC: " << findMinPinHC(pinPorCliente(dn)) << " " << nombre(findMinClienteHC(pinPorCliente(dn))) << endl;
}