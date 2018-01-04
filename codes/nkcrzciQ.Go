package aesctr

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/hmac"
	"crypto/rand"
	"crypto/sha256"
	"crypto/subtle"
	"encoding/base64"
	"errors"

	"golang.org/x/crypto/pbkdf2"
)

func Encrypt(plaintext, key []byte) (string, error) {
	if len(key) < 20 {
		return "", errors.New("key is too short, the minimum length is 20 characters")
	}
	encryptionKey, hmacKey, salt, err := generateKeys(key)
	if err != nil {
		return "", err
	}
	block, err := aes.NewCipher(encryptionKey)
	if err != nil {
		return "", err
	}
	ciphertext := make([]byte, aes.BlockSize+len(plaintext))
	iv := ciphertext[:aes.BlockSize]
	if _, err := rand.Read(iv); err != nil {
		return "", err
	}
	stream := cipher.NewCTR(block, iv)
	stream.XORKeyStream(ciphertext[aes.BlockSize:], plaintext)
	hmac := generateHMAC(ciphertext, hmacKey)
	ciphertext = append(salt, ciphertext...)
	ciphertext = append(hmac, ciphertext...)
	return base64.StdEncoding.EncodeToString(ciphertext), nil
}

func Decrypt(b64ciphertext string, key []byte) ([]byte, error) {
	ciphertext, err := base64.StdEncoding.DecodeString(b64ciphertext)
	var plaintext []byte
	if err != nil {
		return plaintext, err
	}
	hmac, salt, ciphertext := ciphertext[:32], ciphertext[32:96], ciphertext[96:]
	iv := ciphertext[:aes.BlockSize]
	encryptionKey, hmacKey := deriveKey(key, salt[:32]), deriveKey(key, salt[32:])
	hmacNew := generateHMAC(ciphertext, hmacKey)
	if subtle.ConstantTimeCompare(hmac, hmacNew) != 1 {
		return plaintext, errors.New("invalid hmac")
	}
	block, err := aes.NewCipher(encryptionKey)
	if err != nil {
		return plaintext, err
	}
	stream := cipher.NewCTR(block, iv)
	plaintext = make([]byte, len(ciphertext)-aes.BlockSize)
	stream.XORKeyStream(plaintext, ciphertext[aes.BlockSize:])
	return plaintext, nil
}

func generateHMAC(message, key []byte) []byte {
	mac := hmac.New(sha256.New, key)
	mac.Write(message)
	return mac.Sum(nil)
}

func generateKeys(key []byte) ([]byte, []byte, []byte, error) {
	salt := make([]byte, 64)
	if _, err := rand.Read(salt); err != nil {
		return nil, nil, nil, err
	}
	encryptionKey, hmacKey := deriveKey(key, salt[:32]), deriveKey(key, salt[32:])
	return encryptionKey, hmacKey, salt, nil
}

func deriveKey(key, salt []byte) []byte {
	return pbkdf2.Key(key, salt, 1<<16, 32, sha256.New)
}