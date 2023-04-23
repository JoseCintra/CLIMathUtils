# Triangle Calculator
![Triangle calculator - Elements of triangle](https://github.com/JoseCintra/CLIMathUtils/blob/main/tcal/triangle_tcal.png)

**Triangle Calculator** (tcal) is a command-line program developed in Fortran that calculates the main elements of a triangle based on the dimension of its sides a, b and c. Along with the program, a Fortran library (tcal_lib) is also available, which can be used in other mathematical projects.  
Triangle calculator runs in Linux and Windows.

## Features
Until the present version (1.06.0), the following calculations are available:
* Perimeter
* Semiperimeter
* Area by Heron e Height formulas
* Internal and External angles by the cosine formula
* Types, with respect to the number of sides and angles
* Heights of the triangle 

## How to use

Usage: tricalc [options] …

Options:
|Short| Long | Function |
| ---| --- | --- |
|-h|--help|Print help information and exit|
|-v|--version|Print version information and exit|
|-a X|--aside=X|X is the length of side a|
|-b X|--bside=X|X is the length of side b|
|-c X|--cside=X|X is the length of side c|

Example that calculates the triangle of sides 3, 4, and 5:
tricalc -a 3 -b 4 -c 5 

## How to Install
**For Linux and Windows:**  
Read the instructions in the [install.txt](https://github.com/JoseCintra/CLIMathUtils/blob/main/tcal/src/install.txt) file in the [src](https://github.com/JoseCintra/CLIMathUtils/tree/main/tcal/src) folder  

## Dependencies
Triangle Calculator uses [f90getopt](https://github.com/haniibrahim/f90getopt), a Library for command-line parsing.  

