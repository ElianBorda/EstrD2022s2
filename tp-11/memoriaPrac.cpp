#include<iostream>
using namespace std;

void iSum(Tree t){
    int totalVisto = 0;
    Tree actual;
    TList faltanProcesar = emptyTL();

    if(!isEmptyt(t)){
        ConsTL(t, faltanProcesar);
    }

    while(!isEmptyTList(faltanProcesar)){
        actual = headTL(faltanProcesar);
        TailTL(faltanProcesar);
        totalVisto += actual->value;

        if (!isEmptyT(actual->right)){
            ConsTL(actual->rigth, faltanProcesar);
        }
        if (!isEmptyT(actual->left)){
            ConsTL(actual->left, faltanProcesar);
        }
    }
    LiberarTL(faltanProcesar);
    return(totalVisto);
}

int iSum(Tree t){
    int totalVisto = 0;
    Tree actual;
    TList faltanProcesar = emptyTL();

    if(!isEmpty(t)){
        ConsTL(t, faltanProcesar);   
    }

    while(!isEmptyTList(faltanProcesar)){
        actual = headTL(faltanProcesar);
        TailTL(faltanProcesar);
        totalVisto += actual->value;

        if (!isEmptyT(actual->right)){
            ConsTL(actual->right, faltanProcesar);
        }
        if (!isEmptyT(actual->left)){
            ConsTL(actual->left, faltaProcesar);
        }
    }
    LiberarTL(faltanProcesar);
    return totalVisto;
}

void DeleteMin (BinHeap h){
    int child; 
    int curNode;
    int last = h->elems[h->curSize--];

    for(curNode = 1; curNode*2 <= h->curSize; curNode = child){
        child = curNode*2;
        if((child != h->curSize) && (h->elem[child+1] < h->elems[child])){
            child++
        }
        if(last > h->elems[child]){
            h->elems[curNode] -> h->elems[child];
        } else {
            break;
        }
    }
    h->elems[curNode] = last;
}

void DeleteMin (BinHeap h){
    int child;
    int curNode;
    int last = h->elems[h->curSize--],

    for(curNode = 1; curNode*2 <= h->elem[child+1]; curNode = child){
        child = curNode*2;
        if((child != h->curSize) && (h->elem[child+1] < h->elems[child])){
            child++
        }
        if(last > h->elems[child]){
            h->elems[curNode] = h->elems[child];
        } else {
            break;
        }
    }
    h->elems[curNode] = last;
}