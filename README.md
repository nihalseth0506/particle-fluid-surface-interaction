# Particle–Fluid–Surface Interaction  
## A Hybrid Dynamics Simulation Framework

## Overview

This project presents a modular simulation framework for modeling particle motion under gravity, fluid flow, and surface interaction using MATLAB.

The system is formulated as a **hybrid dynamical system**, combining:
- continuous particle dynamics governed by differential equations, and
- discrete contact events that instantaneously modify the system state.

The project is intentionally developed in **incremental, self-contained parts**, starting from a clear and interpretable baseline model and extending toward physically grounded deposition modeling, statistical analysis, and control-oriented system design.

---

## Project Structure

The repository is organized into independent parts, each building conceptually on the previous one:

- **Part 1 – Baseline Model**  
  Fundamental 2D particle motion under gravity and drag with basic surface contact.  
  Serves as a reference implementation for understanding hybrid dynamics and numerical integration.

- **Part 2 – Contact Models and Deposition**  
  Extension of surface interaction logic to compare:
  - velocity-based sticking models, and  
  - energy-based irreversible deposition using terminal (absorbing) states.

- **Part 3 – Energy-Based Deposition & Statistical Modeling**  
  Introduction of physically grounded deposition models, including:
  - deterministic energy-based deposition,
  - probabilistic deposition using Monte Carlo simulation,
  - adhesion energy sweeps,
  - time-to-deposition analysis, and
  - multi-particle ensemble statistics.

Planned future extensions include:
- flow-controlled particle transport and targeting  
- control-system integration (feedback, actuation, stability analysis)  
- parameter sensitivity and uncertainty quantification  
- full hybrid system modeling in Simulink  

Each part is developed independently to preserve clarity, interpretability, and reproducibility.

---

## Motivation

Particle–fluid–surface interaction plays a critical role in many engineering and scientific domains, including:
- aerosol and particulate transport  
- surface contamination and deposition  
- fluid-driven material handling  
- micro- and macro-scale hybrid dynamical systems  

This project focuses on **understanding modeling assumptions, numerical behavior, and physical interpretation** before introducing higher-fidelity complexity.

---

## Implementation Philosophy

The simulations are implemented in MATLAB with a clear separation between:
- physical parameters,
- continuous particle dynamics,
- discrete contact and deposition logic, and
- numerical time integration.

Key design principles include:
- explicit state representation,
- transparent event handling,
- minimal hidden assumptions, and
- extensibility toward higher dimensions and control-oriented formulations.

This structure enables straightforward extension to:
- alternative solvers,
- statistical modeling,
- multi-particle simulations, and
- system-level architectures.

---

## Status

Parts 1–3 establish a complete foundation for:
- hybrid dynamical modeling,
- physically grounded deposition behavior, and
- statistical particle–surface interaction analysis.

The framework is now prepared for **control engineering extensions and Simulink-based system modeling**.

---

## Author

Developed as an exploratory modeling and learning project, with emphasis on physical interpretability, numerical reasoning, and extensible system design.
