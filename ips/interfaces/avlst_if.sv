`timescale 1ns/10ps

// Avalon stream
interface avlst_if
    #(
        parameter ADDR_WIDTH=32,
        parameter DATA_BYTES=4
    );

    logic                    ready;
    logic                    valid;
    logic [DATA_BYTES*8-1:0] data;
    logic                    startofpacket;
    logic                    endofpacket;

  modport master (
    output valid,
    input  ready,
    output data,
    output startofpacket,
    output endofpacket
  ) ;

  modport slave (
    input  valid,
    output ready,
    input  data,
    input  startofpacket,
    input  endofpacket
  ) ;

endinterface

