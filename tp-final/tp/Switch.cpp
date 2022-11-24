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

Switch newSwitch() { //<------ 1)
  Switch s = new SwHeaderSt;
  s->root = NULL; // Switch es una terminal
  return s; 
}

SNode* nodoDeSwEn(Switch s, Boca b){
  if(b == Boca1){
    return s->root->boca1;
  } else {
    return s->root->boca2;
  }
}

void AvanzarABoca(Switch s, Boca b){
  if (b == Boca1){
    s->root = s->root->boca1;
  } else {
    s->root = s->root->boca2;
  }
}

void IniNodo(SNode* n){
  n->boca1 = NULL;
  n->boca2 = NULL;
  n->conexion = NULL;
}


void IniDeSwEnBoca(Switch s, Boca b){
  if (b == Boca1){
    s->root->boca1 = new SNode;
    IniNodo(s->root->boca1);
  } else {
    s->root->boca2 = new SNode;
    IniNodo(s->root->boca2);
  }
}

void Conectar(Cliente c, Ruta r, Switch s) {
  RutaIterator bs = iniciarRuta(r);
  if (s->root == NULL) { s->root = new SNode;
                         IniNodo(s->root); }
  SNode* actual = s->root;
  while (!estaAlFinalDeLaRuta(bs)){
    if (bocaActual(bs) == Boca1){
      if (actual->boca1 == NULL){ actual->boca1 = new SNode;
                                  IniNodo(actual->boca1);}
      actual = actual->boca1;                                   
    } else {
      if (actual->boca2 == NULL){ actual->boca2 = new SNode;
                                  IniNodo(actual->boca2);}
      actual = actual->boca2;  
    }
    AvanzarEnRuta(bs);
  }
  LiberarRutaIterator(bs);
  actual->conexion = c;
}



void Desconectar(Ruta r, Switch s) { //<------ 3)
  RutaIterator ir = iniciarRuta(r);
  if (s->root == NULL){ s->root = new SNode;
                        IniNodo(s->root); }
  SNode* act = s->root;
  while (!estaAlFinalDeLaRuta(ir) && act!=NULL){
    if (bocaActual(ir) == Boca1){
      act = act->boca1;
    } else {
      act = act->boca2;
    }
    AvanzarEnRuta(ir);
  }
  if (act == NULL) {act = new SNode;
                    IniNodo(act);}
  else { act->conexion = NULL;}
  LiberarRutaIterator(ir);
}


Rutas rutasDisponiblesHasta(SNode* n, int d){ 
  Rutas rs1;
  Rutas rs2;
  if(d == 0){
    rs1 = emptyRutas();
    if (n == NULL || n->conexion == NULL){ ConsRuta(rutaVacia(), rs1); }
    return(rs1);
  } else {
    if (n == NULL){ n = new SNode;
                    IniNodo(n); }
    Rutas rs1 = rutasDisponiblesHasta(n->boca1, d-1);
    Rutas rs2 = rutasDisponiblesHasta(n->boca2, d-1);
    ExtenderTodasLasRutasCon(Boca1, rs1);
    ExtenderTodasLasRutasCon(Boca2, rs2);
    AgregarA_LasRutasDe_(rs1, rs2);
    return(rs1);
  }
}

Rutas disponiblesADistancia(Switch s, int d) { //<------ 4)
  return rutasDisponiblesHasta(s->root, d);    
}

void LiberarNodos(SNode* n){ 
  if(n!=NULL){
    LiberarNodos(n->boca1);
    LiberarNodos(n->boca2);
    delete n;
  }
}

void LiberarSwitch(Switch s) { //<------ 5)
  LiberarNodos(s->root);
  delete s;
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
