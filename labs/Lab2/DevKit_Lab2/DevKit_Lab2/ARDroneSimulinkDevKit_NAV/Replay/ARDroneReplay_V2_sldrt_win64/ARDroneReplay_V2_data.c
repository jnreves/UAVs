/*
 * ARDroneReplay_V2_data.c
 *
 * Sponsored License - for use in support of a program or activity
 * sponsored by MathWorks.  Not for government, commercial or other
 * non-sponsored organizational use.
 *
 * Code generation for model "ARDroneReplay_V2".
 *
 * Model version              : $Id: UAV_PIL.mdl 965 2013-03-21 01:08:53Z escobar $
 * Simulink Coder version : 9.3 (R2020a) 18-Nov-2019
 * C source code generated on : Sat Apr 24 15:17:38 2021
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "ARDroneReplay_V2.h"
#include "ARDroneReplay_V2_private.h"

/* Block parameters (default storage) */
P_ARDroneReplay_V2_T ARDroneReplay_V2_P = {
  /* Expression: 0
   * Referenced by: '<S55>/L*(y[k]-yhat[k|k-1])'
   */
  0.0,

  /* Expression: [0 0]
   * Referenced by: '<S57>/Constant1'
   */
  { 0.0, 0.0 },

  /* Expression: pi/180
   * Referenced by: '<Root>/deg 2 rad'
   */
  0.017453292519943295,

  /* Expression: 180/pi
   * Referenced by: '<S4>/deg 2 rad1'
   */
  57.295779513082323,

  /* Expression: pInitialization.A
   * Referenced by: '<S2>/A'
   */
  0.0,

  /* Expression: pInitialization.B
   * Referenced by: '<S2>/B'
   */
  1.0,

  /* Expression: pInitialization.C
   * Referenced by: '<S2>/C'
   */
  1.0,

  /* Expression: pInitialization.L
   * Referenced by: '<S6>/KalmanGainL'
   */
  0.22360679774997896,

  /* Expression: pInitialization.D
   * Referenced by: '<S2>/D'
   */
  0.0,

  /* Expression: pInitialization.X0
   * Referenced by: '<S2>/X0'
   */
  0.0,

  /* Expression: true()
   * Referenced by: '<S2>/Enable'
   */
  1
};
