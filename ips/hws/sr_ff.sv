
// # Description : A Set/Resetflip-flop used as a a shared signal
//                 between 2 fsms                                

`default_nettype none
module sr_ff
(
    input wire clk,
    input wire reset,
    input wire set,
    input wire rst,
    output logic state
);

logic r_state = 1'b0;

always_ff @(posedge clk)
if(reset)
    r_state <= 1'b0;
else
    r_state <= (r_state && rst) || (!r_state && !set) ? 1'b0 : ((r_state && !rst) || (!r_state && set) ? 1'b1 : r_state); 

assign state = r_state;

endmodule
`default_nettype wire
