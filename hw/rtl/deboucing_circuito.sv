// design deboucing circuito usign 3 always blocks
// First always block for state register
// Second always block for next and state logic
// Third always block for output logic 
`timescale 1ns/1ps

module deboucing_circuito (
    input logic clk_i,
    input logic rst_i,
    input logic sw_i,
   // input logic m_tick_i,
    output logic db_o
);
// Parameters for tick counter
localparam N= 2;
logic [N-1:0] q_reg;
logic [N-1:0] q_next;
logic m_tick_i;


import fsm_debou_pkg::*; // import the package that we created, where contains the states
state_e state, next; // variables of type state_e of the package

// First always block: state register
always_ff @(posedge clk_i or posedge rst_i) begin
   if (rst_i) 
        state <= ZERO; // initial state
    else
        state <= next; // update state 
end

// Second always block: next state logic

always_comb begin
next = XXX; // default value

    case(state)
        ZERO:       
                    if      (sw_i)                      next = WAIT1_1;
                    else                                next = ZERO;
        WAIT1_1:    
                    if      (sw_i && !m_tick_i) begin   next = WAIT1_1; end
                    else if (sw_i && m_tick_i)  begin   next = WAIT1_2; end
                    else if (!sw_i)             begin   next = ZERO;    end

        WAIT1_2:    
                    if      (sw_i && !m_tick_i) begin   next = WAIT1_2; end
                    else if (sw_i && m_tick_i)  begin   next = WAIT1_3; end
                    else if (!sw_i)             begin   next = ZERO;    end
        WAIT1_3:
                    if      (sw_i && !m_tick_i) begin   next = WAIT1_3; end
                    else if (sw_i && m_tick_i)  begin   next = ONE;     end
                    else if (!sw_i)             begin   next = ZERO;    end
        ONE:
                    if      (sw_i)              begin   next = ONE; end
                    else                                next = WAIT0_1;
        WAIT0_1: 
                    if      (!sw_i && !m_tick_i)begin   next = WAIT0_1; end
                    else if (!sw_i && m_tick_i) begin   next = WAIT0_2; end
                    else if (sw_i)              begin   next = ONE;     end
        WAIT0_2:
                    if      (!sw_i && !m_tick_i)begin   next = WAIT0_2; end
                    else if (!sw_i && m_tick_i) begin   next = WAIT0_3; end
                    else if (sw_i)              begin   next = ONE;     end
        WAIT0_3: 
                    if      (!sw_i && !m_tick_i)begin   next = WAIT0_3; end
                    else if (!sw_i && m_tick_i) begin   next = ZERO;    end
                    else if (sw_i)              begin   next = ONE;     end 

        default: next = XXX;
    endcase
end

// Third always block: output logic state

always_ff @(posedge clk_i or posedge rst_i)begin
 if(rst_i) begin
    db_o <= 1'b0;
 end
else begin 
    db_o <= 1'b0;
    case(state)
        ZERO: ;
        WAIT1_1: ;
        WAIT1_2: ;
        WAIT1_3: ;
        ONE: db_o <= 1'b1;
        WAIT0_1: db_o <= 1'b1;
        WAIT0_2: db_o <= 1'b1;
        WAIT0_3: db_o <= 1'b1;
        default : db_o <= 1'b0;
    endcase
end
end
// tick counter to generate "x" ms tick 

always_ff @(posedge clk_i or posedge rst_i) begin
if(rst_i)
    q_reg <= '0;
else 
    q_reg <= q_next;
end

assign q_next = q_reg + 1;
assign m_tick_i = (q_reg == 0) ? 1'b1 : 1'b0;
endmodule: deboucing_circuito