# Particle–Fluid–Surface Interaction  
## A Hybrid Dynamics Simulation Framework

## Overview

This project presents a modular simulation framework for modeling particle motion under gravity, fluid flow, and surface interaction using MATLAB.

The system is formulated as a hybrid dynamical system, combining:
- continuous particle dynamics governed by differential equations, and
- discrete contact events that instantaneously modify the system state.

The project is intentionally developed in incremental parts, starting from a clear and interpretable baseline model and extending toward more advanced modeling, numerical, and control concepts.

---

## Project Structure

The repository is organized into self-contained parts:

- **Part 1 – Baseline Model**  
  Fundamental 2D particle motion with gravity, drag, and surface contact, serving as the reference implementation.

- **Part 2 – Contact Models and Deposition**  
  Comparison of velocity-based and energy-based particle–wall interaction models, including irreversible deposition via terminal (absorbing) states.

Planned future extensions include:
- parameter sweeps and sensitivity analysis  
- probabilistic and multi-particle deposition modeling  
- flow-based control of particle transport  
- system-level hybrid modeling in Simulink  

Each part is developed independently to preserve clarity, interpretability, and reproducibility.

---

## Motivation

Particle–fluid–surface interaction plays a critical role in many engineering and scientific domains, including:
- aerosol and particulate transport  
- surface contamination and deposition  
- fluid-driven material handling  
- hybrid dynamical systems with contact constraints  

This project focuses on understanding the modeling assumptions and numerical behavior underlying such systems before introducing higher-fidelity complexity.

---

## Implementation

The simulations are implemented in MATLAB, with a clean separation between:
- physical parameters  
- continuous dynamics  
- discrete contact logic  
- numerical time integration  

This modular structure enables straightforward extension to higher dimensions, alternative solvers, and control-oriented formulations.

---

## Author

Developed as an exploratory modeling and learning project, with emphasis on physical interpretability, numerical reasoning, and extensible system design.
