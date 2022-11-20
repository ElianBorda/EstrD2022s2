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
    Conectar(kevin, ruta0, s);

    ShowSwitch(s, 2);
}