# Particle–Fluid–Surface Interaction  
## A Hybrid Dynamics Simulation Framework

---

## Overview

This project presents a modular simulation framework for modeling particle motion under gravity, fluid flow, and surface interaction using MATLAB and Simulink.

The system is formulated as a **hybrid dynamical system**, combining:
- continuous particle dynamics governed by differential equations, and
- discrete contact events that instantaneously modify the system state.

The project is intentionally developed in **incremental, self-contained parts**, starting from a clear and interpretable baseline model and extending toward physically grounded deposition modeling, statistical analysis, control-oriented system design, and full system-level architecture.

---

## Project Structure

The repository is organized into independent parts, each building conceptually on the previous one:

---

### **Part 1 – Baseline Model**
Fundamental 2D particle motion under gravity and drag with basic surface contact.  
Serves as a reference implementation for understanding hybrid dynamics and numerical integration.

---

### **Part 2 – Contact Models and Deposition**
Extension of surface interaction logic to compare:
- velocity-based sticking models, and  
- energy-based irreversible deposition using terminal (absorbing) states.

---

### **Part 3 – Energy-Based Deposition & Statistical Modeling**
Introduction of physically grounded deposition models, including:
- deterministic energy-based deposition,
- probabilistic deposition using Monte Carlo simulation,
- adhesion energy sweeps,
- time-to-deposition analysis, and
- multi-particle ensemble statistics.

---

### **Part 4 – Flow-Controlled Transport & Feedback Control**
Integration of control-system concepts to actively guide particle transport prior to deposition:
- open-loop flow actuation,
- proportional (P), proportional–integral (PI), and PID feedback control,
- spatially varying adhesion (capture zones),
- actuator saturation and anti-windup logic, and
- stochastic flow disturbances using time-correlated noise models.

This part demonstrates how control and surface physics interact in hybrid particle systems.

---

### **Part 5 – Multi-Particle Transport & Population Statistics**
Extension from single-particle dynamics to **population-level modeling under shared flow fields**:
- simultaneous simulation of multiple particles,
- shared open-loop and feedback-controlled flow actuation,
- probabilistic deposition at the particle level,
- Monte Carlo experiments across repeated runs, and
- statistical analysis of deposition fraction, deposition time, and spatial clustering.

This part highlights variability, robustness, and reliability of controlled particle transport.

---

### **Part 6 – System-Level Hybrid Modeling in Simulink**
Translation of the MATLAB-based hybrid model into a modular Simulink architecture.

Key features:
- Modular subsystems for Particle Dynamics, Surface Interaction, and PID Control  
- Explicit state integration using continuous-time blocks  
- Hybrid logic for contact detection and energy-based adhesion  
- Probabilistic deposition implementation  
- Closed-loop control integrated within physical dynamics  
- Clear separation between physics, control, and logical events  

This part represents the **system-engineering realization** of the mathematical framework developed in Parts 1–5.

The Simulink model provides:
- architectural clarity,
- control-system visualization,
- hybrid continuous–discrete interaction modeling, and
- a foundation for future large-scale system extensions.

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

The simulations are implemented with a clear separation between:
- physical parameters,
- continuous particle dynamics,
- discrete contact and deposition logic,
- control laws and actuation, and
- numerical time integration.

Key design principles include:
- explicit state representation,
- transparent event handling,
- minimal hidden assumptions,
- modular system decomposition, and
- extensibility toward control-oriented and system-level formulations.

The workflow evolves across the project:

> Mathematical Formulation → Numerical Simulation → Statistical Modeling → System Architecture

---

## Status

Parts **1–6** establish a complete hybrid modeling framework for:

- continuous particle dynamics  
- energy-based adhesion modeling  
- deterministic and probabilistic deposition  
- feedback-controlled particle transport  
- multi-particle statistical analysis  
- system-level hybrid modeling in Simulink  

With Part 6, the foundational development phase of the project is complete.

The framework now supports:

- uncertainty and robustness studies  
- large-scale Monte Carlo simulations  
- system-level control integration  
- hybrid continuous–discrete modeling  
- extensibility toward CFD coupling or advanced control strategies  

---

## Project Closure

This project demonstrates a full progression from:

- physics-based modeling,
- to statistical reasoning,
- to control integration,
- to architectural system design.

The MATLAB implementation serves as the validated numerical reference,  
while the Simulink model provides the system-engineering perspective.

Together, they form a complete, extensible simulation framework for hybrid particle–surface interaction systems.

Future work may extend toward:
- multi-particle interaction and collision modeling  
- reinforcement learning–based control  
- uncertainty quantification and sensitivity analysis  
- CFD-integrated particle transport  
- Stateflow-based hybrid logic modeling  

The current repository concludes the primary development phase and establishes a strong foundation for future research or applied extensions.

---

## Author

Developed as an exploratory modeling and learning project, with emphasis on:

- physical interpretability  
- numerical reasoning  
- hybrid dynamical systems  
- control integration  
- system-level architecture design  

**Author:** Nihal Sanjay Seth  
**Year:** 2026
