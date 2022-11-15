#include <iostream>
using namespace std;

#include "Ruta.h"

int main() {
    Ruta ruta = rutaVacia();
    ConsBoca(Boca1, ruta);
    ConsBoca(Boca2, ruta);
    ConsBoca(Boca2, ruta);
    ConsBoca(Boca1, ruta);
    ConsBoca(Boca1, ruta);
    ConsBoca(Boca2, ruta);

    Ruta ruta2 = copiarRuta(ruta);
    ConsBoca(Boca2, ruta2);

    ShowRuta(ruta);
    cout << "\n";
    
    RutaIterator ir;
    int i=0;
    for (ir = iniciarRuta(ruta)
        ; not estaAlFinalDeLaRuta(ir)
        ; AvanzarEnRuta(ir)
        ) {
      cout << "El elemento " << i++ << " es " << bocaActual(ir) << ".\n";
    }
    LiberarRutaIterator(ir);

    ShowRuta(ruta2);
    cout << "\n";

    i=0;
    for (ir = iniciarRuta(ruta2)
        ; not estaAlFinalDeLaRuta(ir)
        ; AvanzarEnRuta(ir)
        ) {
      cout << "El elemento " << i++ << " es " << bocaActual(ir) << ".\n";
    }
    LiberarRutaIterator(ir);

}