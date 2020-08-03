	.text
	.global openiomem
	
openiomem:
	.include "savereg.i"	
	adr	x0, gpiomemfn
	mov	x1, #2 
	bl open
	mov x4, x0
	mov x0,#0
	mov x1,#4096
	mov x2,#3		
	mov x3,#1
	mov x5,#0
	bl mmap
	.include "restreg.i"
	ret

.data
gpiomemfn:	.asciz "/dev/gpiomem"

