# 📘 Part 6 – Simulink Model Implementation

## 📌 Overview

This part presents the **Simulink implementation** of the particle–surface interaction model developed in the previous parts.

The model represents a continuous-time simulation of:

- Particle motion under drag and gravity  
- Energy-based surface adhesion  
- Probabilistic deposition logic  
- PID-controlled horizontal motion  

The Simulink architecture mirrors the validated MATLAB implementation while providing a modular and visual system representation.

---

## 🧱 System Architecture

The model is structured into three major subsystems:

### 1️⃣ PID Controller

Controls horizontal motion toward a target position.

**Inputs:**
- `x_target`
- `x`

**Output:**
- `u_x`

Vertical control (`u_y`) is set to zero in this study.

---

### 2️⃣ ParticleDynamics Subsystem

Implements Newtonian motion under:

- Linear drag force  
- Gravitational force  
- Fluid–particle relative velocity  

It computes:
- Horizontal acceleration `ax`
- Vertical acceleration `ay`

Using continuous integrators:

ax → ∫ → vx_raw → ∫ → x
ay → ∫ → vy_raw

This corresponds to the MATLAB update:

dstate = [vx; vy; ax; ay; 0; 0];
state = state + dstate * dt;

In Simulink, integration is handled directly by continuous integrator blocks instead of explicit time stepping.

---

### 3️⃣ WallInteraction Subsystem

Implements the energy-based adhesion and deposition model.

**Inputs:**
- `x`
- `y`
- `vx_raw`
- `vy_raw`

**Logic includes:**
- Wall contact detection  
- Local adhesion energy profile  
- Normal kinetic energy calculation  
- Probabilistic deposition condition  
- Velocity correction (bounce or sticking)

**Outputs:**
- `vx_out`
- `vy_out`
- `deposited_state`

When deposition occurs:
- Velocities are set to zero  
- Motion is terminated  

---

## 🔁 Closed-Loop Structure

Corrected velocities (`vx_out`, `vy_out`) are fed back into:

ParticleDynamics → acceleration

This creates a fully coupled dynamic loop.

---

## 📊 Outputs Visualized

The model logs:

- `x vs time`
- `u_x vs time`
- `y vs time`
- `deposited_state`

These allow observation of:

- Horizontal tracking performance  
- Vertical motion behavior  
- Deposition events  

---

## 🧠 Key Differences from MATLAB Version

| MATLAB Implementation | Simulink Implementation |
|-----------------------|-------------------------|
| Explicit Euler update | Continuous integrators |
| State vector update | Signal-based architecture |
| Sequential execution | Parallel block execution |
| Function-based | Subsystem-based |

The underlying physics remain consistent between both implementations.

---

## 🎯 Purpose of This Part

This Simulink model serves to:

- Visualize system-level architecture  
- Provide modular simulation blocks  
- Enable future extension (multi-particle, CFD coupling, etc.)  
- Demonstrate control integration in a graphical environment  

---

## 🚧 Current Status

The MATLAB implementation remains the validated reference model.

The Simulink model provides a structural and architectural representation of the system and will be further refined in future updates.

---

## 📁 Model File

particle_surface_interaction_model.slx

---

## 🚀 Why This Matters

This part bridges the gap between:

- physics-based particle trajectory modeling (Parts 1–4),
- statistical multi-particle reasoning (Part 5),
- and full system-level architectural modeling in Simulink.

With this, the project transitions from equation-level simulation to:

- modular system design,
- control-integrated physical modeling,
- hybrid continuous–discrete interaction modeling.

This structure reflects how real-world engineering systems are built — where physics, control, logic, and probabilistic events coexist within a unified framework.

---

## 🎓 Project Completion

With Part 6, the core framework of the **Particle–Surface Interaction Modeling Project** is complete.

The project now includes:

- Deterministic trajectory simulation  
- Energy-based adhesion modeling  
- Probabilistic deposition logic  
- Multi-particle statistical analysis  
- PID-controlled transport  
- Full Simulink system architecture  

This marks the completion of the foundational modeling phase.

---

## 🔮 Future Possibilities

The framework is now ready for extension into:

- 🔬 Multi-particle interaction and collision modeling  
- 🌊 CFD-coupled particle transport  
- 📊 Large-scale Monte Carlo statistical studies  
- 🎯 Control optimization under uncertainty  
- 🧠 Reinforcement learning–based trajectory control  
- 🧩 Hybrid state-machine modeling (Stateflow integration)  
- 🏭 Surface fouling prediction in industrial systems  
- 🧪 Aerosol transport and contamination risk modeling  

The modular architecture enables scaling toward research-grade or publication-ready simulations.

---

## 📌 Final Note

While the MATLAB implementation serves as the validated computational reference,  
the Simulink model represents the **system-engineering perspective** of the same physics.

Together, they form a complete modeling workflow:

> Mathematical Formulation → Numerical Simulation → Statistical Modeling → System Architecture

This concludes the primary development phase of the project.

---
