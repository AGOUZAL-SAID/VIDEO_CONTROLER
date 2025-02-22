`timescale 1ns/10ps

// Avalon memory mapped 
interface avl_if 
#(
    parameter ADDR_WIDTH=32,
    parameter DATA_BYTES=4
); 
    logic                    waitrequest;
    logic   [ADDR_WIDTH-1:0] address;
    logic                    read;
    logic                    write;
    logic [DATA_BYTES*8-1:0] writedata;
    logic   [DATA_BYTES-1:0] byteenable;
    logic              [7:0] burstcount;
    logic                    readdatavalid;
    logic [DATA_BYTES*8-1:0] readdata;

  modport master
  (
    input  waitrequest,

    output address,
    output read,
    output write,
    output writedata,
    output byteenable,
    output burstcount,

    input  readdatavalid,
    input  readdata
  ) ;

  modport slave
  (
    output waitrequest,

    input  address,
    input  read,
    input  write,
    input  writedata,
    input  byteenable,
    input  burstcount,

    output readdatavalid,
    output readdata
  ) ;

endinterface

