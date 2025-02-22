# Graphics Controller for FPGA DE10-Nano Video Display

## Project Overview
This macro project, conducted during the second year of engineering studies at **Télécom Paris**, involves designing a **graphics controller architecture** to enable video display on the **DE10-Nano FPGA board**. The system features a custom Avalon-MM-compliant interconnect, arbitration logic for SDRAM access, and a VGA output pipeline. Developed entirely in **SystemVerilog**, the project includes a complete simulation and synthesis environment. The work was completed in collaboration with **Souhail AIT FORA**.

## Key Features
- **Avalon-MM Interconnect**: Manages shared access to SDRAM between the VGA module and a processor.
- **Arbitration Logic**: Implements priority-based for conflict-free SDRAM access.
- **VGA Display Pipeline**: Generates RGB signals with timing control (HSYNC, VSYNC) for standard resolutions (e.g., 640x480 @ 60Hz).
- **Dual FIFO Buffering**:
  - **SDRAM-to-VGA FIFO**: Ensures continuous pixel data flow to the VGA controller.
  - **Processor-to-SDRAM **:  initialization data from the processor to SDRAM.
- **SDRAM Initialization**: Configures SDRAM timing parameters (refresh cycles, burst length) via a processor interface.

## Implementation Details
### Architecture Overview

1. **Avalon-MM Interconnect**:
   - Implements Avalon-MM signals (`read`, `write`, `address`, `burstcount`).
   - Supports pipelined read/write operations for latency hiding.

2. **Arbitration Logic**:
   - Prioritizes VGA controller access to prevent screen tearing.
   - Grants processor access during VGA blanking intervals.

3. **SDRAM Controller**:
   - Manages row/column addressing, refresh cycles, and precharge operations.
   - Converts Avalon-MM transactions to SDRAM commands.

4. **VGA Module**:
   - **Timing Generator**: Syncs HSYNC/VSYNC signals to VESA standards.
   - **FIFO Manager**: Pre-fetches pixel data from SDRAM during horizontal/vertical blanking periods.

5. **Processor Integration**:
   - Initializes SDRAM with test patterns or external data.
   - Monitors FIFO status (full/empty thresholds) via memory-mapped registers.

### SystemVerilog Implementation
- **Verification**:
  - Questa Simulator testbenches for functional and timing checks.
  - Implimentation on FPGA, the DE10-Nano development board is equipped with high-speed DDR3 memory.

## Team
- **Souhail AIT FORA**  
- **AGOUZAL SAID**  
