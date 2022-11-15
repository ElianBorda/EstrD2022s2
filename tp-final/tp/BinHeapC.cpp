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
  // COMPLETAR
  return(NULL); // REEMPLAZAR
}

bool isEmptyHC(BinHeapC h) {  // O(1)
  // COMPLETAR
  return(false); // REEMPLAZAR
}

int  findMinPinHC(BinHeapC h) { // O(1)
  // PRECOND: la heap no está vacía
  // COMPLETAR
  return(0); // REEMPLAZAR
}

Cliente findMinClienteHC(BinHeapC h) { // O(1)
  // PRECOND: la heap no está vacía
  // COMPLETAR
  return(NULL); // REEMPLAZAR
}

//---------------------------------------
// Auxiliar para ampliar el espacio de elementos de la heap
//  en caso de ser necesario
//---------------------------------------
void AumentarEspacio(BinHeapC h) { // O(N)
  // COMPLETAR
}

void InsertHC(int pin, Cliente c, BinHeapC h) { // O(log N)
  // COMPLETAR
}

void DeleteMinHC(BinHeapC h) { // O(log N)
  // PRECOND: h->curSize > 0
  // COMPLETAR
}

void LiberarHC(BinHeapC h) { // O(1)
  // COMPLETAR
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

