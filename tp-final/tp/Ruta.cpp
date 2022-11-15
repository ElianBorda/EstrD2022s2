#include <iostream>
#include <iomanip>
using namespace std;

#include "Ruta.h"

struct NodeR {
  Boca   value;        // INV. REP.:
  NodeR* next;         //  * los punteros internos NO son compartidos
};
struct RutaHeaderSt {  // INV. REP.:
  NodeR* first;        //  * first = NULL sii last  = NULL
  int    size;         //  * size es la cant. de nodos a recorrer
  NodeR* last;         //  *   hasta llegar a un NULL desde first
};                     //  * si last != NULL, last->next = NULL

struct RutaIteratorSt {
  NodeR* current;
};

Ruta rutaVacia() {    // O(1)  
  RutaHeaderSt* r = new RutaHeaderSt;
  r->first = NULL;
  r->last  = NULL;
  r->size  = 0;
  return r;
}

int  lenRuta(Ruta r) {
  return(r->size);
}

bool mismaRuta(Ruta r1, Ruta r2) {
  RutaIterator ir1 = iniciarRuta(r1);
  RutaIterator ir2 = iniciarRuta(r2);
  bool iguales = true;
  while (not estaAlFinalDeLaRuta(ir1) 
      && not estaAlFinalDeLaRuta(ir2)) {
    iguales = iguales && bocaActual(ir1) == bocaActual(ir2);
    AvanzarEnRuta(ir1);
    AvanzarEnRuta(ir2);
  }
  return(iguales);
}

void ConsBoca(Boca boca, Ruta r) {  // O(1)
  NodeR* node = new NodeR;
  node->value = boca;
  node->next  = r->first;
  r->first    = node;
  if (r->last == NULL) { r->last = node; }
  r->size++;
}

void SnocBoca(Ruta r, Boca boca) {  // O(1)
  NodeR* node = new NodeR;
  node->value = boca;
  node->next  = NULL;
  if (r->last == NULL) { r->first = node;      }
  else                 { r->last->next = node; }
  r->last = node;
  r->size++;
}

Ruta copiarRuta(Ruta r) {
  Ruta rCopy = rutaVacia();
  RutaIterator ir = iniciarRuta(r);
  while(not estaAlFinalDeLaRuta(ir)) {
    SnocBoca(rCopy, bocaActual(ir));
    AvanzarEnRuta(ir);
  }
  LiberarRutaIterator(ir);
  return(rCopy);
}

void LiberarRuta(Ruta r) {  // O(n)
  NodeR* temp;
  while (r->first!=NULL) {  
    temp = r->first;
    r->first = r->first->next;
    delete(temp);
  }
  delete(r);
}

void ShowRuta(Ruta r) {
  NodeR* current = r->first;
  cout << "<";
  if (current!=NULL) {
    cout << current->value;
    current = current->next;
  }
  while (current!=NULL) {  
    cout << current->value;
    current = current->next;
  }
  cout << ">";
}

RutaIterator iniciarRuta(Ruta r) {
  RutaIteratorSt* ir = new RutaIteratorSt;
  ir->current = r->first;
  return(ir);
}

bool estaAlFinalDeLaRuta(RutaIterator ir) {
  return (ir->current == NULL);
}

Boca bocaActual(RutaIterator ir) {
  // PRECOND: no está al fin del recorrido
  return(ir->current->value);
}

void AvanzarEnRuta(RutaIterator ir){
  // PRECOND: no está al fin del recorrido
  ir->current = ir->current->next;
}

void LiberarRutaIterator(RutaIterator ir) {
  delete ir;
}
