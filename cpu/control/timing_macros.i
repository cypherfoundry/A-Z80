//=========================================================================================
// This file contains substitute strings for macros used in the Excel timing table and
// is read and processed by genmatrix.py script to generate exec_matrix.i include file.
//
// Format of the file:
//
// * Each key is prefixed by ':' and corresponds to a spreadsheet column name.
// * A column (key) contains a number of macros, each starting at its own line.
// * A macro may span multiple lines, in which case use the '\' character after the name to
//   continue on the next line.
// * Multiline macros end when a line does not _start_ with a space character.
// Also, //-style comments are wrapped into /* ... */ if they don't start a line.
//=========================================================================================

//-----------------------------------------------------------------------------------------
:Function
//-----------------------------------------------------------------------------------------
fMFetch         fFetch=1;
fMRead          fMRead=1;
fMWrite         fMWrite=1;
fIORead         fIORead=1;
fIOWrite        fIOWrite=1;

//-----------------------------------------------------------------------------------------
// Basic timing control
//-----------------------------------------------------------------------------------------
:contM1
1               contM1=1;
:contM2
1               contM2=1;
:nextM
1               nextM=1;
CC              nextM=!flags_cond_true;
:setM1
1               setM1=1;
SS              ctl_cond_short=1; setM1=!flags_cond_true;
CC              setM1=!flags_cond_true;
E               setM1=flags_zf;

//-----------------------------------------------------------------------------------------
// Register file, address (downstream) endpoint
//-----------------------------------------------------------------------------------------
:A:reg rd
// General purpose registers
r16     ctl_reg_gp_sel=op54; ctl_reg_gp_hilo=2'b11; ctl_sw_4d=1;    // Read 16-bit general purpose register, enable SW4 downstream
HL      ctl_reg_gp_sel=`GP_REG_HL; ctl_reg_gp_hilo=2'b11; ctl_sw_4d=1;// Read 16-bit HL, enable SW4 downstream
SP      ctl_reg_use_sp=1; ctl_reg_gp_sel=`GP_REG_AF; ctl_reg_gp_hilo=2'b11; ctl_sw_4d=1;// Read 16-bit SP, enable SW4 downstream

// System registers
WZ      ctl_reg_sel_wz=1; ctl_reg_sys_hilo=2'b11;                   // Select 16-bit WZ
IR      ctl_reg_sel_ir=1; ctl_reg_sys_hilo=2'b11;                   // Select 16-bit IR
PC      ctl_reg_sel_pc=1; ctl_reg_sys_hilo=2'b11;                   // Select 16-bit PC

// Conditional assertions of WZ, HL instead of PC
WZ!     ctl_reg_not_pc=1; ctl_reg_sel_wz=1; ctl_reg_sys_hilo=2'b11; ctl_sw_4d=1; // Use WZ instead of PC (for jumps)
WZ? \
    if (flags_cond_true) begin      // If cc is true, use WZ instead of PC (for jumps)
        ctl_reg_not_pc=1; ctl_reg_sel_wz=1; ctl_reg_sys_hilo=2'b11; ctl_sw_4d=1;
    end

