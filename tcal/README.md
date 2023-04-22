# Triangle Calculation

Triangle Claculation (tcal) is a command-line program developed in Fortran that calculates the principal elements of a triangle based on the dimension of its sides a, b and c. Along with the program, a Fortran library (tcal_lib) is also available, which can be used in other mathematical projects.

## Features
Until the present version (1.6.0), the following calculations are available:
* Perimeter
* Semiperimeter
* Area by Heron e Height formulas
* Internal and External angles by the cosine formula
* Types with respect to the number of sides and angles
* Heights of the triangle

## How to use

Usage: tricalc [options] …

Options:
|Short| Long | Function |
| ---| --- | --- |
|-h|--help|Print this help and exit|
|-v|--version|Print version information and exit|
|-a X|--aside=X|X is the length of side a|
|-b X|--bside=X|X is the length of side b|
|-c X|--cside=X|X is the length of side c|

Example:
tricalc -a 3 -b 4 -c 5 --> Calculates the triangle of sides 3,4, and 5


