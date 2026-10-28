#!/usr/bin/env bash
# ============================================================
# Lab: Algoritmos de Criptografia Clássica e Moderna
# SENAC RJ – Cisco Cybersecurity
# Autor: Pedro Ferreira | 2026-10-28
# Ambiente: Kali Linux (openssl 3.x + python3)
# Referência: NetAcad / JCrypTool lab
# ============================================================

set -e

MENSAGEM="Criptografia e divertido. Voce consegue ler esta mensagem secreta?"
MENSAGEM_UPPER="CRIPTOGRAFIA E DIVERTIDO VOCE PODE LER ESTA MENSAGEM SECRETA"
CHAVE_AES="AA0000000000000000000000000000FF"

cesar() {
  # uso: cesar <shift> encrypt|decrypt
  local shift="$1"
  local op="$2"
  python3 -c "
import sys
shift = $shift
op = '$op'
for line in sys.stdin:
    result = ''
    for c in line.rstrip():
        if c.isalpha():
            base = ord('A') if c.isupper() else ord('a')
            if op == 'decrypt':
                result += chr((ord(c) - base - shift) % 26 + base)
            else:
                result += chr((ord(c) - base + shift) % 26 + base)
        else:
            result += c
    print(result)
"
}

sep() { echo ""; echo "============================================================"; echo "$1"; echo "============================================================"; }

sep "PARTE 1: Cifra de César (Algoritmo Clássico)"
echo "Mensagem original: $MENSAGEM_UPPER"
echo "Chave: K (shift=10)"
echo ""

CIFRADO=$(echo "$MENSAGEM_UPPER" | cesar 10 encrypt)
echo "Texto cifrado:          $CIFRADO"

DECIFRADO=$(echo "$CIFRADO" | cesar 10 decrypt)
echo "Texto descriptografado: $DECIFRADO"

echo ""
echo "--- Etapa 5: ROT13 (shift=13, maiúsculas e minúsculas) ---"
echo "Mensagem: $MENSAGEM"
ROT13=$(echo "$MENSAGEM" | python3 -c "import sys,codecs; print(codecs.encode(sys.stdin.read().rstrip(),'rot_13'))")
echo "ROT13:    $ROT13"
ROT13_DEC=$(echo "$ROT13" | python3 -c "import sys,codecs; print(codecs.encode(sys.stdin.read().rstrip(),'rot_13'))")
echo "Revertido: $ROT13_DEC"


sep "PARTE 2: AES-128-ECB (Criptografia Simétrica Moderna)"
echo "Mensagem: $MENSAGEM"
echo "Chave (hex): $CHAVE_AES"
echo ""

echo -n "$MENSAGEM" > /tmp/lab_cripto_original.txt

openssl enc -aes-128-ecb \
  -K "$CHAVE_AES" \
  -nosalt \
  -in /tmp/lab_cripto_original.txt \
  -out /tmp/lab_cripto_aes.bin

echo "AES-128-ECB cifrado (hex dump):"
xxd /tmp/lab_cripto_aes.bin

echo ""
openssl enc -d -aes-128-ecb \
  -K "$CHAVE_AES" \
  -nosalt \
  -in /tmp/lab_cripto_aes.bin \
  -out /tmp/lab_cripto_aes_dec.txt

echo "AES-128-ECB descriptografado: $(cat /tmp/lab_cripto_aes_dec.txt)"


sep "PARTE 3: RSA 1024-bit (Criptografia Assimétrica Moderna)"
mkdir -p /tmp/lab_rsa

echo "Gerando par de chaves RSA 1024-bit (equivalente a 'John Smith' no JCrypTool)..."
openssl genrsa -out /tmp/lab_rsa/privada.pem 1024 2>/dev/null
openssl rsa -in /tmp/lab_rsa/privada.pem -pubout -out /tmp/lab_rsa/publica.pem 2>/dev/null

echo "Chave pública gerada:"
cat /tmp/lab_rsa/publica.pem

echo ""
echo "Criptografando com chave pública..."
echo -n "$MENSAGEM" > /tmp/lab_rsa/original.txt
openssl pkeyutl -encrypt \
  -inkey /tmp/lab_rsa/publica.pem -pubin \
  -in /tmp/lab_rsa/original.txt \
  -out /tmp/lab_rsa/cifrado_rsa.bin

echo "RSA cifrado (hex dump):"
xxd /tmp/lab_rsa/cifrado_rsa.bin

echo ""
echo "Descriptografando com chave privada..."
openssl pkeyutl -decrypt \
  -inkey /tmp/lab_rsa/privada.pem \
  -in /tmp/lab_rsa/cifrado_rsa.bin \
  -out /tmp/lab_rsa/decifrado_rsa.txt

echo "RSA descriptografado: $(cat /tmp/lab_rsa/decifrado_rsa.txt)"


sep "Lab concluído com sucesso."
echo "Arquivos temporários:"
echo "  /tmp/lab_cripto_original.txt  — plaintext original"
echo "  /tmp/lab_cripto_aes.bin       — ciphertext AES"
echo "  /tmp/lab_rsa/                 — chaves e ciphertexts RSA"
echo ""
echo "Para limpar: rm -f /tmp/lab_cripto_* && rm -rf /tmp/lab_rsa"
