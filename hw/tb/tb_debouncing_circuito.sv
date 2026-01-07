`timescale 1ns/1ps

module tb_debouncing_circuito;
// Signals
logic clk_i = 0;
logic sw_i;
logic rst_i;
//logic m_tick_i;
logic db_o;

// Instantiate module under test
deboucing_circuito dut (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .sw_i(sw_i),
   // .m_tick_i(m_tick_i),
    .db_o(db_o)

);

// Clock generation
localparam time CLK_PERIOD= 10ns;

always #(CLK_PERIOD/2) clk_i = ~clk_i;


//Monitor for Synopsys

initial begin
        $display ("=== Iniciando simulacion ===");
        $monitor("t=%0t  clk=%b  rst=%b  sw=%b  m_tick=%b  salida=%b estado =%s", $time, clk_i, rst_i, sw_i, dut.m_tick_i, db_o, dut.state);
end
initial begin
    rst_i = 1;
    sw_i = 0;
    #50;
    rst_i = 0;

end
initial begin
  
  #100 
    // Rebote al presionar
    sw_i = 1; #20;
    sw_i = 0; #20;
    sw_i = 1; #20;
    sw_i = 0; #20;
    sw_i = 1;

    // Esperar varios ticks (~3 × 160 ns)
    #600;

    // Rebote al soltar
    sw_i = 0; #20;
    sw_i = 1; #20;
    sw_i = 0; #20;
    sw_i = 1; #20;
    sw_i = 0; #20;
    sw_i = 1; #20;

    sw_i = 1;

    #600;
    sw_i = 0; #20;
    sw_i = 1; #20;


    $display("=== Fin de simulación ===");
    $finish;


end

    initial begin
                $timeformat(-9, 1, "ns", 10);
        $fsdbDumpvars;
    end

// initial begin
//     rst_i = 1;
//     sw_i = 0;
//     m_tick_i = 0;
//     #20;

//     rst_i = 0;
//     #10;

//     sw_i = 1; // Presiono el switch
//     #15;

//     m_tick_i = 1; // Primer tick del oscilador de debounce
//     #10;
//     m_tick_i = 0;
//     #10;

//     m_tick_i = 1; // Segundo tick del oscilador de debounce
//     #10;
//     m_tick_i = 0;
//     #10;

//     m_tick_i = 1; // Tercer tick del oscilador de debounce
//     #10;
//     m_tick_i = 0;
//     #10;

//     sw_i = 0; // Suelto el switch
//     #15;

//     m_tick_i = 1; // Primer tick del oscilador de debounce
//     #10;
//     m_tick_i = 0;
//     #10;

//     m_tick_i = 1; // Segundo tick del oscilador de debounce
//     #10;
//     m_tick_i = 0;
//     #10;

//     m_tick_i = 1; // Tercer tick del oscilador de debounce
//     #10;
//     m_tick_i = 0;
//     #10;

//     sw_i = 1; // Presiono el switch
//     #5;

//     m_tick_i = 1; // Primer tick del oscilador de debounce
//     #10;
//     m_tick_i = 0;
//     #10;

//     sw_i = 0; // desactivamos el switch
//     #10;

//     $display("=== Fin de simulación ===");
//     $finish;
// end




endmodule: tb_debouncing_circuito