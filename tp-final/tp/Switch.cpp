#include <iostream>
using namespace std;

#include "Switch.h"
#include "Ruta.h"
#include "Rutas.h"
#include "Cliente.h"
#include "Clientes.h"
struct SNode {
    Cliente conexion; // OBS: si es NULL, está disponible.
    SNode*  boca1;
    SNode*  boca2;
    // INV.REP.:
    //  * (BONUS) uno de los 3 campos es distinto de NULL
};

struct  SwHeaderSt {
  SNode* root;
};

Switch newSwitch() {
  Switch s = new SwHeaderSt;
  s->root = NULL; // Switch es una terminal
  return s; 
}

void Conectar(Cliente c, Ruta r, Switch s) {
  RutaIterator ir = iniciarRuta(r);
  if (s->root==NULL){ s->root = new SNode; }
  SNode* actual = s->root;
  while(!estaAlFinalDeLaRuta(ir)){
    if(bocaActual(ir)==Boca1){
      if(actual->boca1==NULL){ actual->boca1 = new SNode; }
      actual = actual->boca1;
    } else {
      if(actual->boca1==NULL){ actual->boca1 = new SNode; }
      actual = actual->boca2;
    }
    AvanzarEnRuta(ir);
  }
  LiberarRutaIterator(ir);
  actual->conexion = c;
}

void Desconectar(Ruta r, Switch s) {
  RutaIterator ir = iniciarRuta(r);
  while(!estaAlFinalDeLaRuta(ir)){
    //hacerAlgo
  }
}

Rutas disponiblesADistancia(Switch s, int d) {
  // COMPLETAR
  return (NULL); // REEMPLAZAR
}

void LiberarSwitch(Switch s) {
  // COMPLETAR
}

//------------------------------------------------------------
// ESTRUCTURA AUXILIAR COLA DE SIGUIENTES PARA RECORRER LINEALMENTE EL SWITCH
//------------------------------------------------------------
struct QNodeSw {
   SNode* node;
   Ruta   ruta;
};

struct INodeSw {
   QNodeSw* elem;
   INodeSw* next; 
};

struct NextsQueueStSw {
    INodeSw* first;
    INodeSw* last;
    // INV.REP.: o ambos son NULL o ambos son distintos de NULL
};
typedef NextsQueueStSw* NextsQueueSw;        // INV.REP.: el puntero NO es NULL

NextsQueueSw emptyQSw() {
  NextsQueueStSw* newQ = new NextsQueueStSw;
  newQ->first = NULL;
  newQ->last  = NULL;  
  return (newQ);
}

bool isEmptyQSw(NextsQueueSw q) {
  return (q->first==NULL);
}

void EnqueueQSw(NextsQueueSw q, Ruta r, SNode* s) {
  INodeSw* newIN = new INodeSw;
  QNodeSw* newQN = new QNodeSw;
  newQN->node = s;
  newQN->ruta  = r;
  newIN->elem  = newQN;
  newIN->next  = NULL;
  if (q->last==NULL) { q->first      = newIN; }
  else               { q->last->next = newIN; }
  q->last = newIN;
}

QNodeSw* DequeueFirstQSw(NextsQueueSw q) {
    // PRECOND: q->first no es NULL
    INodeSw* in = q->first;
    QNodeSw* qn = in->elem;
    q->first = q->first->next;
    if (q->first == NULL) { q->last = NULL; }
    delete(in);
    return(qn);
}

void LiberarQSw(NextsQueueSw q) {
  INodeSw* temp;
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
void PadSW(int offset) {
  for(int i=0; i<offset; i++) {
    cout << " ";
  }
}

void MostrarConexion(Ruta r, Cliente c) {
    if (not (c==NULL)) { // La conexión NO está disponible
      cout << " "; ShowRuta(r); cout << " -> " << nombre(c) << endl;
    } else {             // La conexión está disponible
      cout << " "; ShowRuta(r); cout << " -> " << "DISPONIBLE" << endl;
    }
}

void ShowSwitch(Switch s, int offset) {
    // OBS: 
    //   * hace un recorrido BFS del switch, para mostrar las rutas ordenadas
    //   * SOLAMENTE se muestran las rutas ocupadas
    //   * es muy ineficiente en el manejo de rutas
    QNodeSw* current;
    Ruta   r;
    NextsQueueSw aProcesar = emptyQSw();
    EnqueueQSw(aProcesar, rutaVacia(), s->root);
    PadSW(offset); cout << "{" << endl;
    while(not isEmptyQSw(aProcesar)) {
      current = DequeueFirstQSw(aProcesar);
      // Procesar y pasar al siguiente en cada hijo...
      if(not (current->node->boca1 == NULL)) 
        { r = copiarRuta(current->ruta);
          SnocBoca(r, Boca1);
          EnqueueQSw(aProcesar, r, current->node->boca1);
        }
      if(not (current->node->boca2 == NULL)) 
        { r = copiarRuta(current->ruta);
          SnocBoca(r, Boca2);
          EnqueueQSw(aProcesar, r, current->node->boca2);
        }
      PadSW(offset); MostrarConexion(current->ruta,current->node->conexion);
      LiberarRuta(current->ruta);
    }
    PadSW(offset); cout << "}" << endl;
    LiberarQSw(aProcesar);
}
