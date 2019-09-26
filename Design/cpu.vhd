-- Basic CPU 

library	ieee;
use	ieee.std_logic_1164.all;
use	ieee.numeric_std.all;

entity	cpu is
	port(
		clk, reset: in std_logic;
		db: in std_logic_vector(7 downto 0);  -- data bus
		ab: out std_logic_vector(7 downto 0); -- address bus
		ob: out std_logic_vector(7 downto 0)  -- output bus
		);
end cpu;

architecture arch of cpu is
    constant ABW: integer:=8;
    constant DBW: integer:=8;
	constant LDRM: unsigned := "10100000"; -- A0H
		
	constant INCR: unsigned := "10110000"; -- B0H
	constant DECR: unsigned := "11010000"; -- D0H
	
	constant JMPM: unsigned := "11000000"; -- C0H
	constant JRNZ: unsigned := "00110000"; -- 30H
	
	constant MF: unsigned := "10000000"; -- 80H
	constant MB: unsigned := "01000000"; -- 40H
	constant ML: unsigned := "00100000"; -- 20H
	constant MR: unsigned := "00010000"; -- 10H
	
	constant PUP: unsigned := "10010000"; -- 90H
	constant PDN: unsigned := "01100000"; -- 60H 
	
	constant HALT: unsigned := "11111111"; -- FFH
	
	
	type	state_type is (
		  all_0, all_1   -- common to all instructions
		 );
	signal	st_pre, st_nxt:	state_type;
	signal	pc_pre, pc_nxt: unsigned(ABW-1 downto 0);
	signal	ir_pre, ir_nxt: unsigned(DBW-1 downto 0);
	signal	r_pre, r_nxt: unsigned(DBW-1 downto 0);

begin
process(clk,reset)						-- state register code section
begin
	if (reset='1') then
		st_pre <= all_0;
		pc_pre <= (others => '0');	-- reset address is all-0
		ir_pre <= (others => '1'); 	-- default opcode is HALT (all '1')
		r_pre  <= (others => '0');	-- initialize data register to 0
	elsif (clk'event and clk='1') then
		st_pre <= st_nxt;
		pc_pre <= pc_nxt;
		ir_pre <= ir_nxt;
		r_pre <= r_nxt;
	end if;
end process;

process(st_pre,db,pc_pre,r_pre)	-- next state + (Moore) outputs code section
begin
	st_nxt <= st_pre;
	pc_nxt <= pc_pre;	
	ir_nxt <= ir_pre;
	r_nxt <= r_pre; -- DR 
	
	case st_pre is
		when all_0 => 					-- all_0 
			ir_nxt <= unsigned(db);  
			pc_nxt <= pc_pre+1;
			st_nxt <= all_1;
		when all_1 =>			-- all_1
			if (ir_pre = LDRM) then	  -- Load DR
			    r_nxt <= unsigned(db);
                pc_nxt <= pc_pre+1;
				st_nxt <= all_0;
			
			elsif (ir_pre = INCR) then -- INC DR
                 r_nxt <= r_pre+1;            
                 st_nxt <= all_0;
            
            elsif (ir_pre = DECR) then -- DEC DR
                 r_nxt <= r_pre-1;            
                 st_nxt <= all_0;
                 
			elsif (ir_pre = JMPM) then -- JMP to memory address
			    pc_nxt <= unsigned(db);		    
                st_nxt <= all_0;
                
            elsif (ir_pre = JRNZ) then -- JMP if not zero
			    if (r_pre = "00000000") then -- if zero increment PC
			         pc_nxt <= pc_pre + 1;
			         st_nxt <= all_1; 
			    else                         -- if not zero jump
                    pc_nxt <= unsigned(db);		    
                    st_nxt <= all_0;
               end if;
               
               ------------------------------------------------------------------------------------------------------
            elsif (ir_pre = MF) then -- Move forward
			    r_nxt <= unsigned(db);
                pc_nxt <= pc_pre+1;
				st_nxt <= all_0;
                
            elsif (ir_pre = MB) then -- Move backward
			    r_nxt <= unsigned(db);
                pc_nxt <= pc_pre+1;
				st_nxt <= all_0;
                
            elsif (ir_pre = MR) then -- Move right
			    r_nxt <= unsigned(db);
                pc_nxt <= pc_pre+1;
				st_nxt <= all_0;
                
            elsif (ir_pre = ML) then -- Move left
			    r_nxt <= unsigned(db);
                pc_nxt <= pc_pre+1;
				st_nxt <= all_0;
			
			elsif (ir_pre = PUP) then -- Pen Up
			    r_nxt <= unsigned(db);
                -- pc_nxt <= pc_pre+1;  -- Do not think this should be here. did not implement either pen up or down in the ROM.
				st_nxt <= all_0;
                ------------------------------------------------------------------------------------------------------------------------------------
            elsif (ir_pre = PDN) then -- Pen Down
			    r_nxt <= unsigned(db);
                -- pc_nxt <= pc_pre+1;  -- Do not think this should be here 
				st_nxt <= all_0;
			
			elsif (ir_pre = HALT) then -- HALT processor at current position
				st_nxt <= all_1;
			
			else 
				st_nxt <= all_0;
			end if;
			
	end case; 
end process;

ab <= std_logic_vector(pc_pre);
ob <= std_logic_vector(r_pre);

end arch;


