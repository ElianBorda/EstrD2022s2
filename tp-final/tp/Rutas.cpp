#include <iostream>
#include <iomanip>
using namespace std;

#include "Rutas.h"
#include "Ruta.h"

struct NodeRs {
  Ruta    value;        // INV. REP.:
  NodeRs* next;         //  * los punteros internos NO son compartidos
};
struct RutasHeaderSt {  // INV. REP.:
  NodeRs* first;        //  * first = NULL sii last  = NULL
  int     size;         //  * size es la cant. de nodos a recorrer
  NodeRs* last;         //  *   hasta llegar a un NULL desde first
};                      //  * si last != NULL, last->next = NULL

struct RutasIteratorSt {
  NodeRs* current;
};

Rutas emptyRutas() {    // O(1)  
  RutasHeaderSt* rs = new RutasHeaderSt;
  rs->first = NULL;
  rs->last  = NULL;
  rs->size  = 0;
  return rs;
}

bool isEmptyRutas(Rutas rs) {  // O(1)
  return (rs->size==0);
}

void ConsRuta(Ruta r, Rutas rs) {  // O(1)
  NodeRs* node = new NodeRs;
  node->value = r;
  node->next  = rs->first;
  rs->first    = node;
  if (rs->last == NULL) { rs->last = node; }
  rs->size++;
}

void SnocRuta(Rutas rs, Ruta r) {  // O(1)
  NodeRs* node = new NodeRs;
  node->value = r;
  node->next  = NULL;
  if (rs->last == NULL) { rs->first = node;      }
  else                  { rs->last->next = node; }
  rs->last = node;
  rs->size++;
}

void LiberarRutas(Rutas rs) {  // O(n)
  NodeRs* temp;
  while (rs->first!=NULL) {  
    temp = rs->first;
    rs->first = rs->first->next;
    delete(temp);
  }
  delete(rs);
}

Rutas copiarRutas(Rutas rs) {
  Ruta r;
  Rutas rsCopy = emptyRutas();
  RutasIterator irs = iniciarRecorridoDeRutas(rs);
  while(not estaAlFinalDeLasRutas(irs)) {
    r = copiarRuta(rutaActual(irs));
    SnocRuta(rsCopy, r);
    AvanzarASiguienteRuta(irs);
  }
  LiberarRutasIterator(irs);
  return(rsCopy);
}

void ExtenderTodasLasRutasCon(Boca b, Rutas rs) {
   RutasIterator irs = iniciarRecorridoDeRutas(rs);
   while (not estaAlFinalDeLasRutas(irs)) {
    ConsBoca(b, rutaActual(irs));
    AvanzarASiguienteRuta(irs);
   }
   LiberarRutasIterator(irs);
}

void AgregarA_LasRutasDe_(Rutas rs1, Rutas rs2) {
   if (rs2->first!=NULL) {
     if (rs1->last == NULL) { rs1->first      = rs2->first; }
     else                   { rs1->last->next = rs2->first; }
     rs1->last = rs2->last;
   }
   rs1->size += rs2->size;
   delete(rs2);
}

// PARA MOSTRADO DE lista de Rutas
void PadRs(int offset) {
  for(int i=0; i<offset; i++) {
    cout << " ";
  }
}

void ShowRutas(Rutas rs, int offset) {
  NodeRs* current = rs->first;
  PadRs(offset);
  cout << "[";
  if (current!=NULL) {
    cout << " ";
    ShowRuta(current->value);
    cout << "\n";
    current = current->next;
  }
  while (current!=NULL) {  
    PadRs(offset);
    cout << ", ";
    ShowRuta(current->value);
    current = current->next;
    cout << "\n";
  }
  if (rs->first!=NULL) { PadRs(offset); }
  cout << "]";
}

RutasIterator iniciarRecorridoDeRutas(Rutas rs) {
  RutasIteratorSt* irs = new RutasIteratorSt;
  irs->current = rs->first;
  return(irs);
}

bool estaAlFinalDeLasRutas(RutasIterator irs) {
  return (irs->current == NULL);
}

Ruta rutaActual(RutasIterator irs) {
  // PRECOND: no está al fin del recorrido
  return(irs->current->value);
}

void AvanzarASiguienteRuta(RutasIterator irs){
  // PRECOND: no está al fin del recorrido
  irs->current = irs->current->next;
}

void LiberarRutasIterator(RutasIterator irs) {
  delete irs;
}
