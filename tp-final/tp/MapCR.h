#include <iostream>
using namespace std;

#include "Ruta.h"
#include "Cliente.h"
#include "Clientes.h"

struct  MapCRHeaderSt;
typedef MapCRHeaderSt* MapCR; // INV.REP.: el puntero NO es NULL

// Operaciones de creación, acceso y liberación de Maps de Clientes a Rutas.
MapCR    emptyMCR();
int      sizeMCR(MapCR mcr);
Clientes keysMCR(MapCR mcr);
Ruta     lookupMCR(Cliente c, MapCR mcr);  
   // OBS: 
   //   * el restulado NULL significa que no existe la asociación
   //   * (dado que el invariante de Ruta indica que NO PUEDE ser NULL
   //      se usa el valor NULL para indicar ausencia)
void     AddMCR(Cliente c, Ruta r, MapCR mcr);  
void     DeleteMCR(Cliente c, MapCR mcr);
void     LiberarMCR(MapCR mcr);

// Para mostrar un Map de Clientes a Rutas por consola
//  OBS:
//    * ocupan varias líneas
//    * el offset indica cuántos lugares se espera indentar lo que se muestra
void ShowMapCR(MapCR mcr, int offset);    
   // OBS: Lo muestra por clientes en orden, en forma abstracta
void ShowMapAsBST(MapCR mcr, int offset); 
   // OBS: Lo muestra como BST, con cada elemento en su ruta, 
   //      para control durante la codificación. NO se espera que lo
   //      use un usuario final.