#include <iostream>
using namespace std;

#include "Ruta.h"

struct  RutasHeaderSt; 
typedef RutasHeaderSt*   Rutas;          // INV.REP.: el puntero NO es NULL

struct  RutasIteratorSt;
typedef RutasIteratorSt* RutasIterator; // INV.REP.: el puntero NO es NULL

// Creación y liberación de listas de Rutas
Rutas emptyRutas();
bool isEmptyRutas(Rutas rs);
void ConsRuta(Ruta r, Rutas rs);  
void SnocRuta(Rutas rs, Ruta r);  
void LiberarRutas(Rutas rs);

// Operaciones de rutas específicas
Rutas copiarRutas(Rutas rs);                     // DEEP copy de TODAS las rutas. Operación CARA
void ExtenderTodasLasRutasCon(Boca b, Rutas rs); // Tiene efectos laterales si la misma ruta aparece más de una vez en la lista.
void AgregarA_LasRutasDe_(Rutas rs1, Rutas rs2);

// Para mostrar una lista de Rutas por consola
//  OBS:
//    * ocupa varias líneas
//    * el offset indica cuántos lugares se espera indentar lo que se muestra
void ShowRutas(Rutas rs, int offset);

// Recorrido de listas de Rutas, para acceso
RutasIterator iniciarRecorridoDeRutas(Rutas rs);
bool estaAlFinalDeLasRutas(RutasIterator irs);
Ruta rutaActual(RutasIterator irs);             // PRECOND: no está al 
void AvanzarASiguienteRuta(RutasIterator irs);  //   fin del recorrido
void LiberarRutasIterator(RutasIterator irs);
