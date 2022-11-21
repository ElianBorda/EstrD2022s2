
/* Dado el nodo y la boca que recibe por parametro, genera un puntero 
de una estructura de nodo en la boca dada
void actualizarEn(SNode* n, Boca boca){
  if(boca == Boca1){
    n->boca1    = new SNode;
    n->conexion = NULL;
    n->boca2    = NULL;
  } else {
    n->boca2    = new SNode;
    n->conexion = NULL;
    n->boca1    = NULL;
  }
}

/* Genera una estructuras de nodos hasta la ultima boca, respetando la INV. REP de
SNode

SNode* generarAccesosEnDireccion(RutaIterator ir){
  SNode* nodo = new SNode;
  SNode* actual = nodo;
  actual->boca1 = NULL;
  actual->boca2 = NULL;
  while (!estaAlFinalDeLaRuta(ir)){
    if(bocaActual(ir) == Boca1){
      actualizarEn(actual, Boca1);
      actual = actual->boca1;
    } else {
      actualizarEn(actual, Boca2);
      actual = actual->boca2;
    }
    AvanzarEnRuta(ir);
  }
  return nodo;
}


/* Esta funcion permite adentrarse dentro de los campos de los nodos. Cuando ya no hay bocas
devuelve el nodo del ultimo campo accedido 
SNode* accederHastaFin(SNode* n, RutaIterator ir){

  while (!estaAlFinalDeLaRuta(ir)){
    if (bocaActual(ir)==Boca1){
      if(n->boca1 == NULL){
        n->boca1 = generarAccesosEnDireccion(ir);
      }
      n = n->boca1;
    } else {
      if(n->boca2 == NULL){
        n->boca2 = generarAccesosEnDireccion(ir);
      }
      n = n->boca2;
    }
    AvanzarEnRuta(ir);
  }

  return n;
}

void Conectar(Cliente c, Ruta r, Switch s) {
  RutaIterator ir = iniciarRuta(r);
  SNode* actual;
  if (s->root == NULL){
    s->root = generarAccesosEnDireccion(ir); // exprecion que evita romper la INV. REP
    actual = s->root;
  } else {
    actual = accederHastaFin(s->root, ir); // Accede a los nodos
  }
  actual->conexion = c;
  LiberarRutaIterator(ir);
}*/