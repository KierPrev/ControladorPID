## Temperature Control Using a PID (Proportional, Integral, and Derivative Controller)

Castillo Josefina, Preve E. Kiernan

National University of San Luis

### Abstract

In industrial applications, it is necessary to maintain tempered chocolate at its working temperature.

A potential solution for this problem is a PID controller, which calculates an error value as the difference between a measured point and a desired point and attempts to minimize this error in its output. The goal is for the output to adjust to its setpoint (reference value we aim to reach).

For this experiment, 400 grams of semi-dark chocolate were used. Depending on the purity level, each type of chocolate will have different melting points; in this case, it ranges between 45°-50°C.

Liquid chocolate at 32°C has a specific heat of 0.56 kcal/kg°C, while solid chocolate has a specific heat of 0.30 kcal/kg°C [1].

### Other Use Cases for a PID

This type of controller can be used in a wide variety of applications, such as:

- Rocket stabilization during the launch phase.
- Mobility control of a space exploration vehicle (Rover).
- Implementation of cruise control in an automobile.

### Modeling

The PID sensor comprises three components: proportional, integral, and derivative signals.

- **Proportional (P):** Increases exponentially to reach the setpoint, focusing on a precise measurement value (the one currently being measured). It consists of the product of the measurement error and a constant \( K_p \).  
- **Integral (I):** Checks the accumulated error over time (i.e., focuses on errors from previous measurements) and updates the current component. This reduces and eliminates the steady-state error caused by external disturbances, which cannot be corrected by proportional control alone. It also depends on a constant \( K_i \).  
- **Derivative (D):** Focuses on future measurement errors. The derivative action aims to keep the error at a minimum by correcting it proportionally to its rate of change. This prevents the error from increasing and avoids values exceeding the setpoint. When the derivative action time is large, instability occurs. When it is small, the variable oscillates excessively around the setpoint. [3]

The output is the sum of these three signals.  
This characterizes a delay time used to control the on/off state of the resistors, as given by the equation:  

error = Tset-T(t)

tretardo = Kp [e + Ki(Iprev + e(t-tprev)) + Kd (e-eprev)/(t-tprev)]


![fig1](fig1.jpg)

**Figure 1:** Components of the PID sensor signal

### Experimental Setup

A makeshift stove was assembled using refractory bricks and three resistors functioning as a single unit, dissipating 270 W. Due to the specific configuration of this system, where resistors are turned on in an enclosed space, the heat storage in the bricks makes it harder to lower the temperature. As a result, the final temperature may exceed the initial setpoint.  

![fig2](fig2.jpg)

The chocolate is heated in a savarin mold, with the resistors placed beneath it and powered by a 220 V current (Figure 2). The goal, in conjunction with the PID sensor, is to maintain the base temperature stable at 45°C.

### Results

![fig3](fig3.jpg)

In **Figure 3**, certain inhomogeneities can be observed in the container. These must be considered during measurement since different base points do not reach the same temperature simultaneously. However, the chocolate, which will cover the entire bottom, smooths these irregularities by distributing the heat evenly. Additionally, the thermometer visible in the image features insulating glue, which dissipates heat much slower than the metallic surface, conserving it for a longer time. This generates a delay between the chocolate’s temperature and the sensor reading.

![fig4](fig4.jpg)

**Figure 4**

Due to the refractory brick beneath the resistors, the final temperature of the chocolate was two degrees higher than the setpoint. This ceramic material has low thermal conductivity, retaining some heat for a considerable time.

This PID was configured to control the savarin mold’s base temperature, where a thermometer was placed to provide control values. Another thermometer recorded the temperature beneath the container, near the resistors (Figure 4).  

Temperature stability at the setpoint was achieved in approximately 40 minutes, with a thermal difference between the two sensors of \( (6.15 \pm 0.5)^\circ C \) (Figure 5).  

![fig5](fig5.jpg)

**Figure 5**

### Conclusion

It is feasible to control a system’s temperature using only resistors, sensors, and an Arduino board programmed with a PID code written by the team. This setup can reach and maintain a desired temperature over time.  

Careful selection of suitable materials is crucial, especially the surface on which the controlled system rests, as well as the ambient temperature. If the latter is too close to the setpoint, the control system's stability might degrade.

### References

[1] Rudolf Plank, *“The Use of Cooling in the Food Industry,”* Section “Chocolate and Sweets,” Chapter IV.  
[2] Wikipedia, *“PID Controller”*  
[3] *“Temperature Controller User Manual,”* Model 331, Lake Shore Cryotronics, Inc.

#### Appendix

Tim Wescott, *“PID without a PhD”*
