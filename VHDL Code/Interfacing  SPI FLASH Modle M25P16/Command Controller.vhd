/* The following design implements a command controller unit to interface to a SPI Serial Flash IC.
It processes the instruction supported by the device by generating and monitoring the necessary 
signals and timing recquired to successfully communicate with the Flash device. 
The Flash device in use here is the  M25P16 a 16 MBit Flash from ST Microelectronics organised 
as follow: 

				32 Sectors @ 256 Pages
				Each Page is 256 Bytes wide 

 
The direct communication with the device should be a spi master which realise each SPI Transaction
as define by this using. 
Baudrate, the Frame to be send to Flash device(supported instruction), necessary delay cycle and 
slave frame are defined in this unit or to be reported to this unit.

During a bus transaction trasnmitting a command the miso Output of the M25P16 device remains
in high impedance, therefore the slave frame resulting from such a trasnction has to be ignored.
Some commands expect  a number of byte to be returned from the M25P16 after a successfull command,
as response. Thus, here the need of maintaining the slaveselect ouput of the spi master low until 
all expected byte are transmitting. This may be done by inserting the necessary extra delay cycle 
to the bus transaction trasnmitting the command.

The supported instruction are:

-------------------------------------- SPI Flash supported Instructions -----------------------------------------
    Instructions	  	|		Length				|			Description						|		
				|						|													  		|
   Write Enable:		|		1 byte				|   	This insctruction set the WEL bit of the Status 		|
       (WREN)			|						|   	Register Flash contains. This bit is to be set prior 	|
				|						|  	 each intruction which modifies the flash devices or 	|
				|						|   	writes its Status Register. 							|
				|						|	These are the instrunctions: PP,SE,BE and WRSR			|
				|						|	No Frame is recquired from the M25P16, therefore the	|
				|						|	byte received from the slave during this transaction 	|
				|						|	is to be ignored.										|
				|						|	 														|
  Write Disable:		|						|	Resets the Write Enable Latch (WEL) bit.				|									
       (WRDI)		   	|		1 byte				|	No Frame is recquired from the M25P16, therefore the 	|
				|  	  no response				|	byte received from the slave during this transaction	|
				|						|	is to be ignored.										|
				|						|															|
				|						|															|
 Read Identification:		|		1 byte				|	To read the manufacturer identication followed by 2		|
        (RDID)			| 	3 Bytes response			|	bytes of device information.							|
				| 						|															|
				|						|															|
				|						|															|
				|						|															|
				|						|															|															
  Read Status Register:		|		1 byte			|	To read the status register at any time even while a	|
	    (RDSR)		|	1 byte response		|	PP,SE,BE or WRSR cycle is in progress. Also this com-	|
				|						|	mand may be send continously. This make possible shor-	|
				|						|	tening the latency when a command with long execution	|
				|						|	is in progressy. polling the status register bit WIP	|
				|						|	help to insure if the insctruction execution is termi-	|
				|						|	nated before the Data sheet recommanded latency.		|
				|						|															|
					|						|															|
   Write Status Register:		|	  2 bytes long		|	Writes the Status register when neither Hardware or 	|
		  (WRSR)		|	  1 byte cmd ID		|	Software protection is active. It has to precede from	|
					|	  1 Data Byte		|	a WREN instruction. WEL Bit(Bit 1),WIP Bit(Bit 0),bit 5	|
					|	  no response		|	and	bit 6 of the Status Register can not be written by	|
					|						|	this instruction. This instruction is exectuted if and 	|
					|						|	only if the total duration of the active phase of SS is	|
					|						|	a multiple of 8 pulse and terminate directly after the	|
					|						|	last bit of the second byte has been being latched in.	|
					|						|															|
					|						|															|
	Read Data Bytes:		|	  4 bytes long 		|	After the last adress byte has been latched in on 		|
	(READ)		| 	  1 byte cmd ID		|	M25P16 the Data adressed are shifted out bytewise with	|
					| 	  3 bytes adr		|	automaticaly adress increment at a max Bit freq fr.		|
					|  response delimited	|	SlaveSelect going high stopps the M25P16.				|
					|  by SlaveSelcet going	|															|
					|	high				|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
 Read Data at Higher Speed		|	  5 bytes long		|	Apart the max frq at which the bit are shifted out by 	|
	(FAST_READ)   	  	|	  1 byte cmd ID		|	M25P16 and a mandatory dummy byte after the 3 bytes 	|
					|	  3 bytes adr		|	adress is this cmd  identical to the cmd READ			|
					|  response delimited	|														  	|
					|  by SlaveSelcet going	|															|
					|  high					|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
					|						|															|
		Page Program				|1 byte insctruction ID	|	allows bytes to be programmed in the memory(changing	| 
		     (PP)				|	3 bytes adresses	|	from 1 to 0). Before it can be accepted, a WREN In-		|
							| at least 1 byte data	|	truction must previously have been executed. If the 8	|
							| and at most 256 bytes	|   least  significant adr bits(A7-A0) are not all 0, all	|
							|	No response			|	transmitted data that goes beyond the end of the cur-	|
  							|						|   rent page are programmed from the start adr of the same	|
							|						|	page(from the adr whose 8 LSB are all 0). SlaveSelect 	|
							|						|	must remains low for the entire sequence. SlaveSelect	|
							|						|	going high starts the counter for Tpp(Page Programm	Cy-	|
							|						|	cle)													|
							|						|															|
							|						|															|	
							|						|															|
							|						|															|
							|						|															|
							|						|															|
							|						|															|
							|						|															|
							|						|															|
							|						|				  											|
 		Sector Erase:				|	  4 bytes long		|	The Sector Erase (SE) instruction sets to 1 (FFh) all	|
			(SE)   	  			|	  1 byte cmd ID		|	inside the chosen sector. Before it can be	accepted, a	|
							|	  3 bytes adr		|	Write Enable (WREN) instruction must previously have	|
							|						|	been executed. After the Write Enable (WREN) cmd has 	|
							|						|	been decoded, the devices sets the Write Enable latch	|
							|						|	bit. This instruction is exectuted if and only if the	|
							|						|	total duration of the active phase of SS is a multiple	|
							|						|	of 8 pulse and terminate directly after the last bit	|
							|						|	of the second byte has been being latched in.			|
							|						|															|
							|						|															|
							|						|															|
 		Bulk Erase:		   		|	  1 byte cmd ID		|	Sets all Bits to 1(FFh). WEN cmd should had been exe-	|
			(BE)				|	   No response		|	cuted for this cmd to be accepeted.						|
							|						|															|
							|						|	This instruction is exectuted if and only if the total	|
							|						|	duration of the active phase of SS is a multiple of 8	|
							|						|	pulses and terminate directly after the last bit of the	|
							|						|	cmd ID has been being latched in. SlaveSelect going 	|
							|						|	start the counter for tbe(Erase Cycle duration)			|
							|						|															|
							|						|															|
							|						|															|
		Deep Power Down:   			|	  1 byte cmd ID		|	Put the device in the lowest consumption mode (Deep		|
		(DP)					|	    No response		|	Power Mode) thus reducing the Device Power consumption.	|
							|						|	This instruction is exectuted if and only if the total	|
							|						|	duration of the active phase of SS is a multiple of 8	|
							|						|	pulses and terminate directly after the last bit of the	|
							|						|	cmd ID has been being latched in. SlaveSelect going 	|
							|						|	start the counter for tbe(Erase Cycle duration)			|
							|						|															|
							|						|															|
							|						|															|
	Release from Deep	  			|	  5 Bytes long		|	Once the device has entered the Deep Powerdown mode, 	|
	Power Down and Read				|	1 byte Instruction	|	all instructions are ignored except the	Release from	|				
	Electronic Signature: 				|	3 Dummy Bytes		|	Deep Power-down and Read Electronic Signatuere (RES)	|
	   (RES)					| 1 byte Electronic	Si-	|	instruction. Executing this command takes teh device 	|
							| gnature as response.	|	out of the Deep Power-Down mode.						|
							|						|				  											|
							|						|													  		|
						|						|															|
*/




Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.interfacing_M25P16.Cmd_Exe_Phase;


