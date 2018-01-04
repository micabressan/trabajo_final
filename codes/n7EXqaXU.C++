	asm {
		cli
		push ax
		mov starSP, sp
		mov starSS, ss
		mov sp, noviSP
		mov ss, noviSS
		mov oldax, ax
		pushf
		pop ax
		or ax, 200h //interupt enable
		push ax
		mov ax, contSEG
		push ax
		mov ax, contOFF
		push ax
		mov ax, oldax
		push ax
		push bx
		push cx
		push dx
		push es
		push ds
		push si
		push di
		mov ax, 0h //bp
		push ax
		mov ax, oldax
		mov noviSP, sp
		mov noviSS, ss
		mov sp, starSP
		mov ss, starSS
		//mov bp, starBP
		pop ax
		sti
	}
sPoint = noviSP;
sSegment = noviSS;
}