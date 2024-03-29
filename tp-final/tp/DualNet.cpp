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
  DualNet dn = new DNHeaderSt;
  dn->mcr = emptyMCR();
  dn->sw  = newSwitch();
  return dn;
}

int cantidadDeClientesConectados(DualNet dn) {
  return sizeMCR(dn->mcr); 
}

bool estaDisponible(Ruta r, DualNet dn) {
  RutasIterator rs = iniciarRecorridoDeRutas(disponiblesADistancia(dn->sw, lenRuta(r)));
  while (!estaAlFinalDeLasRutas(rs) && !mismaRuta(rutaActual(rs), r)){
    AvanzarASiguienteRuta(rs);
  }
  return !estaAlFinalDeLasRutas(rs);
}

void ConectarCliente(Ruta r, Cliente c, DualNet dn) {
  if (lookupMCR(c, dn->mcr) != NULL){
    Desconectar(lookupMCR(c, dn->mcr), dn->sw);
  }
  AddMCR(c, r, dn->mcr);
  Conectar(c, r, dn->sw);
}

void DesconectarCliente(Cliente c, DualNet dn) {
  Desconectar(lookupMCR(c, dn->mcr), dn->sw);
  DeleteMCR(c, dn->mcr);
}

BinHeapC pinPorCliente(DualNet dn) {
  BinHeapC bh = emptyHC();
  ClientesIterator cs = iniciarRecorridoClientes(keysMCR(dn->mcr));
  while(!estaAlFinalDeLosClientes(cs)){
    InsertHC(lenRuta(lookupMCR(clienteActual(cs), dn->mcr)), clienteActual(cs), bh);
    AvanzarASiguienteCliente(cs);
  }
  return bh;
}

void LiberarDN(DualNet dn) {
  LiberarMCR(dn->mcr);
  LiberarSwitch(dn->sw);
  delete dn;
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