entity cmd_controller is
	generic(
		FrameLength: positive:= 8;
		PulseCounterLength: positive:= 8);
	port(
		clk: in std_ulogic;
		rst: in std_ulogic;
		
		-- top module
		execute: in std_ulogic;
		repeat: in std_ulogic;
		cmd_ID: in std_ulogic_vector(3 downto 0);
		done: out std_ulogic;
		NbrPulse2Read: in u_unsigned(PulseCounterLength -1 downto 0);
		
		-- to FIFO
		wr_fifo: out std_ulogic;
		rd_fifo: out std_ulogic;
		fifo_or_cmd: out std_ulogic;
		
		-- SPI Master
		master_done: in std_ulogic;
		enable_master: out std_ulogic;	-- Master DataValid
		StartDelay: out u_unsigned(PulseCounterLength -1 downto 0);	-- Master CycleStartDelay
		PostDelay:  out u_unsigned(PulseCounterLength -1 downto 0);	-- Master CycleEndDelay
		Data_2_master: out std_ulogic_vector(7 downto 0));	-- MP25P16 CMD ID 

end entity cmd_controller;


architecture rtl_description of cmd_controller is

 type Cmd_Exe_Phase is (idle, send_id, read_fifo, write_fifo);
 signal current_state,next_state: Cmd_Exe_Phase:= idle;
 signal r_cmd_ID: std_ulogic_vector(3 downto 0):= (others => '0');
 
 signal r_repeat_flag,rst_repeat_flag: std_ulogic:= '0';
 
 signal r_doneCounter: u_unsigned(7 downto 0):= (others =>'0');
 
 signal r_rd_fifo,r_wr_fifo,r_done,r_fifo_or_cmd: std_ulogic:= '0';

 signal r_enable_master: std_ulogic:= '0';
 signal r_StartDelay,r_PostDelay,r_NbrPulse2Read: u_unsigned(PulseCounterLength -1 downto 0):= (others => '0');
 signal r_Data_2_master: std_ulogic_vector(7 downto 0); 
 

