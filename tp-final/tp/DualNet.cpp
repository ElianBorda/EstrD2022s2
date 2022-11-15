#include <iostream>
using namespace std;

#include "DualNet.h"
#include "Ruta.h"
#include "Rutas.h"
#include "Cliente.h"
#include "Clientes.h"
#include "MapCR.h"
#include "Switch.h"
#include "BinHeapC.h"

struct  DNHeaderSt {
  MapCR  mcr;
  Switch sw;
  /* INV.REP.:
      * si un cliente c en el map mrc está asociado a una ruta r
        entonces el switch sw tiene a c conectado en la ruta r
      * si un cliente c está conectado en la ruta r en el switch sw
        entonces c está asociado a r en el map mcr
  */
};

DualNet emptyDN() {
  // COMPLETAR
  return(NULL);
}

int cantidadDeClientesConectados(DualNet dn) {
  // COMPLETAR
  return(0); // REEMPLAZAR
}

bool estaDisponible(Ruta r, DualNet dn) {
  // COMPLETAR
  return(false); // REEMPLAZAR
}

void ConectarCliente(Ruta r, Cliente c, DualNet dn) {
  // COMPLETAR
}

void DesconectarCliente(Cliente c, DualNet dn) {
  // COMPLETAR
}

BinHeapC pinPorCliente(DualNet dn) {
  // COMPLETAR
  return(NULL); // REEMPLAZAR
}

void LiberarDN(DualNet dn) {
  // COMPLETAR
}

void ShowDualNet(DualNet dn) {
  cout << "=======" << endl;
  cout << "DUALNET" << endl;
  cout << "=======" << endl;
  cout << "Map Clientes->Ruta" << endl;
  ShowMapCR(dn->mcr, 2);
  cout << "Switch Clientes" << endl;
  ShowSwitch(dn->sw, 2);
  cout << "=======" << endl;
}

