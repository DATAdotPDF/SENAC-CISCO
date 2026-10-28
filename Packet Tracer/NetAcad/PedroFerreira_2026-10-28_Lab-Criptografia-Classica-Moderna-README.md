# Lab — Algoritmos de Criptografia Clássica e Moderna

Este projeto documenta a conclusão do laboratório NetAcad "Use algoritmos de criptografia clássica e moderna", executado no Kali Linux com ferramentas de linha de comando (`openssl`, `python3`) como alternativa ao JCrypTool/CSE-LABVM.

## Objetivos

- Parte 1: Criptografar e descriptografar com a cifra de César (algoritmo clássico).
- Parte 2: Criptografar e descriptografar com AES-128-ECB (criptografia simétrica moderna).
- Parte 3: Gerar par de chaves RSA e criptografar/descriptografar com RSA 1024-bit (criptografia assimétrica moderna).

## Ambiente

| Item | Detalhe |
| --- | --- |
| SO | Kali Linux |
| Shell | Bash via kofterm |
| Ferramentas | `openssl` 3.x, `python3`, `xxd` |
| Referência original | JCrypTool (CSE-LABVM) |

---

## Parte 1 — Cifra de César (Algoritmo Clássico)

**Teoria:** A cifra de César substitui cada letra por outra deslocada N posições no alfabeto. Com chave `K` (shift=10), `A→K`, `B→L`, …, `Z→J`. É um tipo de cifra de substituição monoalfabética.

**Mensagem de entrada (maiúscula):**
```
CRIPTOGRAFIA E DIVERTIDO VOCE PODE LER ESTA MENSAGEM SECRETA
```

**Criptografar — chave K, shift=10:**
```bash
echo "CRIPTOGRAFIA E DIVERTIDO VOCE PODE LER ESTA MENSAGEM SECRETA" | \
python3 -c "
import sys
shift = 10
for line in sys.stdin:
    result = ''
    for c in line.rstrip():
        if c.isalpha():
            base = ord('A') if c.isupper() else ord('a')
            result += chr((ord(c) - base + shift) % 26 + base)
        else:
            result += c
    print(result)
"
```

**Descriptografar — aplicar shift=-10:**
```bash
echo "<TEXTO_CIFRADO>" | \
python3 -c "
import sys
shift = 10
for line in sys.stdin:
    result = ''
    for c in line.rstrip():
        if c.isalpha():
            base = ord('A') if c.isupper() else ord('a')
            result += chr((ord(c) - base - shift) % 26 + base)
        else:
            result += c
    print(result)
"
```

**Etapa 5 — ROT13 (shift=13, maiúsculas e minúsculas):**

ROT13 é um caso especial da cifra de César onde shift=13 é o próprio inverso (criptografar duas vezes recupera o original). Também cobre `a-z`.

```bash
echo "Criptografia e divertido. Voce consegue ler esta mensagem secreta?" | \
python3 -c "
import sys, codecs
for line in sys.stdin:
    print(codecs.encode(line.rstrip(), 'rot_13'))
"
```

**Vulnerabilidade:** Com apenas 26 chaves possíveis, a cifra de César é quebrável por força bruta em segundos, e vulnerável a análise de frequência.

---

## Parte 2 — AES-128-ECB (Criptografia Simétrica Moderna)

**Teoria:** O AES (Advanced Encryption Standard) usa a mesma chave para criptografar e descriptografar (simétrico). O modo ECB (Electronic Codebook) processa cada bloco de 16 bytes de forma independente.

**Mensagem de entrada:**
```
Criptografia e divertido. Voce consegue ler esta mensagem secreta?
```

**Chave (128 bits = 16 bytes):**
```
AA 00 00 00 00 00 00 00 00 00 00 00 00 00 00 FF
```
Representação hex para openssl: `AA0000000000000000000000000000FF`

**Criptografar:**
```bash
echo -n "Criptografia e divertido. Voce consegue ler esta mensagem secreta?" \
  > /tmp/original.txt
openssl enc -aes-128-ecb \
  -K AA0000000000000000000000000000FF \
  -nosalt \
  -in /tmp/original.txt \
  -out /tmp/cifrado_aes.bin
xxd /tmp/cifrado_aes.bin
```

