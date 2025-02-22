// YM/TPT
// Avalon MM bus modelized via an "interface"
// 3 modports are defined:
// host    : host interface (for hardware synthesis)
// agent   : agent  interface (for hardware synthesis)
// monitor : interface for protocol analysis
//  The default parameters are for a purely RTL interface definition
//  The interface is a 4 bytes data / 32 bits addresses interface

`timescale 1ns/10ps

interface avalon_if #(parameter DATA_BYTES=4, BURSTCOUNT_W=6) (input logic clk, input logic reset);
  logic  [31:0]   address;
  logic  [DATA_BYTES-1:0]  byteenable;
  logic  read;
  logic  write;
  logic  [8*DATA_BYTES-1:0] readdata;
  logic  [8*DATA_BYTES-1:0] writedata;
  logic  waitrequest;
  logic  readdatavalid;
  logic  [BURSTCOUNT_W-1:0]   burstcount;

  //////////////// RTL Masters and agents modports ///////////////////

  // Modport for host RTL
  modport host (
    input  clk,
    input  reset,
    output address,
    output byteenable,
    output read,
    output write,
    output writedata,
    output burstcount,
    input  readdata,
    input  waitrequest,
    input  readdatavalid
  );

  // Modport for agent RTL
  modport agent (
    input  clk,
    input  reset,
    input  address,
    input  byteenable,
    input  read,
    input  write,
    input  writedata,
    input  burstcount,
    output readdata,
    output waitrequest,
    output readdatavalid
  );
  // Modport for monitoring
  modport monitor (
    input  clk,
    input  reset,
    input  address,
    input  byteenable,
    input  read,
    input  write,
    input  writedata,
    input  burstcount,
    input  readdata,
    input  waitrequest,
    input  readdatavalid
  );
  //////////////// End of RTL Masters and agents modports ////////////

endinterface

