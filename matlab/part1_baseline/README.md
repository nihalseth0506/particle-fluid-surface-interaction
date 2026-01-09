# Part 1 — Baseline Particle–Fluid–Surface Interaction Model

## Overview

This part presents a **baseline 2D simulation of particle motion under gravity, fluid drag, and surface contact**, implemented in MATLAB.  
The goal of this stage is **not to enforce a final deposition behavior**, but to establish a **clear, modular, and physically interpretable foundation** upon which more advanced modeling choices can be built.

The system is intentionally kept simple to expose the underlying dynamics and numerical behavior before introducing additional assumptions such as adhesion, static friction, control strategies, or higher-fidelity solvers.

---

## Model Description

### State Definition

The particle state is defined as:

```
state = [x, y, vx, vy, contact]
```

where:
- `x, y` are particle positions
- `vx, vy` are particle velocities
- `contact` is a logical flag indicating persistent contact with the surface

---

### Continuous Dynamics

While the particle is airborne or sliding, its motion is governed by continuous dynamics:

- Gravity acting in the negative y-direction  
- Linear drag proportional to the **relative velocity** between the particle and the surrounding fluid  
- Surface friction applied when contact with the wall is active  

These dynamics are implemented in `particleDynamics.m` and integrated using **explicit Euler time stepping**.

---

### Discrete Contact Dynamics (Hybrid Modeling)

Surface interaction is handled separately in `wallInteraction.m`.

The solver follows a **predict–correct** structure:

1. **Predict**  
   Continuous dynamics are integrated forward in time.

2. **Detect**  
   If the predicted position crosses the wall (`y ≤ wallY`), contact is detected.

3. **Correct**  
   Discrete logic determines whether the particle:
   - **sticks** (low-velocity impact), or  
   - **bounces** (higher-energy impact with restitution)

Crossing the wall is treated as a **contact detection signal**, not as a physical penetration state.

This separation of smooth dynamics and instantaneous corrections makes the system a **hybrid dynamical system**.

---

## Key Observations

### 1. Regime Switching at Contact

A clear change in horizontal velocity occurs at the moment of surface contact.  
This is caused by the **activation of surface friction**, which introduces a new force regime instantaneously.

This behavior highlights the hybrid nature of the model.

---

### 2. Asymptotic Velocity Decay and Numerical Zero

In the absence of fluid flow, horizontal velocity decays due to drag and surface friction.  
Once the velocity falls below a small threshold, it is explicitly clamped to zero to represent sticking.

After this point:
- Velocity remains zero  
- Time continues to advance  
- Position remains constant  

A flat velocity line at zero therefore indicates **no further motion**, not a terminated simulation.

---

### 3. Sliding Equilibrium Under Airflow

When a constant fluid velocity is applied, the particle does **not necessarily come to rest**.

Instead, a **non-zero steady horizontal velocity** emerges from a balance between:
- drag induced by relative flow  
- surface friction  

This sliding equilibrium is a natural outcome of the modeled forces and is intentionally preserved in Part 1.

---

## Modeling Assumptions

- Motion is restricted to 2D  
- Drag is linear in relative velocity  
- Contact is modeled using velocity-based logic  
- Static adhesion effects are not enforced beyond a small velocity threshold  
- Only a single particle is simulated  

These assumptions are **deliberate** and serve to keep the baseline model interpretable and extensible.

---

## Limitations (Intentional)

This baseline model does **not** include:
- Adhesion-dominated sticking models  
- Multiple contact surfaces  
- Higher-order numerical solvers  
- Particle–particle interactions  
- Control of airflow or targeting objectives  

Each of these aspects is planned as a **separate extension**, rather than being merged prematurely into the baseline.

---

## Purpose of Part 1

Part 1 establishes:
- A clean modular architecture  
- A correct hybrid dynamics framework  
- Physically interpretable baseline behavior  

All future extensions build upon this foundation without modifying its core logic.

---

## Next Steps

Planned extensions include:
- Alternative contact and deposition models  
- Solver comparisons and parameter sweeps  
- System-level modeling in Simulink  
- Control of particle transport via airflow  
- Statistical and multi-particle extensions  
