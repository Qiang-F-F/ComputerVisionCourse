#include <iostream>
#include "Matrix_Calculation.h"

using namespace std;

int main() {
    Matrix M(4,4);
    Matrix a = IMatrix(3);
    M.m_data = {{1,2,3,5},{6,7,8,0},{0,12,11,1},{1,3,7,4}};
    //cout<<M.det();
    //(a*M).print();
    cout<<M.det();
    return 0;
}