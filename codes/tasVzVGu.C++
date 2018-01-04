//
// Created by skala_000 on 15/12/2017.
//
// Hw06.cpp : Defines the entry point for the console application.
//
#include <stdlib.h>
#include <vector>
#include <queue>
#include <iostream>
#include <stdio.h>


#define START_WEIGHT 0
#define INS_PROB 2

using namespace std;


//Global var
int rCur = 0, RCT = 0, NN = 0, R_this = 0, maxDepth = 0, canAddTwo =0;
queue<int> survivors;

struct node_t {

    int min = START_WEIGHT;
    int max = START_WEIGHT;
    int height = START_WEIGHT;
    int deep = 0;

    /*node_t *rch = */ node_t *lch = NULL;
    node_t *rch = NULL;


    node_t(int min, int height, int deep) : min(min), height(height), deep(deep) {}
};

int getMin(node_t* x) {
    int min = 0;
    min = (x->min);
    return (min);
}

int getMiddle(int x){
    int tmp = 0;
    tmp = x/2;
    x++;
    return x;
}

int getHeight(node_t *x, bool left){
    if(left){
        if(x->lch == NULL){
            return 0;
        }
        return (x->lch->height);
    }else{
        if(x->rch == NULL){
            return 0;
        }
        return (x->rch->height);
    }
}

int moveNodes(int howDeepIsTree){
    return (1 << (howDeepIsTree)) -1;
}

int getMax(node_t* x) {
    int max = 0;
    if((x->max) == 0){
        max = x->min;
    }else{
        max = x->max;
    }
    return (max);
}

bool isInternal(node_t* x) {
    bool innerNodes = ( (!((x->lch) == NULL)) && (!((x->rch) == NULL)) );
    return innerNodes;
}

node_t* rightRotation(node_t *&x) {
    node_t* newParent;
    newParent = x->lch;
    x->lch = newParent->rch;
    newParent->rch = x;

    if(getHeight(x,1) <= getHeight(x,0)){
        x->height = x->rch->height;
    }else{
        x->height = x->lch->height;
    }
    (x->height)++;

    if(getHeight(newParent,1) <= getHeight(newParent,0)){
        newParent->height = newParent->rch->height;
    }else{
        newParent->height = newParent->lch->height;
    }
    (newParent->height)++;

    return newParent;
}

node_t* leftRotation(node_t *&x) {
    node_t* newParent;
    newParent = x->rch;
    x->rch = newParent->lch;
    newParent->lch = x;

    if(getHeight(x,1) <= getHeight(x,0)){
        x->height = x->rch->height;
    }else{
        x->height = x->lch->height;
    }
    (x->height)++;

    if(getHeight(newParent,1) <= getHeight(newParent,0)){
        newParent->height = newParent->rch->height;
    }else{
        newParent->height = newParent->lch->height;
    }
    (newParent->height)++;

    return newParent;
}

int geChildrenDiference(node_t* x) {
    int result = (getHeight(x,1) - getHeight(x,0));
    return result;
}



void leafIsFull(int IK, node_t* x) {
    if (((x->min) > IK)) {
        node_t* XR = new node_t((x->max),   START_WEIGHT,0);
        node_t* XL = new node_t(IK,         START_WEIGHT,0);

        x->max = START_WEIGHT;

        x->rch = XR;
        x->lch = XL;
    }else if ((x->max) > IK) {
        node_t* XR = new node_t(x->max,     START_WEIGHT,0);
        node_t* XL = new node_t(x->min,     START_WEIGHT,0);

        x->min = IK;
        x->max = START_WEIGHT;

        x->rch = XR;
        x->lch = XL;
    }else{
        node_t* XL = new node_t((x->min),   START_WEIGHT,0);
        node_t* XR = new node_t(IK,         START_WEIGHT,0);

        (x->min) = (x->max);
        (x->max) = START_WEIGHT;

        (x->rch) = XR;
        (x->lch) = XL;
    }
}

node_t* leftRightRotation(node_t *&n) {
    n->lch = leftRotation(n->lch);
    return rightRotation(n);
}

node_t* rightLeftRotation(node_t *&n) {
    n->rch = rightRotation(n->rch);
    return leftRotation(n);
}



node_t* createNewTree(int depth) {
    int temp_depth = depth;
    if (!(temp_depth != maxDepth)) {
        node_t* z = new node_t(survivors.front(), START_WEIGHT,0);
        survivors.pop();
        if (canAddTwo) {
            temp_depth = survivors.front();
            z->max = temp_depth;
            survivors.pop();
            canAddTwo--;
        }
        return z;
    }
    else {
        node_t* z = new node_t(0, START_WEIGHT,0);
        temp_depth = maxDepth + (depth*(-1));
        z->height = temp_depth;
        z->lch = createNewTree(depth + 1 + START_WEIGHT);
        z->min = survivors.front();
        survivors.pop();
        if (canAddTwo) {
            z->max = survivors.front();
            survivors.pop();
            canAddTwo--;
        }
        z->rch = createNewTree(depth + 1 + START_WEIGHT);
        return z;
    }
}

