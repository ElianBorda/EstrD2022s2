#include <iostream>
using namespace std;

struct CNode;
typedef CNode* Cliente; // INV.REP.: nunca es NULL

// Creación y liberación de un Cliente
Cliente cliente(string nombre);
void LiberarCliente(Cliente c);

// Observadores de Clientes
string nombre(Cliente c);
int  sizeCliente(Cliente c);
bool esMismoCliente(Cliente c1, Cliente c2); // OBS: c1 es igual a c2
bool esClienteMayor(Cliente c1, Cliente c2); // OBS: c1 es mayor que c2, lexicográficamente

