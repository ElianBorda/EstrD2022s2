#include <iostream>
#include <iomanip>
using namespace std;

#include "Clientes.h"

struct CNode {
   string nombre;
};

Cliente cliente(string nombre) {
  CNode* newC = new CNode;
  newC->nombre = nombre;
  return(newC);
}

void LiberarCliente(Cliente c)              { delete(c);                        }
string nombre(Cliente c)                    { return(c->nombre);                }
int sizeCliente(Cliente c)                  { return(c->nombre.size());         }
bool esMismoCliente(Cliente c1, Cliente c2) { return(c1->nombre == c2->nombre); }
bool esClienteMayor(Cliente c1, Cliente c2) { return(c1->nombre > c2->nombre);  }
