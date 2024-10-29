# CD-SingleCycleProcessor
Single Cycle Processor Implementation of WISC-FA24 ISA Without Pipelining and Other Optimizations (Project 1). All Implementation details are provided in Phase1-ProjectDescription.pdf


Please note that it is practically impossible to run the CPU with this given directory structure and is purely for the purpose of aesthetic storage. In order to run it using Icarus, it 
is recommended to dump all src files into a single folder (with no hierarchy) and use it in the phase1_cpu_tb.v's compilation path. Test cases can be easily assembled using assembler.pl (provided by instructors)
into a file known as "loadfile_instr.img" that is used to load into Instruction Memory of the CPU (I-Mem and D-Mem were also provided inside the IP directory).

Processor runs very smoothly. Of course it doesn't take advantage of pipelined optimization, forwarding, etc but those shall be implemented in Phase 2.


I will maybe at some point add an image/block diagram of this CPU design once I've figured out how to make them digitally with minimal effort! Until then look at your textbooks.