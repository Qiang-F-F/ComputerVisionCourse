//
// Created by 付强 on 2019-10-05.
//

#ifndef CAMERA_CALIBRATION_MATRIX_CALCULATION_H
#define CAMERA_CALIBRATION_MATRIX_CALCULATION_H
#include <vector>
using namespace std;
class Matrix{
public:
    int m_m,m_n;
    vector<vector<double>> m_data;
public:
    Matrix(int m = 1, int n = 1):m_m(m),m_n(n){}
    Matrix transpose();
    Matrix inverse();
    void print();
    double det();
    Matrix operator* (Matrix &b);

};


Matrix operator*(double a,Matrix &b);
Matrix operator*(Matrix &b,double a);
Matrix U(Matrix &a);
Matrix IMatrix(int n);
void SVD(Matrix &D,Matrix &S,Matrix &V,Matrix &A);
Matrix Solve_by_SVD(Matrix &A,Matrix &b);
#endif //CAMERA_CALIBRATION_MATRIX_CALCULATION_H
