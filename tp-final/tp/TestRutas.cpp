#include <iostream>
using namespace std;

#include "Rutas.h"
#include "Ruta.h"

void MostrarRutas(Rutas rs) {
    RutasIterator ir;
    int i=0;
    for (ir = iniciarRecorridoDeRutas(rs)
        ; not estaAlFinalDeLasRutas(ir)
        ; AvanzarASiguienteRuta(ir)
        ) {
      cout << "El elemento " << i++ << " es ";
      ShowRuta(rutaActual(ir));
      cout << ".\n";
    }
    LiberarRutasIterator(ir);
}


int main() {
    Ruta ruta0 = rutaVacia();
    Ruta ruta1 = rutaVacia();
    ConsBoca(Boca1, ruta1);
    ConsBoca(Boca2, ruta1);
    ConsBoca(Boca2, ruta1);

    Ruta ruta2 = copiarRuta(ruta1);
    ConsBoca(Boca1, ruta2);
    ConsBoca(Boca1, ruta2);
    ConsBoca(Boca2, ruta2);

    Rutas rutas = emptyRutas();
    ConsRuta(ruta1, rutas);
    ConsRuta(ruta0, rutas);
    ConsRuta(ruta2, rutas);

    cout << "3 rutas" << endl;
    ShowRutas(rutas, 3);
    cout << endl;
    MostrarRutas(rutas);
    
    Rutas rutas2 = copiarRutas(rutas);
    AgregarA_LasRutasDe_(rutas,rutas2);
    cout << endl << "6 rutas" << endl;
    ShowRutas(rutas,2);
    cout << endl;
    MostrarRutas(rutas);

    ExtenderTodasLasRutasCon(Boca1, rutas);
    cout << endl << "6 rutas con 1 adelante" << endl;
    ShowRutas(rutas,2);
    cout << endl;
    MostrarRutas(rutas);

}