void carveThrough(node_t* n, bool doAble) {
    if(doAble){
        if (isInternal(n)) {
            carveThrough(n->lch,1);
            survivors.push(n->min);
            if (!(n->max == START_WEIGHT)){ survivors.push(n->max);}
            carveThrough(n->rch,1);
        }
    }else{
        return;
    }
}

void setHeight(node_t *x){
    if(getHeight(x,1) > getHeight(x, 0)){
        x->height = x->lch->height;
    }else{
        x->height = x->rch->height;
    }
    x->height++;
}
node_t* insert(node_t* X, int IK,bool doAble){
    int res = 4;

    if(X==NULL){
        res = 0;
    }else if(IK == X->min){
        res = 1;
    }else if((IK == X->max)){
        res = 2;
    }
    if(res != 4){
        switch(res){
            //possible end of rec
            case 0: X = new node_t(IK, START_WEIGHT,0);

            case 1: return X;

            case 2: return X;
        }
    }

    node_t* tmp = NULL;
    int tmp_int = 0;

    if(isInternal(X) && (doAble)){
        int tmp_int_1 = 0;
        if( (X->min) > IK) {
            X->lch = insert(X->lch,IK,1);
            if(geChildrenDiference(X) == INS_PROB){
                rCur++;
                if (IK <= X->lch->min){
                    X = rightRotation(X);

                }else{
                    X = leftRightRotation(X);
                }
            }
        }else if( (X->max) < IK) {
            X->rch = insert(X->rch,IK,1);
            if(geChildrenDiference(X) == (-1)*(INS_PROB)){
                rCur++;
                if(getMax(X->rch) < IK){
                    X = leftRotation(X);
                }else if(getMax(X->rch) >= IK){
                    X = rightLeftRotation(X);
                }else{
                    printf("Error else\n");
                }
            }
        }else {
            tmp_int_1 = X->min;
            X->min = IK;
            tmp = insert(X->lch, tmp_int_1,1);
            X->lch = tmp;
            tmp_int = geChildrenDiference(X);
            if (tmp_int == INS_PROB) {
                rCur++;
                if (IK <= getMin(X->lch)){
                    X = rightRotation(X);
                }
                else if (IK > getMin(X->lch)){
                    X = leftRightRotation(X);
                }else{
                    printf("Error else\n");
                }
            }
        }
        /*
        if(getHeight(X,1) > getHeight(X, 0)){
            X->height = X->lch->height;
        }else{
            X->height = X->rch->height;
        }
        X->height++;
        */
        setHeight(X);
    }else{
        if(X->max == 0) {
            if(X->min > IK) {
                X->max = X->min;
                X->min = IK;
            }
            else if(X->min <= IK){
                X->max = IK;
            }else{
                printf("Error else\n");
            }
        }else if((X->max != 0) && (doAble)){

            leafIsFull(IK,X);
            NN+=2;
            X->height++;
        }
    }
    return X;
}

node_t* reduce(node_t* n) {
    int depthOfTree = 0, cntrOfNodes = 0;
    carveThrough(n,1);

    int size = survivors.size();

    if (!(size != 1)) {
        n = new node_t(survivors.front(), START_WEIGHT,0);
        survivors.pop();
        return n;
    }
    while ( (cntrOfNodes*INS_PROB) < survivors.size()) {
        cntrOfNodes = moveNodes(depthOfTree);
        depthOfTree++;
    }
    --depthOfTree;

    maxDepth = depthOfTree;
    NN = cntrOfNodes;
    size = survivors.size() - cntrOfNodes;
    int tmp_z = size;
    canAddTwo = tmp_z;

    n = createNewTree(1);
    R_this++;

    return n;
}

int main(int argc, char *argv[]) {
    if(argc > 2){
        printf("Error arguments");
        return -1;
    }
    //var
    int N = 0, IK = 0, i = 0, result1 = 0, result2 = 0, result3 = 0;
    //WINPAUSE;
    node_t* root = NULL;
    scanf("%d %d", &N, &RCT);

    if (N>0) {
        NN = 1;
    }

    while(i < N){

        cin >> IK;

        root = insert(root,IK,1);
        if (rCur == RCT) {

            rCur = 0;
            root = reduce(root);

        }
        i++;
    }

    result1 = NN;
    result2 = root->height;

    result3 = R_this;
    printf("%d %d %d\n", result1, result2, result3);

    return 0;
}