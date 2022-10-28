using namespace std; 

// Ejercicio 2
// Indicar el propósito de los siguientes procedimientos o funciones, dando algunos ejemplos de uso
// junto con su resultado. Considerar el consumo de memoria de cada programa, y si puede mejorarse.

// Precondición: c1 < c2
// Costo en memoria: O(1)
void printFromTo(char c1, char c2) {
    for(int i = 0; c1 + i <= c2; i++) {
        cout << c1 + i << ", ";
    }
    cout << endl;
}

// Precondición: n >= 0
// Costo en memoria: O(1)
int fc(int n) {
    int x = 1;
    while(n > 0) {
        x = x * n;
        n--;
    }
    return x;
}

// Precondición: n <= m
// Costo en memoria: O(m)
int ft(int n, int m) {
    if (n == m) {
        return n;
    }
    return n + ft(n+1, m);
}
