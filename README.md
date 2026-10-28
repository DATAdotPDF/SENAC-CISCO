# NetAcad Study Collection

This branch is the study archive for the SENAC RJ Cisco Cybersecurity course. It preserves Packet Tracer activities, guided exercises, reference files, and visual evidence collected while learning Cisco networking and security.

## Scope

The original archive contains 47 study and reference files. This branch adds a README so the collection has a clear entry point.

| Format | Quantity | Typical use |
|---|---:|---|
| `.pka` | 32 | Guided Packet Tracer activities |
| `.pksz` | 3 | Tutored or packaged Packet Tracer activities |
| `.pkt` | 4 | Saved topology exercises |
| `.zip` | 1 | Study archive |
| `.png` | 5 | Physical and logical evidence |
| `.htm` | 1 | Activity reference page |
| `.txt` | 1 | Configuration notes |

## Visual study evidence

![Logical topology study](packet-tracer/NetAcad/PedroFerreira-topologia-logica.png)

![Physical topology study](packet-tracer/NetAcad/PedroFerreira-topologia-fisica.png)

The remaining building and provider images are linked in the [collection README](packet-tracer/NetAcad/README.md).

## Learning path

1. Start with simple LAN creation and basic Packet Tracer navigation.
2. Practice `ipconfig`, `ping`, MAC and IP identification, and Web requests.
3. Configure DHCP, wireless routers, wireless clients, and basic wireless security.
4. Explore NAT, FTP, DNS, Web services, and routed traffic.
5. Study ACLs, data and file integrity, threat scenarios, and physical security with IoT.
6. Reopen the saved `.pkt` files and compare the topology with the written configuration notes.

## How to use an activity

1. Read the activity name and identify whether it is a `.pka`, `.pksz`, or `.pkt` file.
2. Open it with a Cisco Packet Tracer version that supports the file format.
3. Read the instructions inside the activity before changing the topology.
4. Record the addressing, device names, and expected result.
5. Complete the guided steps and use the Check Results view when the activity provides one.
6. Test the result with the relevant Packet Tracer command or client application.
7. Save a separate working copy when the original activity must remain unchanged.

## Main study themes

### Network fundamentals

Simple networks, LAN construction, IP and MAC identification, `ipconfig`, ping, and basic routed traffic.

### Services

DHCP, DNS, Web, FTP, and NAT exercises show how clients receive addresses and reach local or external services.

### Wireless

The archive includes wireless router setup, DHCP on a wireless router, client association, wireless troubleshooting, and basic wireless security.

### Security

ACL demonstrations, access control, data and file integrity, threat scenarios, and physical security with IoT devices connect the Packet Tracer practice to the course cybersecurity topics.

### Cryptography

The [cryptography challenge](criptografia/PedroFerreira_2026-10-28_Desafio-Criptografia/README.md) follows the CSE-LABVM lab that uses JCrypTool for classical, symmetric and asymmetric algorithms. It has seven exercises, one for each group of JCrypTool's Crypto Explorer: Caesar, AES, RSA, hash, HMAC, random numbers and digital signatures. Each exercise can be solved in JCrypTool and in a Linux terminal with `openssl` and `python3`. Answers are checked by their SHA-256, and the solutions show every command with its real output. The challenge is in Portuguese, with an [English version](criptografia/PedroFerreira_2026-10-28_Desafio-Criptografia/en/README.md) that has its own files and answers.

## Files

All original study files are under [`packet-tracer/NetAcad/`](packet-tracer/NetAcad/). The collection README includes the local source path, the complete file list, and the study boundary.

- [NetAcad collection README](packet-tracer/NetAcad/README.md)
- [Logical topology image](packet-tracer/NetAcad/PedroFerreira-topologia-logica.png)
- [Physical topology image](packet-tracer/NetAcad/PedroFerreira-topologia-fisica.png)
- [Configuration notes](packet-tracer/NetAcad/PedroFerreira-configuracoes.txt)
- [Saved topology](packet-tracer/NetAcad/PedroDFerreira-prjrede.pkt)
- [Cryptography challenge](criptografia/PedroFerreira_2026-10-28_Desafio-Criptografia/README.md) ([English](criptografia/PedroFerreira_2026-10-28_Desafio-Criptografia/en/README.md))

## Study boundary

These files are academic exercises. They are useful for learning commands and behavior inside Packet Tracer. They are not production network designs. Passwords and private tokens are not published. Original filenames are preserved so the activities can be matched with their course references.

## Author

Pedro Dutra Ferreira

Cisco Cybersecurity Course

Senac RJ
