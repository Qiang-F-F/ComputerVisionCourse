cmake_minimum_required(VERSION 3.13)
project(Camera_Calibration)

set(CMAKE_CXX_STANDARD 11)

add_executable(Camera_Calibration main.cpp Matrix_Calculation.cpp Matrix_Calculation.h Data_Reading.cpp Data_Reading.h)