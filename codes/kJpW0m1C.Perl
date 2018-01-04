automacro cflecha {
inventory "Flecha" <= 10
run-once 1
	call {
	pause 1
	do move 156 100 payon
	do talknpc 159 96 b b0,20
	pause 1
	release cflecha
	}
}