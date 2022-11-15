#include <iostream>
#include <iomanip>
using namespace std;

#include "Clientes.h"
#include "Cliente.h"

struct NodeCs {
  Cliente value;    // INV. REP.:
  NodeCs* next;     //  * los punteros internos NO son compartidos
};
struct CsHeaderSt {  // INV. REP.:
  NodeCs* first;        //  * first = NULL sii last  = NULL
  int    size;         //  * size es la cant. de nodos a recorrer
  NodeCs* last;         //  *   hasta llegar a un NULL desde first
};                     //  * si last != NULL, last->next = NULL

struct CsIteratorSt {
  NodeCs* current;
};

Clientes emptyClientes() {    // O(1)  
  CsHeaderSt* cs = new CsHeaderSt;
  cs->first = NULL;
  cs->last  = NULL;
  cs->size  = 0;
  return cs;
}

bool isEmptyClientes(Clientes cs) {    // O(1)  
  return(cs->size==0);
}

void ConsCliente(Cliente c, Clientes cs) {  // O(1)
  NodeCs* node = new NodeCs;
  node->value = c;
  node->next  = cs->first;
  cs->first    = node;
  if (cs->last == NULL) { cs->last = node; }
  cs->size++;
}

void SnocCliente(Clientes cs, Cliente c) {  // O(1)
  NodeCs* node = new NodeCs;
  node->value = c;
  node->next  = NULL;
  if (cs->last == NULL) { cs->first = node;      }
  else                  { cs->last->next = node; }
  cs->last = node;
  cs->size++;
}

void LiberarClientes(Clientes cs) {  // O(n)
  NodeCs* temp;
  while (cs->first!=NULL) {  
    temp = cs->first;
    cs->first = cs->first->next;
    delete(temp);
  }
  delete(cs);
}

void ShowClientes(Clientes cs) {
  NodeCs* current = cs->first;
  cout << "[";
  if (current!=NULL) {
    cout << " " << nombre(current->value);
    current = current->next;
  }
  while (current!=NULL) {  
    cout << ", " << nombre(current->value);
    current = current->next;
  }
  cout << " ]";
}

ClientesIterator iniciarRecorridoClientes(Clientes cs) {
  CsIteratorSt* ics = new CsIteratorSt;
  ics->current = cs->first;
  return(ics);
}

bool estaAlFinalDeLosClientes(ClientesIterator ics) {
  return (ics->current == NULL);
}

Cliente clienteActual(ClientesIterator ics) {
  // PRECOND: no está al fin del recorrido
  return(ics->current->value);
}

void AvanzarASiguienteCliente(ClientesIterator ics){
  // PRECOND: no está al fin del recorrido
  ics->current = ics->current->next;
}

void LiberarClientesIterator(ClientesIterator ics) {
  delete ics;
}
