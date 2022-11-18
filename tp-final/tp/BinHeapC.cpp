#include <iostream>
#include <iomanip>
#include <limits.h>
using namespace std;

#include "BinHeapC.h"
#include "Cliente.h"
#include "Clientes.h"

#define MIN_DATA INT_MIN
                 // Macro definida en limits.h

struct BinHeapHeaderSt{
  int      maxSize;
  int      curSize;
  int*     pins;
  Cliente* clientes;
  /* INV.REP.
      * 0 <= curSize < maxSize
      * los arrays pins y clientes tienen la misma cantidad de celdas reservadas,
        y maxSize guarda esa cantidad
      * los elementos válidos de ambos arrays se encuentran entre las posiciones 
        0 y curSize
      * pins[0] guarda el valor más chico posible de ser almacenado        
      * el array pins guarda los elementos según el orden dado por un árbol binario
        completo que mantiene el invariante de Heap

    OBS:
      * los valores (pins[i], clientes[i]) corresponden a los diferentes elementos,
        para 1<=i<=curSize
      * se usará el nombre N como sinónimo de curSize
  */
};

BinHeapC emptyHC() { // O(1)
  BinHeapC h = new BinHeapHeaderSt;
  h->maxSize = 16;
  h->curSize = 0;
  h->pins = new int[h->maxSize];
  h->clientes = new Cliente[h->maxSize];
  h->pins[0] = INT_MIN; // macro de h.limits
  return h;
} 

bool isEmptyHC(BinHeapC h) {  // O(1)
  return (h->curSize==0);
}

int  findMinPinHC(BinHeapC h) { // O(1)
  // PRECOND: la heap no está vacía
  return (h->pins[1]);
}

Cliente findMinClienteHC(BinHeapC h) { // O(1)
  // PRECOND: la heap no está vacía
  return (h->clientes[1]); 
}

//---------------------------------------
// Auxiliar para ampliar el espacio de elementos de la heap
//  en caso de ser necesario
//---------------------------------------
void AumentarEspacio(BinHeapC h) { // O(N)
  int* newPins = new int[h->maxSize*2];
  Cliente* newCliente = new Cliente[h->maxSize*2];
  for (int i=0; i < h->curSize; i++){
    newPins[i] = h->pins[i];
    newCliente[i] = h->clientes[i];
  }
  delete h->pins;
  h->pins = newPins;
  delete h->clientes;
  h->clientes = newCliente;
  h->maxSize *= 2;
}

void InsertHC(int pin, Cliente c, BinHeapC h) { // O(log N)
  if(h->curSize==h->maxSize-1){ AumentarEspacio(h); }
  /* El ultimo nodo en la nueva posicion (curSize + 1) */
  int nodoActual = ++h->curSize;
  /* Preguntar si el pin que se desea agregar es menor al
  padre. Si se cumple, el elemento flota a la posicion del padre
  y el elemento del padre se inserta en su hijo*/
  while(pin < h->pins[nodoActual/2]){
    h->pins[nodoActual]     = h->pins[nodoActual/2];
    h->clientes[nodoActual] = h->clientes[nodoActual/2];
    /* Ahora vamos a ver la posicion del padre ya que sus elementos
    bajaron al nodo de uno de sus hijos*/
    nodoActual /= 2;
  }
  /*Si el elemento a insertar ya no puede flotar mas, se inserta en
  el nodo actual*/
  h->pins[nodoActual]     = pin;
  h->clientes[nodoActual] = c;
}

void DeleteMinHC(BinHeapC h) { // O(log N)
  // PRECOND: h->curSize > 0
  /* La posicion del nodo del hijo de un padre */
  int nodoHijo;
  /* Es la posicion que se evalua actualmente */
  int nodoActual;
  /* Es el cliente de la ultima posicion en clientes */
  Cliente ultimoClie = h->clientes[h->curSize];
  /* Es el pin de la ultima posicion en pins */
  int ultimoElem = h->pins[h->curSize];
  /* Hacemos el recorrido por el arbol */
  for(nodoActual=1; nodoActual*2<=h->curSize; nodoActual=nodoHijo){
    nodoHijo = nodoActual*2;
    if((nodoHijo!=h->curSize) && (h->pins[nodoHijo+1] < h->pins[nodoHijo])){nodoHijo++;}
    if(ultimoElem > h->pins[nodoHijo]){
      h->pins[nodoActual] = h->pins[nodoHijo];
      h->clientes[nodoActual] = h->clientes[nodoHijo]; 
    } else {
      break; // evitamos volver a iterar cuando lo encontramos. (Esto solo sirve para eficiencia)
    }
  }
  /*Si ya se llego al nodo indicado, movemos ahi sus elementos*/
    h->pins[nodoActual] = ultimoElem;
    h->clientes[nodoActual] = ultimoClie;
    h->curSize--;
}

void LiberarHC(BinHeapC h) { // O(1)
  delete h->clientes;
  delete h->pins;
  delete h;
}

//---------------------------------------
// Auxiliar para el mostrado
//---------------------------------------
void PadHC(int offset) {
  for(int i=0; i<offset; i++) {
    cout << " ";
  }
}

void ShowHC(BinHeapC h, int offset) {
  PadHC(offset); cout << "Heap[" << h->curSize << "," << h->maxSize << "] {" << endl;
  if (h->curSize>0) {
    PadHC(offset);
    cout << "  (" << setw(2) << h->pins[1] << ", " << nombre(h->clientes[1]) << ")" << endl;
  }
  for (int i=2;i<=h->curSize;i++) {
    PadHC(offset);
    cout << ", (" << setw(2) << h->pins[i] << ", " << nombre(h->clientes[i]) << ")" << endl;
  }
  if (h->curSize>0) { PadHC(offset); } else { cout << " "; }; cout << "}" << endl;
}