**Descriptografar:**
```bash
openssl enc -d -aes-128-ecb \
  -K AA0000000000000000000000000000FF \
  -nosalt \
  -in /tmp/cifrado_aes.bin \
  -out /tmp/decifrado_aes.txt
cat /tmp/decifrado_aes.txt
```

**Observação sobre ECB:** Blocos idênticos de plaintext geram blocos idênticos de ciphertext — o que vaza padrões. Para dados reais, use `-aes-128-cbc` (com IV aleatório) ou `-aes-256-gcm` (com autenticação).

---

## Parte 3 — RSA 1024-bit (Criptografia Assimétrica Moderna)

**Teoria:** RSA usa um par de chaves matematicamente relacionadas. A chave pública criptografa; apenas a chave privada correspondente descriptografa. Adequado para troca segura de chaves e assinaturas digitais.

**Gerar par de chaves RSA 1024-bit (equivalente a "John Smith" no JCrypTool):**
```bash
mkdir -p /tmp/lab_rsa
openssl genrsa -out /tmp/lab_rsa/privada.pem 1024
openssl rsa -in /tmp/lab_rsa/privada.pem -pubout -out /tmp/lab_rsa/publica.pem
```

**Inspecionar as chaves:**
```bash
openssl rsa -in /tmp/lab_rsa/privada.pem -text -noout | head -20
cat /tmp/lab_rsa/publica.pem
```

**Criptografar com chave pública:**
```bash
echo -n "Criptografia e divertido. Voce consegue ler esta mensagem secreta?" \
  > /tmp/lab_rsa/original.txt
openssl pkeyutl -encrypt \
  -inkey /tmp/lab_rsa/publica.pem -pubin \
  -in /tmp/lab_rsa/original.txt \
  -out /tmp/lab_rsa/cifrado_rsa.bin
xxd /tmp/lab_rsa/cifrado_rsa.bin
```

**Descriptografar com chave privada:**
```bash
openssl pkeyutl -decrypt \
  -inkey /tmp/lab_rsa/privada.pem \
  -in /tmp/lab_rsa/cifrado_rsa.bin \
  -out /tmp/lab_rsa/decifrado_rsa.txt
cat /tmp/lab_rsa/decifrado_rsa.txt
```

**Observações:**
- RSA 1024-bit é usado aqui por paridade com o JCrypTool. Em produção, use **mínimo 2048-bit** (NIST recomenda 3072+).
- RSA direto limita o tamanho da mensagem (máx. ~117 bytes para 1024-bit com PKCS#1 v1.5). Para mensagens longas, use **criptografia híbrida**: RSA para trocar a chave AES, AES para cifrar o conteúdo.
- `pkeyutl` substitui o depreciado `rsautl` no OpenSSL 3.x.

---

## Comparação dos algoritmos

| Algoritmo | Tipo | Tamanho de chave | Segurança | Caso de uso |
| --- | --- | --- | --- | --- |
| Cifra de César | Clássico (substituição) | 1 byte (shift 1-25) | Nenhuma | Histórico / educacional |
| AES-128-ECB | Simétrico moderno | 128 bits (16 bytes) | Forte (ECB: evitar) | VPN, armazenamento |
| RSA-1024 | Assimétrico moderno | Par 1024 bits | Fraca (abaixo do mínimo) | TLS, assinatura digital |

---

## Script completo

O script [`PedroFerreira_2026-10-28_lab-criptografia.sh`](PedroFerreira_2026-10-28_lab-criptografia.sh) executa as três partes em sequência. Para rodar no Kali via kofterm:

```bash
bash PedroFerreira_2026-10-28_lab-criptografia.sh
```

## Contribuição kofterm

As receitas e entradas de índice para `openssl` e cifra de César estão em
[`../../CODEX/kofterm/PedroFerreira_2026-10-28_kofterm-receitas-criptografia.txt`](../../CODEX/kofterm/PedroFerreira_2026-10-28_kofterm-receitas-criptografia.txt),
prontas para PR ao repositório [DATAdotPDF/kofterm](https://github.com/DATAdotPDF/kofterm).

---

## Arquivos

- `PedroFerreira_2026-10-28_Lab-Criptografia-Classica-Moderna-README.md` — este arquivo.
- `PedroFerreira_2026-10-28_lab-criptografia.sh` — script Bash para Kali Linux.

Atividade concluída em 2026-10-28. Projeto acadêmico de estudo — não use as chaves deste lab em produção.