HL!     ctl_reg_not_pc=1; ctl_reg_gp_sel=`GP_REG_HL; ctl_reg_gp_hilo=2'b11; ctl_sw_4d=1; // Use HL, enable SW4 downstream (for jumps)

:A:reg wr
// General purpose registers
r16     ctl_reg_gp_we=1; ctl_reg_gp_sel=op54; ctl_reg_gp_hilo=2'b11; ctl_sw_4u=1; // Write 16-bit general purpose register, enable SW4 upstream
HL      ctl_reg_gp_we=1; ctl_reg_gp_sel=`GP_REG_HL; ctl_reg_gp_hilo=2'b11; ctl_sw_4u=1; // Write 16-bit HL, enable SW4 upstream
SP      ctl_reg_gp_we=1; ctl_reg_gp_sel=`GP_REG_AF; ctl_reg_gp_hilo=2'b11; ctl_reg_use_sp=1; ctl_sw_4u=1; // Write 16-bit SP, enable SW4 upstream
// System registers
WZ      ctl_reg_sys_we=1; ctl_reg_sel_wz=1; ctl_reg_sys_hilo=2'b11; // Write 16-bit WZ
IR      ctl_reg_sys_we=1; ctl_reg_sel_ir=1; ctl_reg_sys_hilo=2'b11; // Write 16-bit IR
PC      ctl_reg_sys_we=1; ctl_reg_sel_pc=1; ctl_reg_sys_hilo=2'b11; // Write 16-bit PC

//-----------------------------------------------------------------------------------------
// Controls the address latch incrementer
//-----------------------------------------------------------------------------------------
:inc/dec
-       ctl_inc_dec=1;                      // Decrement address latch!
R       ctl_bus_inc_we=1;                   // Output enable incrementer latch to the abus
W       ctl_al_we=1;                        // Write a value from the abus to the address latch
R-      ctl_bus_inc_we=1; ctl_inc_dec=1;    // Decrement address latch and output it to abus
+/-     ctl_bus_inc_we=1; ctl_inc_dec=op3;  // Used for INC/DEC: decrement if op3 is set

//-----------------------------------------------------------------------------------------
// Register file, data (upstream) endpoint
//-----------------------------------------------------------------------------------------
:D:reg rd
// General purpose registers
A       ctl_reg_gp_sel=`GP_REG_AF; ctl_reg_gp_hilo=2'b10;
AF      ctl_reg_gp_sel=`GP_REG_AF; ctl_reg_gp_hilo=2'b11;
r8      ctl_reg_gp_sel=op54; ctl_reg_gp_hilo={!op3,op3}; // Read 8-bit GP register
r8'     ctl_reg_gp_sel=op21; ctl_reg_gp_hilo={!op0,op0}; // Read 8-bit GP register selected by op[2:0]
rh      ctl_reg_gp_sel=op54; ctl_reg_gp_hilo=2'b10;      // Read 8-bit GP register high byte
rl      ctl_reg_gp_sel=op54; ctl_reg_gp_hilo=2'b01;      // Read 8-bit GP register low byte
// System registers
I/R     ctl_reg_sel_ir=1; ctl_reg_sys_hilo={!op3,op3};   // Read either I or R based on op3 (0 or 1)
P       ctl_reg_sel_pc=1; ctl_reg_sys_hilo=2'b10;
C       ctl_reg_sel_pc=1; ctl_reg_sys_hilo=2'b01;

:D:reg wr
// General purpose registers
A       ctl_reg_gp_we=1; ctl_reg_gp_sel=`GP_REG_AF; ctl_reg_gp_hilo=2'b10;
r8      ctl_reg_gp_we=1; ctl_reg_gp_sel=op54; ctl_reg_gp_hilo={!op3,op3}; // Write 8-bit GP register
rh      ctl_reg_gp_we=1; ctl_reg_gp_sel=op54; ctl_reg_gp_hilo=2'b10; // Write 8-bit GP register high byte
rl      ctl_reg_gp_we=1; ctl_reg_gp_sel=op54; ctl_reg_gp_hilo=2'b01; // Write 8-bit GP register low byte
// System registers
I/R     ctl_reg_sys_we=1; ctl_reg_sel_ir=1; ctl_reg_sys_hilo={!op3,op3}; // Write either I or R based on op3 (0 or 1)
W       ctl_reg_sys_we=1; ctl_reg_sel_wz=1; ctl_reg_sys_hilo=2'b10;
Z       ctl_reg_sys_we=1; ctl_reg_sel_wz=1; ctl_reg_sys_hilo=2'b01;

//-----------------------------------------------------------------------------------------
// Switches on the data bus for each direction (upstream, downstream)
//-----------------------------------------------------------------------------------------
:SW2
<       ctl_sw_2d=1;
>       ctl_sw_2u=1;
// This version of the SW2 upstream macro is conditioned by the register selection r8 (op3 bit)
// since it merges two 8-bit busses (Register File High with Low)
3>      ctl_sw_2u=!op3;

:SW1
<       ctl_sw_1d=1;
>       ctl_sw_1u=1;

