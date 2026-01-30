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

- **Part 4 – Flow-Controlled Transport & Feedback Control**  
  Integration of control-system concepts to actively guide particle transport prior to deposition:
  - open-loop flow actuation,
  - proportional (P), proportional–integral (PI), and PID feedback control,
  - spatially varying adhesion (capture zones),
  - actuator saturation and anti-windup logic, and
  - stochastic flow disturbances using time-correlated noise models.

  This part demonstrates how control and surface physics interact in hybrid particle systems.

- **Part 5 – Multi-Particle Transport & Population Statistics**  
  Extension from single-particle dynamics to **population-level modeling under shared flow fields**:
  - simultaneous simulation of multiple particles,
  - shared open-loop and feedback-controlled flow actuation,
  - probabilistic deposition at the particle level,
  - Monte Carlo experiments across repeated runs, and
  - statistical analysis of deposition fraction, deposition time, and spatial clustering.

  This part highlights variability, robustness, and reliability of controlled particle transport.

Planned future extensions include:
- interaction-driven stochastic behavior and emergent dynamics  
- parameter sensitivity and uncertainty quantification  
- **system-level hybrid modeling in Simulink**

Each part is developed independently to preserve clarity, interpretability, and reproducibility.

---

## Motivation

Particle–fluid–surface interaction plays a critical role in many engineering and scientific domains, including:
- aerosol and particulate transport  
- surface contamination and fouling  
- fluid-driven material handling  
- filtration and capture systems  
- micro- and macro-scale hybrid dynamical systems  

This project focuses on **understanding modeling assumptions, numerical behavior, and physical interpretation** before introducing higher-fidelity complexity.

---

## Implementation Philosophy

The simulations are implemented in MATLAB with a clear separation between:
- physical parameters,
- continuous particle dynamics,
- discrete contact and deposition logic,
- control laws and actuation, and
- numerical time integration.

Key design principles include:
- explicit state representation,
- transparent event handling,
- minimal hidden assumptions, and
- extensibility toward control-oriented and system-level formulations.

This structure enables straightforward extension to:
- alternative numerical solvers,
- statistical and Monte Carlo modeling,
- ensemble and population-based simulations, and
- Simulink-based hybrid architectures.

---

## Status

Parts **1–5** establish a complete foundation for:
- hybrid dynamical modeling,
- physically grounded deposition behavior,
- statistical particle–surface interaction analysis,
- feedback-controlled particle transport under uncertainty, and
- population-level robustness and reliability assessment.

The framework is now prepared for:
- **system-level hybrid modeling in Simulink**, and
- higher-level integration of control, uncertainty, and large-scale dynamics.

---

## Author

Developed as an exploratory modeling and learning project, with emphasis on physical interpretability, numerical reasoning, and extensible system design.
