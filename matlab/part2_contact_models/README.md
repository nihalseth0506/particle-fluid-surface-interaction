# Part 2 – Particle–Wall Contact Models: Velocity vs Energy-Based Deposition

## Overview

This part extends the baseline particle–wall interaction model (Part 1) by introducing physically motivated deposition mechanics and comparing two different wall-contact interpretations:

- Velocity-based contact model (heuristic, reversible)
- Energy-based deposition model (physics-based, irreversible)

The goal of Part 2 is to isolate how contact interpretation alone affects particle behavior, while keeping all continuous dynamics identical.

---

## What is new compared to Part 1

- Introduction of an energy-based deposition criterion using an adhesion energy threshold
- Implementation of a terminal (absorbing) state to represent irreversible deposition
- Side-by-side comparison of velocity-based and energy-based contact models
- Unified simulation framework with a model-selection switch
- Clear separation between physical modeling and numerical stabilization

---

## Contact models implemented

### 1. Velocity-based contact model (Model A)

- Uses the normal impact velocity as the decision variable
- If the normal velocity magnitude falls below a threshold, vertical motion is stopped
- Contact is reversible by construction
- Commonly used in simplified or heuristic simulations

This model is easy to implement but is not directly tied to physical energy considerations.

---

### 2. Energy-based deposition model (Model B)

- Uses the normal kinetic energy at impact

  En = 0.5 * m * vy^2

- If the impact energy falls below a specified adhesion energy, the particle is considered deposited
- Deposition is irreversible and implemented as a terminal state
- After deposition, all dynamics are frozen and velocities are set to zero for interpretability

This model reflects how real particle deposition is typically modeled in physics and engineering.

---

## Terminal (absorbing) state

Once a particle is deposited:

- The system enters a terminal state
- All state derivatives are set to zero
- The particle position and velocity no longer evolve
- This represents permanent capture unless external energy is introduced (not modeled here)

The terminal state is a key difference from the reversible sticking logic used in Part 1.

---

## Continuous dynamics (common to both models)

Both contact models share the same continuous-time dynamics:

- Gravity
- Linear drag relative to fluid velocity
- Surface friction during contact
- Explicit Euler time integration

Because these dynamics are identical, the particle trajectories and velocities overlap almost entirely until a wall-impact event occurs.

Differences appear only at contact, where the interpretation of impact changes.

---

## Numerical stabilization

A small horizontal velocity deadband is applied:

- Only near zero velocity
- Only during contact
- Used solely to suppress numerical jitter caused by Euler integration and Coulomb friction

This stabilization does not determine physical outcomes and does not affect the deposition decision.

---

## Results and observations

Two figures are generated in this part:

1. Trajectory comparison (x–y)  
   Both models follow identical trajectories until contact; the energy-based model terminates earlier due to deposition.

2. Vertical velocity comparison (zoomed near contact)  
   The curves overlap during flight and diverge only when the deposition criterion is met.

This confirms that continuous motion is governed by shared dynamics, while contact models influence the system only within a specific impact regime.

---

## How to run

1. Navigate to this folder in MATLAB
2. Open and run main.m
3. The script automatically:
   - runs the velocity-based model
   - runs the energy-based model
   - generates comparison plots

The contact model can be switched internally using the params.contactModel parameter.

---

## Key takeaway

In this part, contact models do not govern particle motion.  
They govern state transitions at impact.

By separating continuous dynamics from contact interpretation, this model demonstrates why energy-based deposition provides a more physically grounded description of particle capture.

---

The next step (Part 3) will extend this framework to parameter sweeps, probabilistic deposition, and statistical analysis of capture behavior.
