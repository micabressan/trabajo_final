package main

import (
	"crypto/sha256"
	"fmt"
)

func main() {

	//This is value of OTP1. We can successfully log into our docker server using this as the password. It is also correctly formatted.
	otp1 := []byte{0x20, 0x06, 0x85, 0x64, 0xf4, 0x10, 0xb3, 0x99, 0xa2, 0xeb, 0xba, 0x07, 0xac, 0xd0, 0x7e, 0xd4, 0xc7, 0x20,
		0xd6, 0x85, 0x23, 0x84, 0x21, 0x5c, 0xb4, 0x9c, 0xf4, 0xc1, 0x58, 0x97, 0xac, 0x9f, 0xbe, 0x06, 0x86, 0x64,
		0xf4, 0x10, 0xb3, 0x99, 0xa2, 0xeb, 0xba, 0x07, 0xac, 0xd0, 0x7e, 0xd4, 0xc7, 0x20, 0xd6, 0x85, 0x23, 0x84,
		0x21, 0x5c, 0xb4, 0x9c, 0xf4, 0xc1, 0x58, 0x97, 0xac, 0x9f, 0xbe}

	//Since the OTP is in the format [length][otp][otp], we need to only hash the OTP value
	//So we are only hashing bytes 1 - 33.
	expected_hash := sha256.Sum256(otp1[1:33])
	fmt.Printf("Expected Hash:[%x]\n", expected_hash)

	//These bytes are the same as the first four of the expect_hash
	//bytes := []byte{0xee, 0x3a, 0x56, 0x82}

	//These are the bytes that generate the collision
	//match := []byte{0xde, 0x72, 0x7a, 0x92}

	fmt.Println("Searching for partial collision..")
	for b1 := 0x0; b1 <= 0xFF; b1++ {
		for b2 := 0x0; b1 <= 0xFF; b2++ {
			for b3 := 0x0; b1 <= 0xFF; b3++ {
				for b4 := 0x0; b1 <= 0xFF; b4++ {
					//Generate a []byte using our loop vars
					buffer := []byte{byte(b1), byte(b2), byte(b3), byte(b4)}

					//Hash them
					hash := sha256.Sum256(buffer)

					//Compare the first 4 bytes of the hash with our expected hash
					if bytesEqual(hash[:], expected_hash[:], 4) {
						fmt.Printf("Collision found!\nBytes:%x\nGenerated Hash:%x\n", buffer, hash)
						break
					}

				}
			}
		}
	}
}

//This will compare two byte arrays up the the length l. So if we only want to compare 4 bytes,
//We pass 4 as the length.
func bytesEqual(a, b []byte, l int) bool {
	for i := 0; i < l; i++ {
		if a[i] != b[i] {
			return false
		}
	}
	return true
}