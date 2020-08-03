	.text
	.global setinput

setinput:
	.include "savereg.i"
	mov x19,x0   		// pointer to iomem
	mov x20,x1		// pin index
	mov x21,#10

	udiv x22,x20,x21	//mod 10
	msub x2,x22,x21,x20      //x22 is now quotient, x2 remainder
				//x2 is register, x22 - 3 bit control set offset+1

	mov x21,#4
	mul x4,x22,x21		//calculate address offset	
	add x19,x19,x4	

	ldr w23,[x19]    //w23 is value from 32bit control register

	mov w24,#7	        //set bit-mask
	mov w25,w2	  	//copy offset
	//sub w25,w25,#1		//sub 1 for shift

	mov w21,#3
	mul w25,w25,w21	        //3 bits per control set

	lsl w24,w24,w25		//shift mask into position
	mov w5,0xffffffff	//negate mask
	eor w24,w24,w5		//	
	
	and w23,w23,w24		//clear all bits in control set for pin to
				//set input mode, leave other bits alone	

	str 	w23,[x19]	//return modified value to control register	
	.include "restreg.i"
	ret
