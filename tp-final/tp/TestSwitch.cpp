#include <iostream>
#include <string.h>
using namespace std;

#include "Switch.h"
#include "Ruta.h"
#include "Rutas.h"
#include "Cliente.h"
#include "Clientes.h"

int main() {
    Cliente maria     = cliente("Maria");
    Cliente juan      = cliente("Juan");
    Cliente constanza = cliente("Constanza");
    Cliente luisa     = cliente("Luisa");
    Cliente pedro     = cliente("Pedro");
    Cliente kevin     = cliente("Kevin");
    Cliente tatiana   = cliente("Tatiana");
    Cliente ana       = cliente("Ana");
    Cliente diana     = cliente("Diana");

    Ruta ruta0 = rutaVacia();
    Switch s = newSwitch();

    Conectar(maria, ruta0, s);

    Ruta ruta1 = copiarRuta(ruta0);
    SnocBoca(ruta1, Boca1);

    Ruta ruta2 = copiarRuta(ruta0);
    SnocBoca(ruta2, Boca2);
    Conectar(juan, ruta2, s);

    Ruta ruta12 = copiarRuta(ruta1);
    SnocBoca(ruta12, Boca2);
    Conectar(constanza, ruta12, s);

    Desconectar(ruta0, s);

    ShowSwitch(s, 2);

    Rutas rs = disponiblesADistancia(s, 4);
    ShowRutas(rs, 0);
}