--
-- ROM with asynchronous read (listing 11.5)
-- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom is
   port(
      ab: in std_logic_vector(7 downto 0);
      db: out std_logic_vector(7 downto 0)
   );
end rom;

architecture arch of rom is
   constant ABW: integer:=8;
   constant DBW: integer:=8;
   type rom_type is array (0 to 2**ABW-1)
        of std_logic_vector(DBW-1 downto 0);
   -- ROM definition
   constant content: rom_type:=(  -- 2^8-by-8
      "10100000",  -- addr 00: LDRM (A0H)
      "01010101",  -- add3 01: data (55H)
      "10110000",  -- addr 02: INCR (B0H)
      "10110000",  -- addr 03: INCR (B0H)
      "11000000",  -- addr 04: JMPM (C0H)
      "00000111",  -- addr 05: addr (07H)
      "11111111",  -- addr 06: HALT (FFH)
      "11010000",  -- addr 07: LDRM (A0H)     
      "00000010",  -- addr 08: data (02H)
      "11010000",  -- addr 09: DECR (D0H)
      "00110000",  -- addr 10: JRNZ (30H)
      "00000000",  -- addr 11: addr (00H)
      "11111111",  -- addr ..: HALT (FFH)
      "11111111",  -- addr ..: HALT (FFH)
      "11111111",  -- addr ..: HALT (FFH)
      "11111111",  -- addr ..: HALT (FFH)
      "11111111",  -- addr ..: HALT (FFH)
      "11111111",  -- addr ..: HALT (FFH)
      "11111111",  -- addr ..: HALT (FFH)
      "11111111",  -- addr ..: HALT (FFH)
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr      
      "00000000",  -- addr
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000",  -- addr 
      "00000000"  -- addr            
   );
begin
   db <= content(to_integer(unsigned(ab)));
end arch;