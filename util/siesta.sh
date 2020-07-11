#  SIESTA shell functions
#
#    Leandro Seixas <leandro.seixas@mackenzie.br>
#    MackGraphe - Graphene and Nanomaterials Research Center
#    Mackenzie Presbyterian University
#

function siestafunction_force() {
  grep constrained job.out | awk '{print $2}' | tail -n 1
}

function siestafunction_forces() {
  grep constrained job.out | awk '{print $2}'
}

function siestafunction_clean() {
 rm -f H_DMGEN *.bib DM* *.ion* MMpot.* INPUT_TMP.* fdf* Rho.grid.nc FORCE_STRESS CLOCK OCCS BASIS_* NON_TRIMMED_* H_MIXED PARALLEL_DIST MESSAGES 0_NORMAL_EXIT
}

function siestafunction_energy() {
  grep "Total =" job.out | cut -d = -f 2
}

function siestafunction_temp() {
  grep "Temp_ion" job.out | cut -d = -f 2
}

function siestafunction_atoms(){
  grep "initatomlists\: Number of atoms" job.out | awk '{print $8}'
}

function siestafunction_spin(){
  grep "spin moment" job.out | tail -1 | awk '{print $10}'
}
