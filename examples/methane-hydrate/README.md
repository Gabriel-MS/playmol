# Methane Hydrate

![CS1](CS1.png)
> vizualization created using [VMD](www.ks.uiuc.edu/Research/vmd/
)

This example builds a box with molecules of water and methane in CS1 hydrate structure:

## *unit-cell.mol* file:

Contains molecular information and box specification

## *TIP4P.mol* file:

Contains force field parameters for the atoms present in *unit-cell.mol*

*uc-water.mol* and *uc-methane.mol* files:

Contains atomic coordinates for water molecules (atomistic) and for methane molecules (center of mass), respectively

## to try it, run:

	playmol unit-cell.mol

## info files
  README.md
  CS1.png

## input files:
  unit-cell.mol
  TIP4P.mol
  uc-methane.mol
  uc-water.mol

## output files:
  playmol.log
  water_TIP4P.xyz
  water_TIP4P.lmp
  water_TIP4P.lammpstrj

