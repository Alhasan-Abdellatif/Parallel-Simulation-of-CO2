#!/bin/bash

###### USERS INPUT ############################################################

# Define flow rate
flowrate=1e-8

## Define the kinematic viscocity of the fluid (m^2/s)
##(e.g for water this is 1e-6, for air this would be 1.5e-5)
Visc=1e-06

#### END OF USER INPUT

cp constant/transportPropertiesSP constant/transportProperties
sed -i "s/Visc/$Visc/g" constant/transportProperties

cp -r 0_org_SP 0

sed -i "s/flowrate/$flowrate/g" 0/U

if [ -d "processor0" ]
then
    if [ ! -d "constant/polyMesh" ]
    then
            echo -e "reconstruct parallel mesh"
            reconstructParMesh -constant > reconstructParMesh.out
    fi

    # Decompose
    echo -e "DecomposePar"
    decomposePar -fields > decomposeParSP.out
    rm -rf 0
fi

echo -e "Case initialised"
