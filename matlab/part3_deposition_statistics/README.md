# Part 3 – Energy-Based Deposition & Statistical Modeling

## Overview

Part 3 extends the particle–fluid–surface interaction framework from
single-trajectory contact behavior to **energy-based irreversible deposition
and statistical population modeling**.

The focus shifts from asking:
- *Does a particle stick or bounce?*

to answering:
- *When does deposition occur?*
- *How likely is deposition?*
- *Where do particles deposit statistically?*

This part introduces deterministic and probabilistic energy-based deposition,
adhesion energy sweeps, and multi-particle ensemble analysis.

---

## State Definition

Each particle is described by the state vector:

state = [x; y; vx; vy; contact; deposited]

Where:
- `x, y` are particle position
- `vx, vy` are velocity components
- `contact` indicates surface contact
- `deposited` is a terminal (absorbing) state

Once `deposited = 1`, the particle is permanently attached to the surface and
no longer evolves.

---

## Continuous Particle Dynamics

Between contact events, particles evolve under:
- gravity
- linear drag relative to fluid velocity
- tangential friction during surface contact

These dynamics are implemented in:
particleDynamics.m

Deposited particles enter a terminal state where all derivatives are zero.

---

## Contact and Deposition Logic

Surface interaction is handled as a discrete event in:
wallInteraction.m

Two energy-based deposition models are implemented.

---

## Model A – Deterministic Energy-Based Deposition

In the deterministic model, deposition occurs when the normal impact energy
falls below a fixed adhesion threshold.

Characteristics:
- binary outcome (deposit or rebound)
- sharp adhesion threshold
- irreversible deposition
- no randomness

This model is implemented and swept in:
main_deterministic_sweep.m

Generated outputs:
- deposition probability vs adhesion energy
- mean time to deposition

---

## Adhesion Energy Sweeps

Adhesion energy is swept across several orders of magnitude using logarithmic
spacing.

Each adhesion value runs a full time-domain simulation, revealing:
- abrupt transitions in deterministic models
- gradual probability ramps in probabilistic models

This demonstrates why probabilistic deposition is more physically realistic.

---

## Multi-Particle Ensemble Modeling

Single-particle simulations are extended to ensembles of particles with
randomized initial conditions.

Key features:
- fixed adhesion energy per experiment
- random initial height and velocity
- independent particle realizations
- statistical aggregation of outcomes

Implemented in: main_multiparticle.m; 
sampleInitialState.m

Computed statistics include:
- fraction of particles deposited
- distribution of deposition locations
- distribution of time to deposition

Results are visualized using combined subplot layouts.

---

## Deterministic vs Probabilistic Comparison

A direct comparison between deterministic and probabilistic deposition models
is performed to highlight fundamental modeling differences.

Implemented in:
main_comparison_prob_vs_det.m

Key observations:
- deterministic models exhibit sharp transitions
- probabilistic models show smooth adhesion regimes
- statistical variability exists only in probabilistic formulations

---

## Hybrid Dynamical System Perspective

The overall system is a **hybrid dynamical system** combining:
- continuous particle motion
- discrete surface interaction events
- terminal absorbing states for deposition

This structure closely mirrors real-world particulate deposition modeling.

---

## Why This Matters

This part demonstrates that:
- velocity-based sticking is numerically convenient but physically weak
- energy-based models improve physical grounding
- probabilistic models capture uncertainty and variability
- ensemble statistics reveal behaviors invisible in single trajectories

Relevant applications include:
- aerosol and particulate deposition
- contamination modeling
- surface fouling analysis
- particle transport systems

---

## Status

Part 3 completes the transition from trajectory-level modeling to
**statistical deposition analysis**.

The framework is now ready for:
- flow-controlled deposition
- feedback and control system integration
- multi-particle interaction extensions
- full system modeling in Simulink
