# DualNet
Este trabajo práctico busca implementar el TAD DualNet, según el enunciado dado en el pdf adjunto (`DualNet.pdf`).

## Módulos completos
* `Ruta`, implementa las rutas como listas de bocas, con operaciones para agregar
          al comienzo y al final de una ruta, copiar y mostrar una ruta, y recorrerla.
* `Rutas`, implementa listas de rutas, con operaciones para agregar, mostrar y 
          recorrer estas listas.
* `Cliente`, implementa Cliente como string con operaciones de tamaño y comparación.
* `Clientes`, implementa listas de clientes, con operaciones para agregar, mostrar y
          recorrer estas listas.
* `MapCR`, implementa un map de clientes a rutas, usando un BST.
           Tiene las operaciones usuales de interfaz para map, más operaciones para mostrar maps, tanto en forma abstracta (mediante la lista de claves), como usando el BST.

## Módulos a completar
* `BinHeapC`, debe implementar una Heap binaria de pares (Int, Cliente) con 
          operaciones para insertar, consultar y borrar elementos. Trae provista la
          operación para mostrar las heaps.
* `Switch`, debe implementar Switches de clientes, siguiendo una ruta específica 
           para cada cliente, usando árboles binarios.
           Trae provista la operación para mostrar las conexiones del switch.
* `DualNet`, debe implementar las DualNets, que conectan clientes a rutas 
           específicas, como un par de un Switch y un MapCR.
           Trae provista la operación para mostrar DualNets.
