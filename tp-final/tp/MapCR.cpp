#include <iostream>
#include <string.h>
using namespace std;

#include "MapCR.h"
#include "Ruta.h"
#include "Cliente.h"
#include "Clientes.h"
struct TNode {
  Cliente clave;
  Ruta    valor;
  TNode*  left;
  TNode*  right;
};

struct  MapCRHeaderSt {
  TNode* tree;
  int    size;
};

MapCR emptyMCR() {
  MapCRHeaderSt* mcr = new MapCRHeaderSt;
  mcr->tree = NULL;
  mcr->size = 0;
  return(mcr);
}

int sizeMCR(MapCR mcr) {
  return(mcr->size);
}

// AUXILIAR
void AddClientesTo(TNode* t, Clientes cs) {
  if (t!=NULL) {
    AddClientesTo(t->left, cs);
    SnocCliente(cs, t->clave);
    AddClientesTo(t->right, cs);
  }
}

Clientes keysMCR(MapCR mcr) {
  Clientes cs = emptyClientes();
  AddClientesTo(mcr->tree, cs);
  return(cs);
}

Ruta lookupMCR(Cliente c, MapCR mcr) {
  TNode* current = mcr->tree;
  while (current != NULL && not esMismoCliente(current->clave, c)) {
    if (esClienteMayor(current->clave, c)) { current = current->left;  } 
    else                                   { current = current->right; }
  }
  Ruta pr;
  if (current==NULL) { pr = NULL;           }
  else               { pr = current->valor; }
  return(pr);
}

// AUXILIAR
TNode* nuevoTNode(Cliente c, Ruta r) {
  TNode* newNode = new TNode;
  newNode->clave = c;
  newNode->valor = r;
  newNode->left  = NULL;
  newNode->right = NULL;
  return(newNode);
}

void AddMCR(Cliente c, Ruta r, MapCR mcr) {
  TNode* current = mcr->tree;
  TNode* prev    = NULL;
  while (current != NULL && not esMismoCliente(current->clave, c)) {
    prev = current;
    if (esClienteMayor(current->clave, c)) { current = current->left;  } 
    else                                   { current = current->right; }
  }
  if (current==NULL) {
    mcr->size++;
    TNode* newNode = nuevoTNode(c,r);
    if (prev==NULL) { mcr->tree = newNode; }
    else { 
      if (esClienteMayor(prev->clave,c)) { prev->left  = newNode; }
      else                               { prev->right = newNode; }
    }
  } else { current->valor = r; }
}

// AUXILIAR
TNode* SplitMaxLeft(TNode* t) {
  // PRECOND: t no es NULL, t->left no es NULL
  TNode* current = t->left;
  TNode* prev    = t;
  while(current->right!=NULL) {
    prev = current;
    current = current->right;
  }
  if (prev==t) { prev->left  = current->left; }
  else         { prev->right = current->left; }
  return(current);
}

void DeleteMCR(Cliente c, MapCR mcr) {
  TNode* temp;
  TNode* current = mcr->tree;
  TNode* prev    = NULL;
  // Se encuentra el nodo a borrar, si existe
  //   recordando su contexto (prev)
  while (current != NULL && not esMismoCliente(current->clave, c)) {
    prev = current;
    if (esClienteMayor(current->clave, c)) { current = current->left;  } 
    else                                   { current = current->right; }
  }
  // Se procede al borrado del nodo encontrado, si existe
  if (current!=NULL) { // Sobreescribir current, salvo que current->left==NULL
    mcr->size--;
    if (current->left==NULL) { // current->right sube
      temp = current;
      if (prev==NULL) { mcr->tree = mcr->tree->right; } // Borra la raíz, sin left
      else            { if (esClienteMayor(prev->clave, c)) // Borra otro, sin left
                             { prev->left  = current->right; } 
                        else { prev->right = current->right; } 
                      }
      delete(temp);
    } else { // HAY left
      temp = SplitMaxLeft(current); // SplitMax se encarga de actualizar el left...
      current->clave = temp->clave;
      current->valor = temp->valor;
      delete(temp);
    }
  }
}

// AUXILIAR
void LiberarTree(TNode* t) {
  if(t!=NULL) {
    LiberarTree(t->left);
    LiberarTree(t->right);
    delete(t);
  }
}

void LiberarMCR(MapCR mcr) {
  LiberarTree(mcr->tree);
  delete(mcr);
}

//--------------------------------------
// Shows
//--------------------------------------
void PadMCR(int offset) {
  for(int i=0; i<offset; i++) {
    cout << " ";
  }
}

int maxLenCliente(Clientes cs) {
  int maxL = 0;
  int l;
  ClientesIterator ics = iniciarRecorridoClientes(cs);
  while (not estaAlFinalDeLosClientes(ics)) {
    l = sizeCliente(clienteActual(ics));
    if (maxL < l) { maxL = l; }
    AvanzarASiguienteCliente(ics);
  }
  return(maxL);
}