begin


 --Repeat_Flag: process(clk,rst)
 --begin
 --
--	if rst = '1' then
--		r_repeat_flag <= '0';
--		
--	elsif rising_edge(clk) then
--		
--		if repeat = '1' then
--			r_repeat_flag <= '1';
--			
--		elsif rst_repeat_flag = '1' then
--			r_repeat_flag <= '0';
--			
--		end if;
--	end if;
 --
 --end process Repeat_Flag;
 
 
 CountDonePulse: process(clk,rst)
 begin
	
	if rst = '1' then
		r_doneCounter <= (others => '0');
		
	elsif rising_edge(clk) then
	
		if current_state /= idle and current_state /= send_id then
		
			if master_done = '1' then
				r_doneCounter <= r_doneCounter + 1;
				
			end if;
			
		else
		
			r_doneCounter <= (others => '0');
			
		end if;
	
	end if;
 
 end process CountDonePulse;
 
 
 FSM_Transition: process(clk,rst)
 begin
 
	if rst = '1' then
		current_state <= idle;
		
	elsif rising_edge(clk) then
		
		current_state <= next_state;
		
	end if;
 end process FSM_Transition;
 
 
 Execute_Command: process(clk,rst)
 begin
 
	if rst = '1' then
		next_state <= idle;
		r_done <= '0';
		r_rd_fifo <= '0';
		r_wr_fifo <= '0';
		r_enable_master <= '0';
		r_fifo_or_cmd <= '0';
		rst_repeat_flag <= '0';
		r_NbrPulse2Read <= (others => '0');
		r_StartDelay <= (others => '0');
		r_PostDelay	 <= (others => '0');
		r_cmd_ID <= (others => '0');
		r_Data_2_master <= (others => '0');
		
	elsif rising_edge(clk) then
	
		case current_state is
		
			when idle =>
														
				if execute = '1' then
										
					cmd:
					if cmd_ID = 4X"0" then	-- WREN
						r_Data_2_master <= X"06";
						next_state <= send_id;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"0",PostDelay);
					
					elsif cmd_ID = 4X"1" then	-- WRDI
						r_Data_2_master <= X"04";
						next_state <= send_id;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"0",PostDelay);
						
					elsif cmd_ID = 4X"2" then	-- RDID
						r_Data_2_master <= X"9F";
						next_state <= send_id;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"18",PostDelay);
					
					elsif cmd_ID = 4X"3" then	-- RDSR
						r_Data_2_master <= X"05";
						next_state <= send_id;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"08",PostDelay);-- stets 1 more pulse, so it's 
																-- possible to set a repeat
																-- when WIP is high
					elsif cmd_ID = 4X"4" then	-- WRSR
						r_Data_2_master <= X"01";
						next_state <= read_fifo;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"8",PostDelay);	-- 8 pulses for the Second BYte
						
					elsif cmd_ID = 4X"5" then	-- READ	
						r_Data_2_master <= X"03";
						next_state <= read_fifo;
                        r_StartDelay <= resize(b"0",StartDelay);
						r_PostDelay	 <= NbrPulse2Read + resize(X"18",PostDelay);
							
					elsif cmd_ID = 4X"6" then	-- FAST_READ
						r_Data_2_master <= X"0B";
						next_state <= read_fifo;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= NbrPulse2Read + resize(X"20",PostDelay);
					
					elsif cmd_ID = 4X"7" then	-- PP
						r_Data_2_master <= X"02";
						next_state <= read_fifo;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"18",PostDelay);
						
					elsif cmd_ID = 4X"8" then	-- SE
						r_Data_2_master <= X"D8";
						next_state <= read_fifo;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"18",PostDelay);
					
					elsif cmd_ID = 4X"9" then	-- BE
						r_Data_2_master <= X"C7";
						next_state <= send_id;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"0",PostDelay);
						
					elsif cmd_ID = 4X"A" then	-- DP
						r_Data_2_master <= X"B9";
						next_state <= send_id;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"0",PostDelay);
					
					elsif cmd_ID = 4X"B" then	-- RES
						r_Data_2_master <= X"AB";
						next_state <= write_fifo;
						r_StartDelay <= resize(X"0",StartDelay);
						r_PostDelay	 <= resize(X"0",PostDelay);
							
					end if cmd;
					

					r_enable_master <= '1';
					
				else 
					
					--r_done <= '1';
					r_wr_fifo <= '0';
					r_enable_master <= '0';
					--r_fifo_or_cmd <= '0';
					--r_cmd_ID <= (others => '0');
					--r_Data_2_master <= (others => '0');
										
				end if;	
				
				if execute = '1' or r_enable_master = '1' then
					r_done <= '0';
					r_cmd_ID <= cmd_ID;
					
				else 
					r_done <= '1';
					r_cmd_ID <= (others => '0');
					
				end if;
			
				
			
			when send_id =>
			
				DefiningNextState:
                if master_done = '1' then
					
					-- WREN or WRDI or BE or DP
					if r_cmd_ID = 4X"0" or r_cmd_ID = 4X"1" or 
					   r_cmd_ID = 4X"9"	or r_cmd_ID = 4X"A" then 
					  
						next_state <= idle;
					
					-- RDID or RDSR or RES
					elsif r_cmd_ID = 4X"2" or r_cmd_ID = 4X"3" or
						  r_cmd_ID = 4X"B" then		
						next_state <= write_fifo;
																
					end if;
				
				else
					r_enable_master <= '0';	-- reset r_enable_master from idle
					
				end if DefiningNextState;
			
						
			
			when write_fifo =>				
				
				RDID:
				if r_cmd_ID = 4X"2" then
					
					Writing2FIFO:
					if master_done = '1' then					
						r_wr_fifo <= '1';
						
					else
						r_wr_fifo <= '0';
					
					end if Writing2FIFO;
					
					DefiningNextState_1:
					if master_done = '1' and r_doneCounter = to_unsigned(2, r_doneCounter) then
						next_state <= idle;
				
					end if DefiningNextState_1;
					
				end if RDID;
				
				
				RDSR:
				if r_cmd_ID = 4X"3" then
					
					Set_rst_repeat_flag1:
					if r_repeat_flag = '1' then
						rst_repeat_flag <= '1';
						r_PostDelay <= r_PostDelay + to_unsigned(FrameLength,StartDelay);
						
					else
						rst_repeat_flag <= '0';
					
					end if Set_rst_repeat_flag1;
					
					DefiningNextState_2:	-- 
					if r_doneCounter >= to_unsigned(1, r_doneCounter) and r_repeat_flag = '0' then
						next_state <= idle;
						
					end if DefiningNextState_2;
					
					Writing2FIFO_1:
					if master_done = '1' then
						r_wr_fifo <= '1';
					
					else
						r_wr_fifo <= '0';
						
					end if Writing2FIFO_1;
				end if RDSR;
							
				
				READ_and_FAST_READ:
				if r_cmd_ID = 4X"5" or r_cmd_ID = 4X"6" then
					
					--r_PostDelay <= NbrPulse2Read
					--Set_rst_repeat_flag2:
				    --if r_repeat_flag = '1' then
				    --	rst_repeat_flag <= '1';
				    --	r_PostDelay <= r_PostDelay + to_unsigned(FrameLength,StartDelay);
				    --	
				    --else
				    --	rst_repeat_flag <= '0';
				    --
				    --end if Set_rst_repeat_flag2;
					
					Writing2FIFO_2:
					if master_done = '1' then
						r_wr_fifo <= '1';
						
					else 
						r_wr_fifo <= '0';
						
					end if Writing2FIFO_2;
					
					DefiningNextState_3:
					if (r_cmd_ID = 4X"5" and master_done = '1' and r_doneCounter = (NbrPulse2Read sra 3) + to_unsigned(3,r_doneCounter)) or
					   (r_cmd_ID = 4X"6" and master_done = '1' and r_doneCounter = (NbrPulse2Read sra 3) + to_unsigned(4,r_doneCounter)) then
						next_state <= idle;
												
					end if DefiningNextState_3;
				
				end if READ_and_FAST_READ;
				--
				--
				--PP:
				--if r_cmd_ID = 4X"7" then
				--
				--end if PP;
				
				
				RES:
				if r_cmd_ID = 4X"B" then
				
					Writing2FIFO_3:
					if r_doneCounter > to_unsigned(3,r_doneCounter) and master_done = '1' then
						r_wr_fifo <= '1';
						
					else
						r_wr_fifo <= '0';
						
					end if Writing2FIFO_3;
					
					
					DefiningNextState_4:
					if r_doneCounter = to_unsigned(4, r_doneCounter) then
						next_state <= idle;
					
					end if DefiningNextState_4;
				
				end if RES;
				
	
						
			when read_fifo =>
																
				WRSR:
				if r_cmd_ID = 4X"4" then
					
					Load_Master1:		-- with read value,at end of transmission no enable					
					if master_done = '1' and r_doneCounter = to_unsigned(0,r_doneCounter) then
						r_enable_master <= '1';
						
					else
						r_enable_master <= '0';	
						
					end if Load_Master1;
					
					
					SetFIFOasTxFrame1:
					if r_doneCounter = to_unsigned(2, r_doneCounter) then
						r_fifo_or_cmd <= '0';	-- reset r_fifo before changing to idle
						
					else 	
						r_fifo_or_cmd <= '1';
						
					end if SetFIFOasTxFrame1;
					
										
					Inc_FIFO_rd_Pointer_1:
					if r_enable_master = '1' and r_doneCounter = to_unsigned(1,r_doneCounter) then						
						r_rd_fifo <= '1';	-- Only when r_done counter = '1' to prevent erroneously					
					else					-- reading of fifo
						r_rd_fifo <= '0';						
					end if Inc_FIFO_rd_Pointer_1;					
					
					
					DefiningNextState_5:
					if r_doneCounter = to_unsigned(2, r_doneCounter) then
						next_state <= idle;
						
					end if DefiningNextState_5;
					
				end if WRSR;
				
				
				READ_CMD:
				if r_cmd_ID = 4X"5" then 
				
					SetFIFOasTxFrame2:
					if r_doneCounter = to_unsigned(4, r_doneCounter) then
						r_fifo_or_cmd <= '0';	
						
					else	
						r_fifo_or_cmd <= '1';
						
				    end if SetFIFOasTxFrame2;
					
					
					Load_Master2:	-- with read value, at end of transmission no enable								
					if master_done = '1' and r_doneCounter < to_unsigned(3,r_doneCounter) then
						r_enable_master <= '1';
						
					else
						r_enable_master <= '0';	
						
				    end if Load_Master2;
					
					
					Inc_FIFO_rd_Pointer_2:
					if master_done = '1' and r_doneCounter < to_unsigned(3,r_doneCounter) then
						r_rd_fifo <= '1';
						
					else
						r_rd_fifo <= '0';
					
					end if Inc_FIFO_rd_Pointer_2;


					DefiningNextState_6:
					if r_doneCounter = to_unsigned(4, r_doneCounter) then
                    	next_state <= write_fifo;
                    	
                    end if DefiningNextState_6;			
													
				end if READ_CMD;
				
				
				
				FAST_READ: 
				if r_cmd_ID = 4X"6" then
				
					SetFIFOasTxFrame3:
					if r_doneCounter >= to_unsigned(4, r_doneCounter) then
						r_fifo_or_cmd <= '0';	
						
					else	
						r_fifo_or_cmd <= '1';
						
					end if SetFIFOasTxFrame3;
								    
				    
				    Inc_FIFO_rd_Pointer_3:	-- exclude Dummy Byte
				    if master_done = '1' and r_doneCounter < to_unsigned(4, r_doneCounter) then
				    	r_rd_fifo <= '1';
				    	
				    else
				    	r_rd_fifo <= '0';
				    
				    end if Inc_FIFO_rd_Pointer_3; 
					
				    
				    Load_Master3:
				    if master_done = '1' and r_doneCounter < to_unsigned(3,r_doneCounter) then
				    	r_enable_master <= '1';
						
				    else
				    	r_enable_master <= '0';
						
				    end if Load_Master3;


					DefiningNextState_7:
					if r_doneCounter = to_unsigned(5, r_doneCounter) then
                    	next_state <= write_fifo;
                    	
                    end if DefiningNextState_7;
		
				end if FAST_READ;
				
								
				PP:
				if r_cmd_ID = 4X"7" then
				
					Set_rst_repeat_flag3:
				    if r_repeat_flag = '1' then
				    	rst_repeat_flag <= '1';
				    	r_PostDelay <= r_PostDelay + to_unsigned(FrameLength,StartDelay);
				    	
				    else
				    	rst_repeat_flag <= '0';
				    
				    end if Set_rst_repeat_flag3;
				
				
			    end if PP;
				
				
				SE:
				if r_cmd_ID = 4X"8" then
													
					
					SetFIFOasTxFrame4:
					if r_doneCounter >= to_unsigned(1, r_doneCounter) then
						r_fifo_or_cmd <= '0';	
						
					else	
						r_fifo_or_cmd <= '1';
						
					end if SetFIFOasTxFrame4;
										
					
					Inc_FIFO_rd_Pointer_4:
					if r_enable_master = '1' and r_doneCounter < to_unsigned(3,r_doneCounter) then						
						r_rd_fifo <= '1';					
					else
						r_rd_fifo <= '0';						
					end if Inc_FIFO_rd_Pointer_4;
					
					
					Load_Master4:
					if master_done = '1' and r_doneCounter < to_unsigned(3,r_doneCounter) then
						r_enable_master <= '1';						
					else
						r_enable_master <= '0';						
				    end if Load_Master4;	
					
					
					DefiningNextState_8:
					if r_doneCounter = to_unsigned(4, r_doneCounter) then	--and r_enable_master = '1' then
						next_state <= idle;
						
					end if DefiningNextState_8;
					
				end if SE;
				
							
			
			when others =>
				null;
				
		end case;
	
	end if;
 
 end process Execute_Command;


 Outputs: block
 begin

	enable_master <= r_enable_master ;
	StartDelay <= r_StartDelay;
	PostDelay <= r_PostDelay;
	Data_2_master <= r_Data_2_master;
	
	wr_fifo <= r_wr_fifo ;
    rd_fifo <= r_rd_fifo;
	
	done <= r_done;
	fifo_or_cmd <= r_fifo_or_cmd; 
	--'1' when (current_state = idle and next_state /= idle) else '0';
 
 end block Outputs;



