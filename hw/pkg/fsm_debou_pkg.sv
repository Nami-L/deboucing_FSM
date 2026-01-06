`timescale 1ns/1ps
package fsm_debou_pkg;
// Define the state for the debouncing fsm_debou_pkg
typedef enum{
    ZERO,
    WAIT1_1,
    WAIT1_2,
    WAIT1_3,
    ONE,
    WAIT0_1,
    WAIT0_2,
    WAIT0_3,
    XXX     // undefined state
} state_e;

    
endpackage