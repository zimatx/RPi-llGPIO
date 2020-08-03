	.text
	.global assert

assert:
	.include "savereg.i"
	mov x23,x0
	mov x24,x1
	mov x19,#1
	lsl x19,x19,x24
	str w19,[x23,0x1c]
	.include "restreg.i"
	ret
.data