void ShowMapCR(MapCR mcr, int offset) {
  Cliente c;
  Ruta r;
  Clientes cs = keysMCR(mcr);
  int maxLenC = maxLenCliente(cs);
  ClientesIterator ics = iniciarRecorridoClientes(cs);
  PadMCR(offset);
  cout << "Map(" << mcr->size << ") {\n";
  if (not estaAlFinalDeLosClientes(ics)) {
    c = clienteActual(ics); r = lookupMCR(c, mcr);
    if (r == NULL) { cerr << "Hay algún error en keysMCR."; exit(1); }
    PadMCR(offset + maxLenC - sizeCliente(c) + 2);
    cout << nombre(c) << " -> "; ShowRuta(r); cout << "\n";
    AvanzarASiguienteCliente(ics);
  }
  while (not estaAlFinalDeLosClientes(ics)) {
    c = clienteActual(ics); r = lookupMCR(c, mcr);
    if (r == NULL) { cerr << "Hay algún error en keysMCR."; exit(1); }
    PadMCR(offset);
    cout << ",";
    PadMCR(maxLenC - sizeCliente(c) + 1);
    cout << nombre(c) << " -> "; ShowRuta(r); cout << "\n";
    AvanzarASiguienteCliente(ics);
  }
  if (not isEmptyClientes(cs)) { PadMCR(offset); }
  cout << "}\n";
  LiberarClientesIterator(ics);
}

//------------------------------------------------------------
// ESTRUCTURA AUXILIAR PARA RECORRER LINEALMENTE EL Map
//   y mostrarlo con sus rutas
//------------------------------------------------------------
struct QNodeMap {
   TNode* node;
   Ruta   ruta;
};

struct INodeMap {
   QNodeMap* elem;
   INodeMap* next; 
};

struct NextsQueueStMap {
    INodeMap* first;
    INodeMap* last;
    // INV.REP.: o ambos son NULL o ambos son distintos de NULL
};
typedef NextsQueueStMap* NextsQueueMap;        // INV.REP.: el puntero NO es NULL

NextsQueueMap emptyQMap() {
  NextsQueueStMap* newQ = new NextsQueueStMap;
  newQ->first = NULL;
  newQ->last  = NULL;  
  return (newQ);
}

bool isemptyQMap(NextsQueueMap q) {
  return (q->first==NULL);
}

void EnqueueQMap(NextsQueueMap q, Ruta r, TNode* s) {
  INodeMap* newIN = new INodeMap;
  QNodeMap* newQN = new QNodeMap;
  newQN->node  = s;
  newQN->ruta  = r;
  newIN->elem  = newQN;
  newIN->next  = NULL;
  if (q->last==NULL) { q->first      = newIN; }
  else               { q->last->next = newIN; }
  q->last = newIN;
}

QNodeMap* DequeueFirstQMap(NextsQueueMap q) {
    // PRECOND: q->first no es NULL
    INodeMap* in = q->first;
    QNodeMap* qn = in->elem;
    q->first = q->first->next;
    if (q->first == NULL) { q->last = NULL; }
    delete(in);
    return(qn);
}

void LiberarQMap(NextsQueueMap q) {
  INodeMap* temp;
  while(not (q->first==NULL)) {
    temp = q->first;
    q->first = q->first->next;
    delete(temp);
  }
  delete(q);
}
//------------------------------------------------------------
// FIN IMPLEMENTACION DE COLA DE SIGUIENTES
//------------------------------------------------------------

void MostrarTNode(Ruta r, Cliente c) {
  cout << " ";
  ShowRuta(r);
  cout << " -> " << nombre(c) << "\n";
}

void ShowMapAsBST(MapCR mcr, int offset) {
  // OBS: 
  //   * hace un recorrido BFS del map, para mostrar los caminos ordenados
  //   * es muy ineficiente en el manejo de rutas
  QNodeMap* current;
  Ruta   r;
  // El caso del árbol vacío se maneja por separado
  if (mcr->tree==NULL) { cout << "BST { }" << endl; } else {
    NextsQueueMap aProcesar = emptyQMap();
    EnqueueQMap(aProcesar, rutaVacia(), mcr->tree);
    PadMCR(offset); cout << "BST(" << mcr->size << ") {" << endl;
    while(not isemptyQMap(aProcesar)) {
      current = DequeueFirstQMap(aProcesar); // current NO debe ser NULL
      // Procesar y pasar al siguiente en cada hijo...
      if(not (current->node->left == NULL)) // Para garantizar la condición de la cola
        { r = copiarRuta(current->ruta);
          SnocBoca(r, Boca1);
          EnqueueQMap(aProcesar, r, current->node->left);
        }
      if(not (current->node->right == NULL)) // Para garantizar la condición de la cola
        { r = copiarRuta(current->ruta);
          SnocBoca(r, Boca2);
          EnqueueQMap(aProcesar, r, current->node->right);
        }
      PadMCR(offset); MostrarTNode(current->ruta,current->node->clave);
      LiberarRuta(current->ruta);
    }
    PadMCR(offset); cout << "}" << endl;
    LiberarQMap(aProcesar);
  }
}
