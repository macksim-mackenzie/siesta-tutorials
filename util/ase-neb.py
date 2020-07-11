#!/usr/bin/env python3
# -*- coding: utf-8 -*-

'''
   Use ase 3.17.0 
'''

from ase import Atoms
from ase.calculators.siesta import Siesta
from ase.neb import NEB
from ase.optimize import FIRE, BFGS
from ase.io import read
from ase.visualize import view
from ase.units import Ry, eV, Ang

#NEB
initial = read('initial-relax.xyz')
final = read('final-relax.xyz')
num_images=5

images = [initial]

def calculate_siesta(i):
    siesta = Siesta(label = 'image-{}'.format(i),
    xc = 'PBE',
    mesh_cutoff = 400 * Ry,
    energy_shift = 0.03,
    basis_set = 'DZP',
    spin = 'UNPOLARIZED',
    kpts = [9,5,1],
    fdf_arguments={'Diag.ParallelOverK': True,
                   'MaxSCFIterations':   300,
                   'DM.MixingWeight':    0.10,
                   'DM.NumberPulay':     5,
                   'DM.NumberKick':      50})
    return siesta


# variable cell
def variable_cell(x):
    cell_init = initial.get_cell()
    cell_final = final.get_cell()
    return x*cell_final + (1-x)*cell_init


for i in range(num_images):
    image = initial.copy()
    x = i/float(num_images)
    image.set_cell(variable_cell(x))
    image.set_calculator(calculate_siesta(i))
    images.append(image)


images.append(final)

neb = NEB(images, climb=True)
neb.interpolate()

# Visualization of interpolation
#view(images)

# NEB calculation
dynamics = BFGS(neb, trajectory='neb.traj')
dynamics.run(fmax=0.05)

# convert to xyz file
write('neb.xyz', read('neb.traj@-7:'))
