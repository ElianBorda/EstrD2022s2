#include <iostream>
using namespace std;

#include "Cliente.h"

struct  CsHeaderSt; 
typedef CsHeaderSt*   Clientes;        // INV.REP.: el puntero NO es NULL

struct  CsIteratorSt;
typedef CsIteratorSt* ClientesIterator; // INV.REP.: el puntero NO es NULL

// Creación y liberación de listas de Clientes
Clientes emptyClientes();
bool isEmptyClientes(Clientes cs);
void ConsCliente(Cliente c, Clientes cs);
void SnocCliente(Clientes cs, Cliente c);
void LiberarClientes(Clientes cs);

// Para mostrar una lista de Clientes por consola
void ShowClientes(Clientes cs);

// Recorrido de listas de Clientes, para acceso
ClientesIterator iniciarRecorridoClientes(Clientes cs);
bool estaAlFinalDeLosClientes(ClientesIterator ics);
Cliente clienteActual(ClientesIterator ics);            // PRECOND: no está al 
void AvanzarASiguienteCliente(ClientesIterator ics);    //   fin del recorrido
void LiberarClientesIterator(ClientesIterator ics);
