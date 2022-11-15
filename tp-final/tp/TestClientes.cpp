#include <iostream>
using namespace std;

#include "Clientes.h"
#include "Cliente.h"

int main() {
    Cliente maria     = cliente("Maria");
    Cliente juan      = cliente("Juan");
    Cliente constanza = cliente("Constanza");
    Cliente luisa     = cliente("Luisa");
    Cliente pedro     = cliente("Pedro");

    cout << "Maria = Juan : " << (esMismoCliente(maria, juan)?"V":"F")  << "\n";
    cout << "Maria = Maria: " << (esMismoCliente(maria, maria)?"V":"F") << "\n";
    
    cout << "Maria > Juan : " << (esClienteMayor(maria, juan)?"V":"F")  << "\n";
    cout << "Maria > Maria: " << (esClienteMayor(maria, maria)?"V":"F") << "\n";
    cout << "Juan  > Maria: " << (esClienteMayor(juan , maria)?"V":"F") << "\n";
    
    Clientes cs = emptyClientes();
    ConsCliente(maria    , cs);
    ConsCliente(juan     , cs);
    ConsCliente(constanza, cs);
    ConsCliente(luisa    , cs);
    SnocCliente(cs       , pedro);
    ShowClientes(cs);
    cout << "\n";

    ClientesIterator ics;
    int i=0;
    for (ics = iniciarRecorridoClientes(cs)
        ; not estaAlFinalDeLosClientes(ics)
        ; AvanzarASiguienteCliente(ics)
        ) {
      cout << "El elemento " << i++ << " es " << nombre(clienteActual(ics)) << ".\n";
    }
    LiberarClientesIterator(ics);
    
}