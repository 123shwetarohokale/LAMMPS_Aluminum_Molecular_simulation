# LAMMPS_Aluminum_Molecular_simulation

LAMMPS model to optimize aluminum structure size
This repository contains scripts and documentation for running molecular dynamics (MD) simulations of aluminum using LAMMPS.
The simulations investigate the mechanical and thermodynamic properties of single-crystal Al under uniaxial tensile deformation and thermal equilibration.

**Execution environment:**

This input script was run using the Aug 2015 version of LAMMPS.

CPU-based simulation (GPU required)

Runs on standard HPC cluster or local workstation

**2.1 System Initialization Protocol**

Lattice: FCC Aluminum

Orientation: x[100], y[010], z[001]

Initial lattice constant: 4.0 Å

System size: 15 × 15 × 15 unit cells = 13,500 atoms

**2.2 Interatomic Potential**

Potential: Embedded Atom Method (EAM)

File: Al99.eam.alloy

Reference: Mishin et al. (1999)

LAMMPS settings:

pair_style eam/alloy

pair_coeff * * Al99.eam.alloy Al

**2.3 Minimization and Equilibration Protocol**

**Energy Minimization:**

Conjugate gradient (min_style cg)

Relaxation under isotropic pressure:

fix 1 all box/relax iso 0.0 vmax 0.001

minimize 1e-25 1e-25 5000 10000

**Thermal Equilibration:**

NVT ensemble at 273 K for 1000 timesteps

Velocity initialized with Gaussian distribution

timestep 0.0025
velocity all create 273 4928459 dist gaussian
fix ensFix all nvt temp 273 273 0.25
run 1000

**2.4 System Size Justification**

The 13,500-atom configuration ensures bulk-like behavior under periodic boundaries.

Literature (Tschopp et al., Acta Materialia, 2007) confirms convergence of energy and mechanical properties in FCC Al for systems ≥10×10×10 unit cells.

Our simulations balance physical accuracy with computational feasibility.

Simulation: (Python script files)

1.	# Aluminum Atomic structure from LAMMPS
   
-	Input file: Input file: in_lattice.nvt
  
-	SLURM Submission Script: submitlattice-job.sh
  
-	Output files: al.data-lattice.out
  
2.	# Energy convergence during minimization:
   
-	Input file: Input file: in_autocorrelation.nvt
  
-	SLURM Submission Script: submitenergycon-job.sh
  
-	Output files: al.data-lattice.out, energy_convergence.log
  
3.	# Autocorrelation of energy components:
   
-	Input file: Input file: in_autocorrelation.nvt
  
-	SLURM Submission Script: submitenergycon-job.sh
  
-	Output files: al.data-lattice.out, energy_time_series.log
  
4.	# Stress – Strain Response of Aluminum:
   
-	Input file: Input file: in_tensile.nvt
  
-	SLURM Submission Script: submittensile-job.sh
  
-	Output files: al.tensiledata.out, alAl_tens_100.def1.txt
