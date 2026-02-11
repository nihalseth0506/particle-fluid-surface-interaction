# Part 5 – Multi-Particle Transport & Population Statistics

## Overview

Part 5 extends the particle–fluid–surface interaction framework from
single-particle and controlled transport to **multi-particle population
dynamics under shared flow fields**.

The focus shifts from individual trajectories to **population-level behavior**,
addressing questions such as:

- How does a population of particles behave under identical flow conditions?
- What fraction of particles deposit under open-loop vs controlled flow?
- How consistent and reliable is deposition across repeated experiments?
- Where do particles deposit statistically, and how tightly are they clustered?

This part introduces **ensemble simulations**, **Monte Carlo experiments**, and
**population statistics**, while preserving the hybrid dynamical system structure
developed earlier.

---

## Key Concepts Introduced

- Multi-particle state propagation under shared flow
- Population-level deposition metrics
- Monte Carlo simulation across independent runs
- Statistical analysis of deposition outcomes
- Reliability and variability of controlled transport

Each simulation run evolves **many particles simultaneously**, while Monte Carlo
loops repeat the experiment to quantify variability and robustness.

---

## Multi-Particle State Representation

Each particle is described by the same 6-dimensional state vector used previously:
state = [x; y; vx; vy; contact; deposited]

For a population of `N` particles, states are stored as a matrix:
states ∈ ℝ^(6 × N)

where each column corresponds to one particle.

All particles evolve under:
- identical fluid velocity,
- identical environmental parameters,
- independent contact and deposition events.

---

## Shared Flow Field and Control

A key modeling assumption in Part 5 is the **shared flow field**:

- The fluid velocity is computed **once per time step**
- The same flow acts on all particles
- Deposition outcomes differ due to particle-level dynamics and randomness

### Controlled Flow (PID)

For controlled simulations:
- The controller observes the **mean horizontal position** of all airborne particles
- A virtual controller state is constructed
- A single control action (flow velocity) is applied to the entire population

This models realistic scenarios where:
- flow is global (e.g., air duct, conveyor flow, channel),
- particles cannot be controlled individually.

---

## Core Algorithm: `runSimulationMulti`

The multi-particle simulation follows this structure:

1. Time is discretized into fixed steps
2. At each time step:
   - Flow velocity is computed (open-loop or controlled)
   - Optional disturbance is added
3. Each particle is updated sequentially:
   - Continuous dynamics (gravity, drag, friction)
   - Discrete wall interaction and deposition
4. Deposited particles enter a terminal absorbing state
5. All states are stored for post-processing

Despite sequential code execution, the model represents **simultaneous evolution**
of all particles at each time step.

---

## Experiments Included

### 1. Open-Loop Multi-Particle Transport

File: main_multiparticle_freeFlow.m

Purpose:
- Baseline population behavior under fixed flow
- No feedback or targeting
- Demonstrates uncontrolled dispersion and partial deposition

Outputs:
- Particle trajectories (x–y)
- Mean horizontal position vs time
- Deposition fraction vs time
- Final particle position distribution

---

### 2. Controlled Multi-Particle Transport (PID)

File: main_multiparticle_controlledFlow.m

Purpose:
- Compare open-loop vs feedback-controlled transport
- Demonstrate targeted deposition
- Evaluate clustering around the capture zone

Outputs:
- Multi-particle trajectories
- Mean population position tracking
- Deposition fraction evolution
- Final deposition location distribution

---

### 3. Monte Carlo Population Statistics

File: main_population_statistics.m

Purpose:
- Quantify reliability and variability across repeated experiments
- Each run simulates a new population with randomized initial conditions
- Statistics are aggregated across many runs

Computed metrics:
- Final fraction of particles deposited per run
- Mean deposition time per run
- Aggregate deposition location distribution
- Cumulative reliability metrics

Outputs are visualized using combined 2×2 subplot layouts for clarity.

---

## Monte Carlo Interpretation

Monte Carlo simulations reveal behaviors that are **invisible in single runs**:

- Variability in deposition success despite identical parameters
- Spread in deposition times due to stochastic contact outcomes
- Statistical clustering around the target capture zone
- Robustness (or fragility) of control strategies

These results emphasize that **control success is probabilistic**, not binary.

---

## Hybrid System Perspective

The overall system remains a **hybrid dynamical system** combining:

- Continuous-time particle motion
- Discrete surface interaction events
- Stochastic deposition decisions
- Terminal absorbing states

Part 5 demonstrates how hybrid dynamics scale from
single-particle models to **population-level systems**.

---

## Why This Matters

This part bridges the gap between:
- trajectory-level modeling (Parts 1–4), and
- system-level statistical reasoning.

Such population-based modeling is essential for:
- aerosol and particulate transport
- contamination risk assessment
- surface fouling prediction
- robustness analysis of flow-control strategies

---

## Status

Part 5 completes the transition to **multi-particle, statistical modeling**.

The framework is now ready for:
- uncertainty and robustness analysis,
- interaction-driven stochastic behavior,
- system-level hybrid modeling in Simulink,
- large-scale transport and control studies.

---




