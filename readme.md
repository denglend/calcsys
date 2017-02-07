# Calcsys 1.3

| Author | Dan Englender, Detached Solutions |
|---|---|
| Email | dan@detachedsolutions.com |
| Platform | TI-73 and TI-83 Plus |
| Version | 1.3 |
| Date | 07/20/01 |
| Type | Application|
| Pages | 1 |


#### How to install Calcsys
- Use the graphlink software to insall the calcsys.8xk file onto your calculator.  You'll need at least version 2.0 of the software, so upgrade if you have an older version.

- If you are having trouble, make sure of the following:
 - Your TI-83 Plus is on the homescreen.
 - You can communicate correctly with your TI-83 Plus using the regular graphlink software (if you can't this is a problem you have to take up with TI tech support)
 - No other graphlink or application install programs are currently running.
 - You have at least 16K of free archive space.
 - Your batteries are not low.
 - Your graphlink is connected to your calculator
 - You are using the latest version of the graphlink software


## TABLE OF CONTENTS
- Notes
- Description of Included Files
- How to use Calcsys
- Hex Editor
- Disassembler
- Port Monitor
- System Flags
- Console
- VAT
- Character Set
- Key Values
- Link Console
- About
- Thanks
- Known Bugs
- Contact Information


###NOTES
- Be sure to visit the Detached Solutions website - www.detachedsolutions.com
- This document is best viewed in a fixed width font.
- Read Install.txt for information on how to install Calcsys.
- Be sure to check out cool.txt for cool stuff to do with Calcsys.
- On the TI-73, the MATH button functions as the alpha key (you'll have to memorize the key locations).


### DESCRIPTION OF INCLUDED FILES
- Calcsys.8xk - Application file for the TI-83 Plus
- Calcsys.73k - Application file for the TI-73
- Calcsys.txt - This instruction text
- Install.txt - Information on how to install Calcsys
- Cool.txt - Ten cool things you can do with Calcsys
- Remote.txt - Details for controling a 68k calc with Calcsys
- History.txt - Details on changes between release versions

### HOW TO USE CALCSYS
When you first run Calcsys you will be greeted by a menu with seven options:
 1. Hex Editor
 2. Disassembler
 3. Port Monitor
 4. System Flags
 5. Console
 6. Next
 7. Quit

Options 1-5 will run a particular funtion of Calcsys (which are discussed later in this documentation).  Option 7 returns to the homescreen, and option 6 advances to the next menu, which is:
 1. VAT
 2. Caracter Set
 3. Key Values
 4. Link Console
 5. About
 6. More
 7. Quit

Again, options 1-5 run a particular Calcsys funtion, 7 quits, and 6 returns to the original menu.

- In addition, pressing 2nd+Quit will quit the application from almost any point (the exception being the port monitor).
- 2nd+Off will turn the calculator off, and return to the homescreen when the calulator is turned back on.
- APD is enabled (except where stated otherwise), and the calculator will turn off after approx. five minutes of inactivity.
- You can change the current contrast with 2nd+Up/2nd+Down
- The clear button returns to the previous menu in almost all cases (the exception being the console, in which you need to type Q or QUIT to return to the main menu).
- All data, unless specified otherwise, is displayed and inputted in hexadecimal.


### HEX EDITOR
This functions as standard hex editing tool.  Sixteen bytes of data are displayed on the screen at once, with the character that is represented by that number below it.  On the far left of the screen is the memory address where the row of data is.  The current address is defined as the address of the top left byte. The current address is saved until you quit application.
Keypresses in the hex editor are as follows:
 
- Left/Right - Shifts the current address by one byte
- Up/Down - Shifts the current address by four bytes
- 2nd+Left/2nd+Right - Shifts the current address by sixteen bytes
- Plus/Minus - Shifts the current address by 256 bytes
- Multiply/Divide - Shifts the current address by 4096 bytes
- Enter - Edits the current address.  This is only valid if the current address is in RAM ($8000-$FFFF).
- Alpha+D - View the current address in the disassembler
- Alpha+E - Find the next occurance of a 16-bit value
- Alpha+F - Find the next occurance of an 8-bit value
- Alpha+G - Goto an address
- Alpha+R - Change the page mapped into $4000-$7FFF
- [ON]+number key - Store a bookmark
- number key - Recall a bookmark


### DISASSEMBLER
The disassembler provides an onscreen disassembly of z80 assembly code.  Most of the mnemonics are standard.  Any exceptions are due to screen size limitations.  For example
"set 5,(iy+12)" would be represented in the disassembler by "set 5,iy+12".  It should be obvious what the mnemonic is representing if its not the standard one.  The current address (which is the top one of the screen) is saved until you quite the application, like the hex editor. Keypresses are as follows:

- Down - Shifts the current view one instruction down
- Up - Shifts the current view one byte up (note that the up key shifts one byte, while the down key shifts one instruction. You may have to press up a few times to view the complete previous instruction.  This is useful, however, if you have some data directly previous to instructions, and the data is being interpreted as an instruction with the actual instruction as an argument.)
- Alpha+G - Goto an address
- Alpha+H - Hex edit the current address
- Alpha+R - Change the page mapped into $4000-$7FFF
- [ON]+number key - Store a bookmark
- number key - Recall a bookmark

###PORT MONITOR
The port monitor allows you to view data incoming, and send data outgoing, through the various hardware ports.  

```
------------------
|  Port Monitor  |
|Port: 00        |
|Dec:       3    |
|Hex: 03         |
|Bin: 00000011   |
|                |
|                |
|Link            |
------------------
```

The top line (Port) displays what port is current being viewed. The next line displays the value incoming through the port in decimal.  The next line displays in the input value in hexadecimal.  The line under that displays the value in binary. The bottom line of the display shows a discription of that port, if one exists.
Keypresses:

- Up/Down - Change the current port by 1
- Left/Right - Change the current port by 5
- Enter - Output a value to the current port


###SYSTEM FLAGS
When you first start the system flags section, you'll see this screen:

```
------------------
|      Flags     |
|1. key/trig   00|
|2. edit/mon   01|
|3. plot/graph 02|
|4. graph 2    03|
|5. graph 3    04|
|6. Next         |
|7. Back         |
------------------
```

The numbers on the left, are the keys you need to press for the function you want.  The numbers on the far right is the IY offset for that flag group.  The text in the middle is the description for the flag group.  Keys 1-5 bring up the flag editing screen for the cooresponding flag group.  Key 6 goes to the next flag group page (or wraps to the first if you are current on the last).  Key 7 returns to the main menu.  If you choose to view the individual flags in a flag group (by pressing 1-5), you will see a screen like this one (this is IY+00):

```
------------------
|0. indelete   :1|
|1. ????       :0|
|2. deg/rad    :1|
|3. scn cde rdy:0|
|4. key pressed:0|
|5. disp done  :1|
|6. ????       :0|
|7. ????       :0|
------------------
```

The numbers on the left indicate the key you must press to toggle the respective flag.  A 1 on the far right means the flag is set, while a 0 means it is reset.  Press clear to return to the flag group screen from the flag editing screen.


###CONSOLE
The Calcsys console is a command prompt like interface that can be used for testing ROM calls, running programs, or for other things as well.  When you first start the console you see a blank screen, with a blinking cursor.  The console has a set of "virtual registers".  The contents of the virtual registers are loaded into the real CPU registers whenever a CALL, BCALL, or RUN command is executed.  The values returned in the CPU registers after the command is done are then copied back into the virtual registers.  This provides a good means to test input and outputs for ROM calls, or assembly routines.  The console has a wide range of commands, which are explained below:

#### ADD:

- Syntax: ADD NNNN,NNNN
- Alternate syntax: none
- Use: This command adds two hexadecimal numbers and displays the result on the screen.

#### BCALL:

- Syntax: BCALL NNNN
- Alternate syntax: BC NNNN
- Use: This command performs a bcall (rst 28H) instruction.   The address NNNN is where to bcall to.  If NNNN is not a valid 16 bit hexadecimal number, you will receive an ERR: ARGUMENT. The value of the virtual registers will be loaded to the real registers before this instruction is executed, and the values which are returned in the real registers will be loaded into the virtual registers when the command returns. 

#### CALL:

- Syntax: CALL NNNN
- Alternate syntax: C NNNN
- Use: This command performs a call instruction to the address NNNN.  If NNNN is not a valid 16 bit hexadecimal number, you will receive an ERR: ARGUMENT. The value of the virtual registers will be loaded to the real registers before this instruction is executed, and the values which are returned in the real registers will be loaded into the virtual registers when the command returns.


#### CLR:

- Syntax: CLR
- Alternate syntax: none
- Use: This command clears the screen, and returns the cursor to the top left corner of the screen.  This command takes no arguments.


#### DISROM:

- Syntax: DISROM NNNN
- Alternate syntax: DR NNNN
- Use: Opens disassembler and points it to the code for the entry point specified.


#### DIV:

- Syntax: DIV NNNN,NNNN
- Alternate syntax: none
- Use: This divides two hexadecimal numbers and displays the result to the screen.  It will display both the quotient and the remainder.  The high byte of the second input number is ignored.

#### EXEC:

- Syntax: EXEC NN...
- Alternate syntax: X NN...
- Use: This command executes a string of assembly instructions. The instructions are loaded into a temporary space in RAM and then called, so the string needs to end with a $C9 (if you want it to return to the console).  If NN... is not a valid hexadecimal string, and ERR: ARGUMENT will be generated.  The value of the virtual registers will be loaded to the real registers before this instruction is executed, and the values which are returned in the real registers will be loaded into the virtual registers when the command returns.


#### INFO:

- Syntax: INFO
- Alternate syntax: none
- Use: This command will display calculator system information. This information includes: Free memory, Base Code version, Contrast level, VAT size, Program/List VAT location, and current ROM page.


#### HELP:

- Syntax: HELP (command)
- Alternate syntax: none
- Use: This command provides access to the online help system for the console.  Executing a HELP command with no arguments will provide a list of valid arguments.  Executing a HELP command followed by the name of another command provides information about that command.


#### JUMP:

- Syntax: JUMP NNNN
- Alternate syntax: J NNNN
- Use: This command works similar to the BCALL and CALL commands, except it jumps to NNNN instead of bcalling or calling the address.  If NNNN is not a valid 16 bit hexadecimal number,  you will receive a ERR: ARGUMENT. The value of the virtual registers will be loaded to the real registers before this instruction is executed, and the values which are returned in the real registers will be loaded into the virtual registers when the command returns.


#### MUL:

- Syntax: MUL NNNN,NNNN
- Alternate syntax: none
- Use: This command multiplies together two hexadecimal numbers and displays the product on the screen.  It ignores the high bytes of both numbers when multiplying.


#### ROM:

- Syntax: ROM NNNN
- Alternate syntax: none
- Use: Returns the address and page value for the entry point you specify.


#### RUN:

- Syntax: RUN progname
- Alternate syntax: R program
- Use: This command is used to run an assembly program. If progname is not the name of a program, you will receive a ERR: ARGUMENT.  If progname is archived, you will receive an ERR: ARCHIVED.  The value of the virtual registers will be loaded to the real registers before this instruction is executed, and the values which are returned in the real registers will be loaded into the virtual registers when the command returns.


#### SEARCH:

- Syntax: SEARCH NN...
- Alternate syntax: none
- Use: This command searches through the ROM of the calculator for a string of bytes.  It will display the address and ROM page of each instance it finds.


#### SET:

- Syntax: SET 8bitregister,NN or 16bitregister,NNNN or  NNNN,NN...
- Alternate syntax: ST 8bitregister,NN or 16bitregister,NNNN or NNNN,NN...
- Use: This command is used to set a virtual register or memory address to a specific value.  To set an 8-bit register to a value, type the name of the register, followed by a comma,  followed by the 8-bit value to set it to.  Valid 8 bit registers are: A, B, C, D, E, H, L.  To set a 16-bit register to a value,  type the name of the register, followed by a comma, followed by the 16-bit value to set it to.  Valid 16-bit registers are: AF,  BC, DE, HL, IX.  To set memory addresses to values, type the beginning memory address, followed by a comma, followed by the string of data to load to those addresses.  If NN is not a valid 8-bit hexadecimal number, NNNN is not a valid 16-bit hexadecimal number, NN... is not a valid hexadecimal string, 8bitregister is not a valid 8-bit register, or 16bitregister is not a valid 16-bit register, you will receive an ERR: ARGUMENT.  If you try to set a memory address that is not located in RAM, you will receive an ERR: ARCHIVED.


#### SHOW

- Syntax: SHOW (register or NNNN)
- Alternate syntax: SH (register or NNNN)
- Use: This command displays the value of register 'register' or memory address NNNN.  If no arguments are present, the value of all the registers are displayed.

#### SUB:

- Syntax: SUB NNNN,NNNN
- Alternate syntax: none
- Use: This command subtracts two hexadecimal numbers and displays the result on the screen.


#### QUIT:

- Syntax: QUIT
- Alternate syntax: Q
- Use: This command returns to the main menu.


### VAT
The VAT bit of Calcsys allows you to view, and then hex edit the entries in both VATs (symbol tables).  When you first run the VAT section you will see a menu with these options:

1. Prog/List VAT
2. Symbol VAT
3. Applications
4. Hex ProgPtr
5. SymTable
6. Back

#### Prog/List VAT
This section lists all entries in the prog/list VAT (variable length symbol table).  The variable types in this VAT are:

- Application Variable
- Complex List
- Real List
- Group
- Program
- Protected Program

When you run the prog/list VAT, you will see a list of names and numbers.   The name is obviously the name of the variable and the number is the where that variable's VAT address is located.  Pressing 6 brings you to the next screen of variables (if one exists) and pressing 7 returns you to the main menu. By pressing the number cooresponding to the VAT entry you want, you will be taken to a more detailed description screen about that variable:

- Type - Lists the type of the variable (appvar,program,etc).
- Name - The name of the variable, as seen in previous listing.
- VAT Loc - The location of the VAT entry for the variable.
- Data Loc - The location of the data for the variable.
- Size - The size of the variable.
- Flash Page - The flash page where the variable is (this will not exist if the variable is not archived).

Keypresses that have an effect in the variable detail screen:

- Alpha+D - Disassemble at the data location of the variable.
- Alhpa+H - Hex edit at the data location of the variable.
- Alpha+V - Hex edit at the VAT location of the variable.
- Alpha+P - Toggles protection if the variable is a program

#### Symbol VAT
This section works exactly the same as the previous, except that it deals with variables in the non-prog/list VAT (which is everything that was not listed as being part of the prog/list VAT above).

#### Applications
This section lists and provides information about applications loaded on the calculator.  Listing is identical to the other VAT sections.  When you choose an application, a detailed info screen appears with the following data:

- Page - The flash page that the application is loaded one
- Name - The name of the application
- Size - The size of the application
- Pages - The number of flash pages that the application uses
- Type - Value from the header type field (0104 or 0102 for  shareware apps)
- ID - Value from header ID field
- Build - Value from header build field


#### Hex ProgPtr
This will hex edit the beginning of the prog/list VAT table aka (progptr).

#### Hex SymTable
This will hex edit the beginning of the non-prog/list VAT table aka SymTable.

#### Quit
Returns to the main menu.


### CHARACTER SET
This section of Calcsys is for displaying what characters and tokens are represented by which byte values.  When you run character set, you will be shown a menu with these options:

1. Font
2. Token
3. Back

#### Font
When you go to font, you will be prompted for a byte value. After it is entered, the cooresponding character will be displayed in both small and large fonts.

#### Token
When you choose token, you will be prompted for the first byte and second byte of the token, if the token only has one byte, enter zero as the first byte.  After you enter the data for the token, you will be shown the cooresponding token.

#### Quit
Returns to the main menu.


### KEY VALUES
This section of Calcsys displays the values returned for the different keypress detection methods.  Your choices are:

1. Getkey
2. Getcsc
3. Direct Input
4. Quit

#### Getkey
When you first run getkey, you will be shown a blank screen. If you press a button, the key value for that button is shown on the screen.  You can do this as long as you want, and the values will just scroll up on the screen.  Press the ON button to go back to the previous menu.

#### Getcsc
This is exactly like the previous section except that it returns values from the getcsc call, instead of the getkey call.

#### Direct Input
This section directly polls port 1 to see if any keys were pressed.  When a key is pressed, it shows the group number and the key number.  Like the other key press section, the ON button returns the the previous menu.

#### Quit
Returns to the main menu.


### LINK CONSOLE
The Link Console section of Calcsys allows you to communicate with other calculators and devices via the link port.  When you first start the Link Console, you will see a blank screen.  The Link Console screen is split as follows:

- The top 3 rows are used to show the values outputting to the port
- The bottom 5 rows show data inputted from the port

#### Outputting Data

There are three ways to output data in the Link Console, via a key press,  by outputting a direct hex value, or by a list of values.  To output a hex value, press the MODE button, then the 1 byte hex value that you want to  output.  (When you output a hex value, it is displayed in inverted text).
To output a list of values, hold the on button, press MODE, then type the address of the list of bytes you wish to output.  The first byte of the list should be the number of elements, followed by the one-byte elements. To output a value via key press, just press the cooresponding key.  
Important Keys:

- Letters    - Just press the letter key
- Numbers    - Hold ON, and press the number key
- Misc Chars - Press a top row key, or hold ON and press a top row key
- Hex $00    - Press 2nd (ON+2nd will have the same effect)
- Hex $01    - Hold ON, and press Alpha
- Hex $FF    - Press Alpha

#### Inputting Data
The Link Console is constantly polling the link port for incomming data. Whenever any data is detected, it will be displayed in the lower portion of the screen.  The format the data is displayed in is determined by the Link Console format flags.  By default, incoming data will be displayed as its ASCII character, as well as its hex value.

Press the X/T/0/n button to toggle between data being displayed as Hex Values, ASCII Text, both, or neither.

#### Quitting the Link Console
Press Clear to quit the Link Console and return to the Main Menu.

### ABOUT
This section provides version, author, and thanks information.


#### THANKS
Scott Dial - Beta testing.
Paul Fischer - Being particularly helpful with sdk stuff.
Jason Kovacs - Beta testing, suggestions, and reading over this doc.
Matthew Landry - Dunno, I forgot.
Andrew Magness - Beta testing.
Michael Vincent - Bug reports, testing.
Joe Wingbermuhle - ZLIB routines.


#### KNOWN BUGS
-None!



Thanks for reading!



