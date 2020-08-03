.text
.global readpin

readpin:
	.include "savereg.i"
	mov x21,x0 //x0 is the base address of the gpiomem mmap
	mov x22,x1 //x1 is our pin 

	ldr w19,[x21,0x34]

	mov w20,#1
	//sub x26,x22,#1
	lsl w20,w20,w22
	and w19,w19,w20
	lsr w19,w19,w22	
	mov w0,w19
	.include "restreg.i"
	ret
.data
