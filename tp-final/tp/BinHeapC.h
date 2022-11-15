#include <iostream>
using namespace std;

#include "Cliente.h"
#include "Clientes.h"

struct BinHeapHeaderSt;
typedef BinHeapHeaderSt* BinHeapC;

// Creación, actualización, acceso y liberación de Heaps binarias de (Int, Cliente)
//  OBS: las operaciones de acceso al mínimo se proveen por separado para cada uno
//       de los elementos del par
BinHeapC emptyHC();
bool     isEmptyHC(BinHeapC h);
int      findMinPinHC(BinHeapC h);
Cliente  findMinClienteHC(BinHeapC h);
void     InsertHC(int pin, Cliente c, BinHeapC h);
void     DeleteMinHC(BinHeapC h);
void     LiberarHC(BinHeapC h);

// Para mostrar una Heap de pares (Int,Cliente) por consola
//  OBS:
//    * ocupa varias líneas
//    * el offset indica cuántos lugares se espera indentar lo que se muestra
void ShowHC(BinHeapC h, int offset);
