#!/usr/bin/env python3
'''
  Use ase 3.17.0
'''

import numpy as np
from ase import Atoms
from ase.calculators.siesta import Siesta
from ase.units import Ry, eV, Ang
from ase.visualize import view
from ase.optimize import QuasiNewton, BFGS
from ase.io import write, read

atoms = read('initial-input.xyz')

siesta = Siesta(label = 'initial',
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
                               'DM.NumberKick':      50,
                               'WriteMDXmol':        True})

atoms.set_calculator(siesta)
#eng = atoms.get_potential_energy()

dynamics = BFGS(atoms=atoms, trajectory='initial-relax.traj')
dynamics.run(fmax=0.01)

# convert to xyz file
write('initial-relax.xyz', read('initial-relax.traj'))
