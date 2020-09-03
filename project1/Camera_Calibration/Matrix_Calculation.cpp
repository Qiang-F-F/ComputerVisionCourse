//
// Created by 付强 on 2019-10-05.
//

#include "Matrix_Calculation.h"
#include <iostream>
using namespace std;

Matrix Matrix::transpose(){
    Matrix out(m_n,m_m);

    for(auto i = 0;i<m_m;i++){
        vector<double> temp_col;
        for(auto j = 0;j<m_n;j++){
            temp_col.push_back(m_data[j][i]);
        }
        out.m_data.push_back(temp_col);
    }
    return(out);
}

Matrix Matrix::inverse(){}

double Matrix::det(){
    double det =1;
    if(m_m!=m_n){
        cout<<"Error";
    }else{
        /*double det = 0;
        for(int i = 0;i<m_m;i++){
            det+=m_data[i%m_m][0]*m_data[(i+1)%m_m][1]*m_data[(i+2)%m_m][2];
        }
        for(int i = 2*m_m-1;i>=m_m;i--){
            det+=-m_data[i%m_m][0]*m_data[(i-1)%m_m][1]*m_data[(i-2)%m_m][2];
        }*/
        Matrix u = U(*this);
        for(int i = 0;i<m_m;i++){
            det*=u.m_data[i][i];
        }
        return det;
    }
}

void Matrix::print(){
    for(int i = 0;i < m_m;i++){
        for(int j = 0;j<m_n;j++){
            cout<<m_data[j][i]<<' ';
        }
        cout<<endl;
    }
}

Matrix Matrix::operator*(Matrix &b){
    if(this->m_n!=b.m_m){
        cout<<"Error\n";
    } else{
        Matrix out(this->m_m,b.m_n);
        for(auto m = 0;m<out.m_m;m++){
            vector<double> temp_col;
            for(auto n = 0;n<out.m_n;n++){
                double temp=0;
                for(int k = 0;k<this->m_n;k++){
                    temp+=this->m_data[k][m]*b.m_data[n][k];
                }
                temp_col.push_back(temp);
            }
            out.m_data.push_back(temp_col);
        }
        return(out.transpose());
    }
}

Matrix operator*(double a,Matrix &b){
    Matrix out(b.m_m,b.m_n);
    for(auto i = 0;i<b.m_n;i++){
        vector<double> temp_col;
        for(auto j = 0;j<b.m_m;j++){
            temp_col.push_back(a*b.m_data[i][j]);
        }
        out.m_data.push_back(temp_col);
    }
    return(out);
}
Matrix operator*(Matrix &b,double a){
    Matrix out(b.m_m,b.m_n);
    for(auto i = 0;i<b.m_n;i++){
        vector<double> temp_col;
        for(auto j = 0;j<b.m_m;j++){
            temp_col.push_back(a*b.m_data[i][j]);
        }
        out.m_data.push_back(temp_col);
    }
    return(out);
}

Matrix U (Matrix &a){
    Matrix A = a;
    Matrix I=IMatrix(a.m_m);
    Matrix out = IMatrix(a.m_m);
    for(int i = 0;i<a.m_m-1;i++){
        Matrix temp_m(a.m_m,a.m_n);
        temp_m = I;
        for(int j = i+1;j<a.m_m;j++){
            temp_m.m_data[i][j]=-A.m_data[i][j]/A.m_data[i][i];
        }
        out = temp_m*out;
        A = out*A;
    }
    return(out*a);
}

Matrix IMatrix(int n){
    Matrix out(n,n);
    for(int i=0;i<n;i++){
        vector<double> temp;
        for(int j=0;j<n;j++){
            if(i==j){
                temp.push_back(1);
            }else{temp.push_back(0);}
        }
        out.m_data.push_back(temp);
    }
    return(out);
}