//-----------------------------------------------------------------------------------------
// Data bus latches and pads control
//-----------------------------------------------------------------------------------------
:DB pads
R       ctl_bus_db_oe=1;                        // Read DB pads to internal data bus
W       ctl_bus_db_we=1;                        // Write DB pads with internal data bus value
00      ctl_bus_zero_oe=1;                      // Force 0x00 on the data bus
FF      ctl_bus_ff_oe=1;                        // Force 0xFF on the data bus

//-----------------------------------------------------------------------------------------
// ALU
//-----------------------------------------------------------------------------------------
:ALU oe
<       ctl_alu_oe=1;                           // Enable ALU onto the data bus
>

:ALU bus
// Controls who can write to the ALU internal bus
sh0     ctl_alu_shift_oe=1;                     // Shifter unit without shift-enable
sh1     ctl_alu_shift_oe=1; ctl_shift_en=1;     // Shifter unit AND shift enable!
op2     ctl_alu_op2_oe=1;                       // OP2 latch
res     ctl_alu_res_oe=1;                       // Result latch
op1     ctl_alu_op1_oe=1;                       // OP1 latch
bit     ctl_alu_bs_oe=1;                        // Bit-selector unit

:ALU:op1
// Controls a MUX to select the input to the OP1 latch
bus     ctl_alu_op1_sel_bus=1;                  // Internal bus
low     ctl_alu_op1_sel_low=1;                  // Write low nibble with a high nibble
0       ctl_alu_op1_sel_zero=1;                 // Zero

:ALU:op2
// Controls a MUX to select the input to the OP2 latch
bus     ctl_alu_op1_sel_bus=1;                  // Internal bus
x       ctl_alu_op1_sel_lq=1;                   // Cross-bus wire (see schematic)
0       ctl_alu_op1_sel_zero=1;                 // Zero

:ALU:phase
// ALU computational phase: low nibble or high nibble
// High phase (ctl_alu_op_low=0) is default and not needed to specify
l       ctl_alu_op_low=1;
h

//-----------------------------------------------------------------------------------------
// FLAGT
//-----------------------------------------------------------------------------------------
:FLAGT
<       ctl_flags_oe=1;                         // Enable FLAGT onto the data bus
>       ctl_flags_bus=1;                        // Load FLAGT from the data bus
A       ctl_flags_alu=1;                        // Load FLAGT from the ALU

// Write enables for various flag bits and segments
:SZ
*       ctl_flags_sz_we=1;
:XY
*       ctl_flags_xy_we=1;
:HF
*       ctl_flags_hf_we=1;
:PF
*       ctl_flags_pf_we=1;
:NF
*       ctl_flags_nf_we=1;
:CF
*       ctl_flags_cf_we=1;

//-----------------------------------------------------------------------------------------
// Special sequence macros for some instructions make it simpler for all other entries
//-----------------------------------------------------------------------------------------
:Special
Ex_DE_HL        ctl_reg_ex_de_hl=1;                         // EX DE,HL
Ex_AF_AF'       ctl_reg_ex_af=1;                            // EX AF,AF'
EXX             ctl_reg_exx=1;                              // EXX

CCF             ctl_flags_cf_cpl=1;                         // CCF
SCF             ctl_flags_cf_set=1;                         // SCF

HALT

DI_EI           ctl_iffx_bit=op3; ctl_iffx_we=1;            // DI/EI
IM              ctl_im_sel=op43; ctl_im_we=1;               // IM n

IX_IY           ctl_state_iy_set=op5; ctl_state_ixiy_we=1;  // IX/IY prefix
ED              ctl_state_tbl_ed_set=1;                     // ED-table prefix
CB              ctl_state_tbl_cb_set=1;                     // CB-table prefix

ALUOP           ctl_state_alu=1;                            // Activate ALU operation PLA wires
// ALU operations controlled by a set of ALU PLA entries
ALU_CP
ALU_SUB
ALU_SBC
ALU_ADC
ALU_ADD
ALU_AND
ALU_OR
ALU_XOR

// M1 opcode read cycle and the refresh register increment cycle
OpcodeIR        ctl_ir_we = 1;          // Write the opcode into the instruction register
Limit6          ctl_inc_limit6=1;       // Limit the incrementer to 6 bits