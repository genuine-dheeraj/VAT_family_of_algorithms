VEDA (Visual Exploratory Data Analysis) toolkit

User friendly implementation of various members of the visual assessment of clustering tendency (VAT) family of algorithms for exploratory data analysis. Run the demo on syntetic data or your own data.

The "Example datsets" folder contains various datasets which can be used as an input to the software. Use small datasets such as "iris.csv", "iris_2_features.csv", "iris_3_features.csv", "iris_no_label.csv", and "wine.csv" for small static data (VAT/iVAT) and streaming data (incVAT/inciVAT/decVAT/deciVAT). Use "dist_matrix_ex.csv", "dist_matrix_wrong_ex_1.csv", "dist_matrix_wrong_ex_2.csv", and "dist_matrix_wrong_ex_3.csv" for distance (dissimilarity) matrix data. Use big datasets such as "adult.csv", "breast-cancer-wisconsin.csv", "car.csv", "winequality-red.csv", and "winequality-white.csv" for big static data (clusiVAT)


VEDA Executable

1. Prerequisites for Deployment 

Verify that version 9.7 (R2019b) of the MATLAB Runtime is installed.   
If not, you can run the MATLAB Runtime installer.
To find its location, enter
  
    >>mcrinstaller
      
at the MATLAB prompt.
NOTE: You will need administrator rights to run the MATLAB Runtime installer. 

Alternatively, download and install the Windows version of the MATLAB Runtime for R2019b 
from the following link on the MathWorks website:

    https://www.mathworks.com/products/compiler/mcr/index.html
   
For more information about the MATLAB Runtime and the MATLAB Runtime installer, see 
"Distribute Applications" in the MATLAB Compiler documentation  
in the MathWorks Documentation Center.

2. Files to Deploy and Package

Files to Package for Standalone 
================================
-VEDA.exe
-MCRInstaller.exe 
    Note: if end users are unable to download the MATLAB Runtime using the
    instructions in the previous section, include it when building your 
    component by clicking the "Runtime included in package" link in the
    Deployment Tool.
-This readme file 



3. Definitions

For information on deployment terminology, go to
https://www.mathworks.com/help and select MATLAB Compiler >
Getting Started > About Application Deployment >
Deployment Product Terms in the MathWorks Documentation
Center.
