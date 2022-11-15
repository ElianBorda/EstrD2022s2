#include <iostream>
using namespace std;

#include "Ruta.h"
#include "Rutas.h"
#include "Clientes.h"
#include "BinHeapC.h"

struct  DNHeaderSt;
typedef DNHeaderSt* DualNet; // INV.REP.: el puntero NO es NULL

DualNet emptyDN();
int cantidadDeClientesConectados(DualNet dn);
bool estaDisponible(Ruta r, DualNet dn);
void ConectarCliente(Ruta r, Cliente c, DualNet dn);
void DesconectarCliente(Cliente c, DualNet dn);
BinHeapC pinPorCliente(DualNet dn);

void LiberarDN(DualNet dn);
void ShowDualNet(DualNet dn);