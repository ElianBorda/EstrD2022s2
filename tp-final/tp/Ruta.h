#include <iostream>
using namespace std;

#define Boca int
#define Boca1 1
#define Boca2 2

struct  RutaHeaderSt; 
typedef RutaHeaderSt*   Ruta;          // INV.REP.: el puntero NO es NULL

struct  RutaIteratorSt;
typedef RutaIteratorSt* RutaIterator; // INV.REP.: el puntero NO es NULL

// Creación y liberación de Rutas
Ruta rutaVacia();
int  lenRuta(Ruta r);
bool mismaRuta(Ruta r1, Ruta r2);
void ConsBoca(Boca boca, Ruta r);
void SnocBoca(Ruta r, Boca boca);
Ruta copiarRuta(Ruta r);
void LiberarRuta(Ruta r);

// Para mostrar una Ruta por consola
void ShowRuta(Ruta r);

// Recorrido de Rutas, para acceso
RutaIterator iniciarRuta(Ruta r);
bool estaAlFinalDeLaRuta(RutaIterator ir);
Boca bocaActual(RutaIterator ir);          // PRECOND: no está al 
void AvanzarEnRuta(RutaIterator ir);       //   fin del recorrido
void LiberarRutaIterator(RutaIterator ir);
