# Part 4 – Flow-Controlled Transport, Feedback Control & Spatial Capture

## Overview

Part 4 extends the particle–fluid–surface interaction framework by introducing
**active flow control and feedback mechanisms** to steer particles toward
desired deposition locations.

The focus shifts from passive transport to **controlled, targeted deposition**
using classical control strategies combined with energy-based adhesion physics.

This part addresses:
- Controlled particle transport using flow actuation
- P, PI, and PID feedback controllers
- Spatially varying adhesion for selective capture
- Robustness under stochastic disturbances

---

## State Definition

Each particle is described by the state vector:

```
state = [x; y; vx; vy; contact; deposited]
```

Where:
- `x, y` – particle position
- `vx, vy` – velocity components
- `contact` – surface contact flag
- `deposited` – irreversible absorbing state

Once `deposited = 1`, the particle is permanently attached and no longer evolves.

---

## Continuous Particle Dynamics

Between surface interactions, particles evolve under:
- gravity
- linear drag relative to the fluid velocity
- tangential friction during surface contact

Implemented in:

```
particleDynamics.m
```

Deposited particles enter a terminal state with zero dynamics.

---

## Control Architecture

In Part 4, the fluid velocity is no longer prescribed. Instead, it is generated
by a control law:

```
u_fluid = [u_x(t); u_y(t)]
```

The control strategy is selected using:

```
params.controlMode ∈ {"openloop", "P", "PI", "PID"}
```

Switching logic is implemented in:

```
runSimulation.m
```

This enables direct comparison of multiple controllers under identical physics.

---

## Control Modes

### Open-Loop Control

Prescribed time-dependent flow without feedback.

Characteristics:
- No state awareness
- Sensitive to disturbances
- Baseline reference behavior

Implemented in:

```
openLoopFlow.m
```

---

### Proportional (P) Control

```
u_x = Kp (x_target − x)
```

Characteristics:
- Fast response
- Steady-state offset
- Limited robustness near capture

Implemented in:

```
P_controller.m
```

---

### Proportional–Integral (PI) Control

Adds accumulated position error over time.

Characteristics:
- Reduces steady-state error
- May introduce oscillations
- Requires anti-windup logic

Implemented in:

```
PI_controller.m
```

---

### Proportional–Integral–Derivative (PID) Control

Includes derivative damping based on particle velocity:

```
d/dt(x_target − x) = −vx
```

Characteristics:
- Improved damping
- Reduced oscillations
- Most robust control behavior

Implemented in:

```
PID_controller.m
```

---

## Spatially Varying Adhesion (Targeted Capture)

Adhesion energy varies spatially along the surface:

- **Low adhesion** in the transport region
- **High adhesion** near the target location

```
E_adh = E_adh(x)
```

Implemented in:

```
adhesionProfile.m
```

This enables free transport followed by selective irreversible capture.

---

## Probabilistic Energy-Based Deposition

Deposition is modeled probabilistically based on impact energy:

```
p = exp(−E_n / E_adh(x))
```

Key properties:
- Stochastic deposition
- Tolerance-based capture
- Physically realistic variability

---

## Disturbance Modeling

Optional **time-correlated flow disturbances** are introduced to increase realism.

Disturbances are modeled using an Ornstein–Uhlenbeck process:
- Finite correlation time
- Smooth temporal fluctuations
- Realistic uncertainty

Implemented in:

```
coloredDisturbance.m
```

---

## Hybrid Dynamical System Perspective

The system combines:
- Continuous particle dynamics
- Discrete surface interaction events
- Stochastic deposition
- Absorbing terminal states
- Feedback control loops

This forms a **controlled hybrid stochastic dynamical system**.

---

## Visualization & Controller Comparison

Each control mode is visualized using a standardized **2×2 subplot layout**:

1. Particle trajectory (x–y)
2. Horizontal velocity vs time
3. Horizontal position vs time (with target)
4. Deposition event timeline

Automated comparison is implemented in:

```
compare_controllers.m
```

---

## Key Observations

- P and PI controllers behave similarly for short transport durations
- Integral action has limited influence when capture occurs early
- Derivative action significantly improves damping
- Control guides transport, but adhesion determines capture
- Spatial adhesion enables realistic tolerance-based deposition

---

## Applications

- Aerosol targeting and filtration
- Microfluidic trapping
- Contamination control
- Surface patterning
- Controlled particulate transport

---

## Status

Part 4 completes the integration of:
- Feedback flow control
- Spatial adhesion modeling
- Probabilistic deposition
- Disturbance robustness
- Controller comparison

The framework is now ready for **Part 5: Multi-Particle and Chaotic Transport**.
