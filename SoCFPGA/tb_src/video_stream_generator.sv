module video_stream_generator
(
    input logic clk,
    input logic reset,
    avalon_stream_if.host avalon_stream_ifh
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/

localparam DW                       = 23;
localparam WW                       = 8;
localparam HW                       = 7;

localparam WIDTH                    = 160;
localparam HEIGHT                   = 90;

localparam VALUE                    = 8'd160;
localparam P_RATE                   = 24'd116508;
localparam TQ_START_RATE            = 25'd393216;
localparam TQ_RATE_DECELERATION     = 25'd4369;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires

wire            [ 7: 0]    red;
wire            [ 7: 0]    green;
wire            [ 7: 0]    blue;

// Internal Registers
logic            [WW: 0]    x;
logic            [HW: 0]    y;

logic            [10: 0]    hue;
logic            [ 2: 0]    hue_i;

logic            [23: 0]    p;
logic            [24: 0]    q;
logic            [24: 0]    t;

logic            [24: 0]    rate;

logic valid ;
logic in_data_packet ;
logic in_ctrl_packet ;

assign valid_data = valid && in_data_packet ;
assign valid_ctrl = valid && in_ctrl_packet ;

/*****************************************************************************
 *                            Sequential Logic                               *
 *****************************************************************************/

// Color Space Conversion from HSV to RGB
//
// HSV - Hue, Saturation, and Value
//
// Hue            - 0 to 360
// Saturation    - 0 to 1
// Value        - 0 to 1
//
// h_i    = floor (h / 60) mod 6
// f    = (h / 60) - floor (h / 60)
// p    = v * (1 - s)
// q    = v * (1 - f * s)
// t    = v * (1 - (1 - f) * s)
//
//       { (v, t, p) if h_i = 0
//       { (q, v, p) if h_i = 1
// RGB = { (p, v, t) if h_i = 2
//       { (p, q, v) if h_i = 3
//       { (t, p, v) if h_i = 4
//       { (v, p, q) if h_i = 5
//
// Source: http://en.wikipedia.org/wiki/HSL_color_space#Conversion_from_HSV_to_RGB
//

// Internal Registers
always_ff @(posedge clk)
begin
    if (reset)
        x <= WIDTH-1;
    else if (valid_data)
    begin
        if (x == (WIDTH - 1))
            x <= 'h0;
        else
            x <= x + 1'b1;
    end
end

always_ff @(posedge clk)
begin
    if (reset)
        y <= HEIGHT-1;
    else if (valid_data && (x == (WIDTH - 1)))
      begin
          if (y == (HEIGHT - 1))
              y <= 'h0;
          else
              y <= y + 1'b1;
      end
end

always_ff @(posedge clk)
begin
    if (reset)
    begin
        hue    <= 'h0;
        hue_i    <= 'h0;
    end
    else if (valid_data)
    begin
        if (x == (WIDTH - 1))
        begin
            hue    <= 'h0;
            hue_i    <= 'h0;
        end
        else if (hue == ((WIDTH / 6) - 1))
        begin
            hue    <= 'h0;
            hue_i    <= hue_i + 1'b1;
        end
        else
            hue    <= hue + 1'b1;
    end
end

always_ff @(posedge clk)
begin
    if (reset)
    begin
        p        <= 'h0;
        q        <= {1'b0, VALUE, 16'h0000};
        t        <= 'h0;
        rate    <= TQ_START_RATE;
    end
    else if (valid_data)
    begin
        if ((x == (WIDTH - 1)) && (y == (HEIGHT - 1)))
        begin
            p       <= 'h0;
            rate    <= TQ_START_RATE;
        end
        else if (x == (WIDTH - 1))
        begin
            p        <= p + P_RATE;
            rate    <= rate - TQ_RATE_DECELERATION;
        end

        if ((x == (WIDTH - 1)) && (y == (HEIGHT - 1)))
        begin
            q        <= {1'b0, VALUE, 16'h0000};
            t        <= 'h0;
        end
        else if (x == (WIDTH - 1))
        begin
            q        <= {1'b0, VALUE, 16'h0000};
            t        <= p + P_RATE;
        end
        else if ((hue == ((WIDTH / 6) - 1)) && (hue_i != 5))
        begin
            q        <= {1'b0, VALUE, 16'h0000};
            t        <= p;
        end
        else
        begin
            q        <= q - rate;
            t        <= t + rate;
        end


    end
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/


// Internal Assignments
assign red =
        (hue_i == 0) ?    VALUE :
        (hue_i == 1) ?    q[23:16] & {8{~q[24]}}: // 8'h00 :
        (hue_i == 2) ?    p[23:16] :
        (hue_i == 3) ?    p[23:16] :
        (hue_i == 4) ?    t[23:16] | {8{t[24]}} : // 8'h00 :
                        VALUE;

assign green =
        (hue_i == 0) ?    t[23:16] | {8{t[24]}} : // 8'h00 :
        (hue_i == 1) ?    VALUE :
        (hue_i == 2) ?    VALUE :
        (hue_i == 3) ?    q[23:16] & {8{~q[24]}} : // 8'h00 :
        (hue_i == 4) ?    p[23:16] :
                          p[23:16];
assign blue =
        (hue_i == 0) ?    p[23:16] :
        (hue_i == 1) ?    p[23:16] :
        (hue_i == 2) ?    t[23:16] | {8{t[24]}} : // 8'h00 :
        (hue_i == 3) ?    VALUE :
        (hue_i == 4) ?    VALUE :
                        q[23:16] & {8{~q[24]}}; // 8'h00;

/*****************************************************************************
 *                             Sequence de stall
 *****************************************************************************/
localparam BCOUNT=20 ;
localparam SCOUNT=3 ;
logic [5:0] bcount ;
logic [5:0] scount ;
logic stall ;

assign  valid = !stall && avalon_stream_ifh.ready ;

always_ff @(posedge clk)
begin
    if (reset) begin
        stall <= 1'b0;
        scount <= SCOUNT ;
        bcount <= BCOUNT ;
    end
    else
    begin
        if (valid && avalon_stream_ifh.ready && bcount > 0) bcount <= bcount - 1 ;
        if (bcount == 0) begin
             scount <= scount -1  ;
             stall <= 1'b1 ;
        end
        if (scount == 0) begin
            bcount <= BCOUNT ;
            scount <= SCOUNT ;
            stall <= 1'b0 ;
        end
    end
end


// Génération du paquet de contrôle
logic [31:0] ctrl_data ;
bit sop, eop;

initial begin
     in_ctrl_packet = 1'b0 ;
     in_data_packet = 1'b0 ;
     ctrl_data = 'x ;
     @(posedge reset);
     @(negedge reset);
     forever begin:loop
        @(posedge clk) ; while (!valid) @(posedge clk) ;
        in_ctrl_packet = 1'b1 ;
        sop=1;
        ctrl_data = 32'h0000000F ;
        @(posedge clk) ; while (!valid) @(posedge clk) ;
        sop=0;
        ctrl_data = 32'h11111111 ;
        @(posedge clk) ; while (!valid) @(posedge clk) ;
        ctrl_data = 32'h22222222 ;
        @(posedge clk) ; while (!valid) @(posedge clk) ;
        ctrl_data = 32'h33333333 ;
        eop=1 ;
        @(posedge clk) ; while (!valid) @(posedge clk) ;
        eop=0 ;
        sop=1 ;
        ctrl_data = 32'h44444440 ;
        @(posedge clk) ; while (!valid) @(posedge clk) ;
        in_ctrl_packet = 1'b0 ;
        in_data_packet = 1'b1 ;
        sop=0 ;
        @(avalon_stream_ifh.endofpacket) ;
        in_data_packet = 1'b0 ;
     end
end

logic r_valid_data ;
always @(posedge clk) begin
    r_valid_data <= valid_data ;
end

// Outputs
assign    avalon_stream_ifh.valid = r_valid_data || valid_ctrl ;
assign    avalon_stream_ifh.startofpacket = (valid_ctrl && sop) ;
assign    avalon_stream_ifh.endofpacket   = (r_valid_data && (x==WIDTH-1) && (y==HEIGHT-1)) || (valid_ctrl && eop) ;
assign    avalon_stream_ifh.data = r_valid_data ? { 8'h0, red, green, blue } : valid_ctrl ? ctrl_data : 'x ;
//assign    avalon_stream_ifh.data = r_valid_data ?  10000*y+x  : valid_ctrl ? ctrl_data : 'x ;

endmodule

