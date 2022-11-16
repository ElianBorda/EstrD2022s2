void Conectar(Cliente c, Ruta r, Switch s) {
  RutaIterator ir = iniciarRuta(r); // Generamos iterador
  if (s->root==NULL){ // Pregunto si la raiz es NULL
    s->root = new SNode; // Le damos una raiz al Switch
    if(estaAlFinalDeLaRuta(ir)){ //Si la ruta no tiene boca, entonces conecta el cliente en la raiz.
      s->root->conexion = c;
    } else {
      SNode* node = s->root; //El puntero de la raiz la recordamos para trabajar individualmente con ella
      if (bocaActual(ir) == Boca1) { // Como se sabe que actualmente hay una boca, entonces se elige esa.
        node->boca1 = new SNode; // Se crea un puntero de nodo
        node = node->boca1;
      } else {
        node->boca2 = new SNode; // Se crea un puntero de nodo
        node = node->boca2;
      }
      AvanzarEnRuta(ir); // Se elije la siguiente ruta
      while(!estaAlFinalDeLaRuta(ir)){ // Mientras la ruta no este vacia se generan punteros sobre las bocas,
        if (bocaActual(ir)==Boca1) { // Como se sabe que actualmente hay una boca, entonces se elige esa.
          node->boca1 = new SNode; // Se crea un puntero de nodo
          node = node->boca1;
        } else {
          node->boca2 = new SNode; // Se crea un puntero de nodo
          node = node->boca2;
        }
        AvanzarEnRuta(ir);
      }
      node->conexion = c;
    }

  } else {
    if(estaAlFinalDeLaRuta(ir)){ //Si la ruta no tiene boca, entonces conecta el cliente en la raiz.
      s->root->conexion = c;
    } else {
      SNode* node = s->root; //El puntero de la raiz la recordamos para trabajar individualmente con ella
      if (bocaActual(ir) == Boca1) { // Como se sabe que actualmente hay una boca, entonces se elige esa.
        if (node->boca1 == NULL){
          node->boca1 = new SNode; // Se crea un puntero de nodo
        }
        node = node->boca1;
      } else {
        if (node->boca2 == NULL){
          node->boca2 == new SNode; // Se crea un puntero de nodo
        }
        node = node->boca2;
      }
      AvanzarEnRuta(ir); // Se elije la siguiente ruta
      while(!estaAlFinalDeLaRuta(ir)){ // Mientras la ruta no este vacia se generan punteros sobre las bocas,
        if (bocaActual(ir)==Boca1) { // Como se sabe que actualmente hay una boca, entonces se elige esa.
        if (node->boca1 == NULL){
          node->boca1 = new SNode; // Se crea un puntero de nodo
        }
        node = node->boca1;
        } else {
        if (node->boca2 == NULL){
          node->boca2 = new SNode; // Se crea un puntero de nodo
        }
        node = node->boca2;
        }
        AvanzarEnRuta(ir);
      }
      node->conexion = c;
    }
  }
  LiberarRutaIterator(ir);
}