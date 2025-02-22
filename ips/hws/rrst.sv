`default_nettype none
module rrst
#(
    parameter ACTIVE_HIGH = 1'b0 // Default : Active low
)
(
    input  wire  clk, 
    input  wire  rst_in,
    output logic rst_out
);

logic rff1;
logic rst_sync;

 assign rst_out = ACTIVE_HIGH ? !rst_sync : rst_sync;

 always_ff @(posedge clk or negedge rst_in)
 if (!rst_in)
 begin
     rst_sync <= 1'b0;
     rff1    <= 1'b0;
 end
 else 
 begin
     rst_sync <= rff1;
     rff1     <= 1'b1;
 end

endmodule
`default_nettype wire