end architecture rtl_description;





-- translate_off

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.interfacing_M25P16.Cmd_Exe_Phase;

entity testbench is
	generic( PulseCounterLength: positive := 8);

end entity testbench;

architecture testing of testbench is

 signal clock: std_ulogic:= '0';
 signal reset: std_ulogic:= '1';
 
 component cmd_controller is
 	generic(
 		FrameLength: positive:= 8;
 		PulseCounterLength: positive:= 8);
 	port(
 		clk: in std_ulogic;
 		rst: in std_ulogic;
 		
 		-- top module
 		execute: in std_ulogic;
 		repeat: in std_ulogic;
 		cmd_ID: in std_ulogic_vector(3 downto 0);
 		done: out std_ulogic;
 		NbrPulse2Read: in u_unsigned(PulseCounterLength -1 downto 0);
		
 		-- to FIFO
 		wr_fifo: out std_ulogic;
 		rd_fifo: out std_ulogic;
 		
		-- Mux
		fifo_or_cmd: out std_ulogic;
		
 		-- SPI Master
 		master_done: in std_ulogic;
 		enable_master: out std_ulogic;	-- Master DataValid
 		StartDelay: out u_unsigned(PulseCounterLength -1 downto 0);	-- Master CycleStartDelay
 		PostDelay:  out u_unsigned(PulseCounterLength -1 downto 0);	-- Master CycleEndDelay
 		Data_2_master: out std_ulogic_vector(7 downto 0));	-- Master tx_frame
 
 end component cmd_controller;
 
 
 component module_fifo_regs_no_flags is
   generic (
     g_WIDTH : natural := 8;
     g_DEPTH : integer := 32
     );
   port (
     i_rst_sync : in std_logic;
     i_clk      : in std_logic;
  
     -- FIFO Write Interface
     i_wr_en   : in  std_logic;
     i_wr_data : in  std_logic_vector(g_WIDTH-1 downto 0);
     o_full    : out std_logic;
  
     -- FIFO Read Interface
     i_rd_en   : in  std_logic;
     o_rd_data : out std_logic_vector(g_WIDTH-1 downto 0);
     o_empty   : out std_logic
     );
 end component module_fifo_regs_no_flags;
 
 
 signal spi_master_enable,spi_master_done: std_ulogic;
 signal data2spimaster,txFrame,slaveframe: std_ulogic_vector(7 downto 0);
 signal spi_sclk,spi_SlaveSelect,spi_mosi: std_ulogic;
 signal spi_miso: std_ulogic:= '1';
 signal startdelay,enddelay,ExtNbrPulse2Read: u_unsigned(7 downto 0);
 signal done2topdelayed: std_ulogic_vector(1 downto 0);
 
 signal topexecute,topexecutedelay,toprepeat,done2top,fifoorcmd: std_ulogic;
 
 type cmd is array (1 to 14) of std_ulogic_vector(3 downto 0);
 signal id_cmd: cmd:= (4X"0",4X"1",4X"2",4X"3",4X"4",4X"5",4X"1",4X"0",4X"6",4X"8",4X"9",4X"A",4X"B",4X"7");
 
 signal wr_en_fifo,rd_en_fifo,fifo_full,fifo_empty: std_ulogic;
 signal datafromfifo,data2fifo: std_ulogic_vector(7 downto 0);
 
 alias spi_master_slaveselect is
 << signal .testbench.inst.SlaveSelect: std_ulogic >>;
 

