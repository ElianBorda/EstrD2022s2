#include <iostream>
using namespace std;

#include "Ruta.h"
#include "Rutas.h"
#include "Cliente.h"
#include "Clientes.h"

struct  SwHeaderSt;
typedef SwHeaderSt* Switch; // INV.REP.: el puntero NO es NULL

Switch newSwitch();
void Conectar(Cliente c, Ruta r, Switch s);  
void Desconectar(Ruta r, Switch s);  
Rutas disponiblesADistancia(Switch s, int d);

void LiberarSwitch(Switch s);
void ShowSwitch(Switch s, int offset);