	.text
	.global setalt 

setalt:
	.include "savereg.i"
	mov x19,x0   		// pointer to iomem
	mov x20,x1		// pin index
	mov x21,x2		// alt mode
	bl setinput

	mov x22,#10
	udiv x23,x20,x22	//mod 10
	msub x5,x23,x22,x20      //x23 is now quotient, x5 remainder
				//x5 is register, x23 - 3 bit control set offset+1

	mov x22,#4
deb:	mul x4,x23,x22		//calculate address offset	
	add x19,x19,x4	

	ldr w23,[x19]    //w23 is value from 32bit control register

	cmp w21,#3
	ble plusfour
	cmp w21,#4
	beq setalt4
	cmp w21,#5
	beq set2
	b setalt0
plusfour:
	add w24,w21,#4
	b maskset
setalt4:
	mov w24,#3
	b maskset
set2:
	mov w24,#2
	b maskset
setalt0:
	mov w24,#4
maskset:
	mov w25,w5	  	//copy offset

	mov w22,#3
	mul w25,w25,w22	        //3 bits per control set

	lsl w24,w24,w25		//shift mask into position
	orr w23,w23,w24		//	

	str 	w23,[x19]	//return modified value to control register	
	.include "restreg.i"
	ret