begin

 
 simulating_cmd_controller: cmd_controller
 generic map(8,8)
 port map(clock,reset,topexecute,toprepeat,id_cmd(1),done2top,
		  ExtNbrPulse2Read,wr_en_fifo,rd_en_fifo,fifoorcmd,
		  spi_master_done,spi_master_enable,startdelay,
		  enddelay, data2spimaster);
		  
		  
 simulating_fifo: module_fifo_regs_no_flags
 generic map(8,32)
 port map(reset,clock,wr_en_fifo,data2fifo,fifo_full,
		  rd_en_fifo,datafromfifo,fifo_empty);
		  

 inst: entity work.spi_master_M25P16
 generic map("00",10,8,8)
 port map('1',"0110110010",clock,reset,spi_master_enable,
		  spi_master_done,txFrame,data2fifo,startdelay,enddelay,
		  spi_sclk,spi_SlaveSelect,spi_mosi,spi_miso);

  
 Simulating_spi_slave: process(spi_sclk,reset)	
 begin
	if reset = '1' then
		slaveframe <= "00101110";	--(others => '1');
		
	elsif rising_edge(spi_sclk) then-- ändern wenn nötig auf falling_edge
		slaveframe <= slaveframe(slaveframe'length - 2 downto 0) & spi_mosi;

	end if;
 end process Simulating_spi_slave;
 
 dummy_data: spi_miso <= slaveframe(7) when spi_master_slaveselect = '0' else 'Z'; 
 
 
 txFrame <= data2spimaster when not fifoorcmd else datafromfifo;
 
 
 clock <= not clock after 10 ns;
 reset <= '0' after 55 ns, '1' after 235 ns, '0' after 515 ns; 
 
			
 TOP_MODULE: process(clock,reset)
 begin
 	
	if reset = '1' then
		topexecutedelay <='0';
		done2topdelayed <= (others => '0');
		ExtNbrPulse2Read <= (others => '0');
		--id_cmd <= (4X"0",4X"1",4X"2",4X"3",4X"4",4X"5",4X"6",4X"8",4X"9",4X"A",4X"B",4X"7");
		
	elsif rising_edge(clock) then
		
		TwoclockDelayingdone2top: done2topdelayed <= done2topdelayed(0) & done2top;
			
		Delaying_top_execute: topexecutedelay <= topexecute;
		
		
		if topexecutedelay = '1' and topexecute = '0' then	-- cmd_ctl_state = idle and fifoorcmd = '1'
			id_cmd <= (1 => id_cmd(2),   2 => id_cmd(3),   3 => id_cmd(4),   4 => id_cmd(5), 
					   5 => id_cmd(6),   6 => id_cmd(7),   7 => id_cmd(8),   8 => id_cmd(9), 
					   9 => id_cmd(10), 10 => id_cmd(11), 11 => id_cmd(12), 12 => id_cmd(13),
					  13 => id_cmd(14), 14 => id_cmd(1));
		end if;
		
		if done2top = '1' and id_cmd(14) = 4X"4" and id_cmd(1) = 4X"5" then
			ExtNbrPulse2Read <= to_unsigned(40,ExtNbrPulse2Read);
			
		elsif done2top = '1' and id_cmd(14) = 4X"0" and id_cmd(1) = 4X"6" then
			ExtNbrPulse2Read <= to_unsigned(24,ExtNbrPulse2Read);
			
		elsif done2top = '1' and id_cmd(1) /= 4X"5" and id_cmd(1) /= 4X"6" then
			ExtNbrPulse2Read <= to_unsigned(0,ExtNbrPulse2Read);
			
		end if;
		
	end if;
 
 end process TOP_MODULE;
 
 SingleshotFromdone2top: topexecute <= not done2topdelayed(1) and done2topdelayed(0);
 
 
end architecture testing;







library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity module_fifo_regs_no_flags is
  generic (
    g_WIDTH : natural := 8;
    g_DEPTH : integer := 32
    );
  port (
    i_rst_sync : in std_logic;
    i_clk      : in std_logic;
 
    -- FIFO Write Interface
    i_wr_en   : in  std_logic;
    i_wr_data : in  std_logic_vector(g_WIDTH-1 downto 0);
    o_full    : out std_logic;
 
    -- FIFO Read Interface
    i_rd_en   : in  std_logic;
    o_rd_data : out std_logic_vector(g_WIDTH-1 downto 0);
    o_empty   : out std_logic
    );
end module_fifo_regs_no_flags;
 
architecture rtl of module_fifo_regs_no_flags is
 
  type t_FIFO_DATA is array (0 to g_DEPTH-1) of std_logic_vector(g_WIDTH-1 downto 0);
  signal r_FIFO_DATA : t_FIFO_DATA := (others => (others => '0'));
 
  signal r_WR_INDEX   : integer range 0 to g_DEPTH-1 := 0;
  signal r_RD_INDEX   : integer range 0 to g_DEPTH-1 := 0;
 
  -- # Words in FIFO, has extra range to allow for assert conditions
  signal r_FIFO_COUNT : integer range -1 to g_DEPTH+1 := 0;
 
  signal w_FULL  : std_logic;
  signal w_EMPTY : std_logic;
   
begin
 
  p_CONTROL : process (i_clk) is
  begin
    if rising_edge(i_clk) then
      if i_rst_sync = '1' then
        r_FIFO_COUNT <= 0;
        r_WR_INDEX   <= 0;
        r_RD_INDEX   <= 0;
      else
 
        -- Keeps track of the total number of words in the FIFO
        if (i_wr_en = '1' and i_rd_en = '0') then
          r_FIFO_COUNT <= r_FIFO_COUNT + 1;
        elsif (i_wr_en = '0' and i_rd_en = '1') then
          r_FIFO_COUNT <= r_FIFO_COUNT - 1;
        end if;
 
        -- Keeps track of the write index (and controls roll-over)
        if (i_wr_en = '1' and w_FULL = '0') then
          if r_WR_INDEX = g_DEPTH-1 then
            r_WR_INDEX <= 0;
          else
            r_WR_INDEX <= r_WR_INDEX + 1;
          end if;
        end if;
 
        -- Keeps track of the read index (and controls roll-over)        
        if (i_rd_en = '1' and w_EMPTY = '0') then
          if r_RD_INDEX = g_DEPTH-1 then
            r_RD_INDEX <= 0;
          else
            r_RD_INDEX <= r_RD_INDEX + 1;
          end if;
        end if;
 
        -- Registers the input data when there is a write
        if i_wr_en = '1' then
          r_FIFO_DATA(r_WR_INDEX) <= i_wr_data;
        end if;
         
      end if;                           -- sync reset
    end if;                             -- rising_edge(i_clk)
  end process p_CONTROL;
   
  o_rd_data <= r_FIFO_DATA(r_RD_INDEX);
 
  w_FULL  <= '1' when r_FIFO_COUNT = g_DEPTH else '0';
  w_EMPTY <= '1' when r_FIFO_COUNT = 0       else '0';
 
  o_full  <= w_FULL;
  o_empty <= w_EMPTY;
   
  -- ASSERTION LOGIC - Not synthesized
  -- synthesis translate_off
 
  p_ASSERT : process (i_clk) is
  begin
    if rising_edge(i_clk) then
      if i_wr_en = '1' and w_FULL = '1' then
        report "ASSERT FAILURE - MODULE_REGISTER_FIFO: FIFO IS FULL AND BEING WRITTEN " severity failure;
      end if;
 
      if i_rd_en = '1' and w_EMPTY = '1' then
        report "ASSERT FAILURE - MODULE_REGISTER_FIFO: FIFO IS EMPTY AND BEING READ " severity failure;
      end if;
    end if;
  end process p_ASSERT;
 
  -- synthesis translate_on
end rtl;	
-- translate_on
