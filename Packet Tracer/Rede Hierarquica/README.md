# TAREFA 5 — Rede Hierárquica Cisco (3 Camadas)

**Aluno:** Pedro Ferreira  
**Entrega:** 09/11/2026  
**Arquivo:** `aula-04-11-26.pkt`

---

## Topologia

Modelo hierárquico Cisco de 3 camadas:

```
[ Internet ]
      |
  [ R1-FW ]  ← Cisco 2911 — roteamento + firewall
      |
  [ DMZ: 192.168.100.0/24 ]
  WEB-SRV (.10) | FTP-SRV (.20) | EMAIL-SRV (.30) | DNS-SRV (.40)
      |
  [ SWd1 ] ─── [ SWd2 ]   ← Cisco 3560-24PS — distribuição (multilayer)
   /    \           |
 [S1]  [S2]       [S3] [S4]  ← Cisco 2960-24TT — acesso
```

---

## VLANs

| VLAN | Nome       | Rede            | Gateway       |
|------|------------|-----------------|---------------|
| 10   | Usuários   | 10.10.10.0/24   | 10.10.10.1    |
| 20   | VoIP/MKT   | 10.20.20.0/24   | 10.20.20.1    |
| 30   | Gerência   | 10.30.30.0/24   | 10.30.30.1    |
| 99   | Nativa     | —               | —             |

---

## Configurações Implementadas

### R1-FW (Cisco 2911)
- Sub-interfaces router-on-a-stick: `Gi0/2.10`, `Gi0/2.20`, `Gi0/2.30`
- Pool DHCP por VLAN (VLAN10-USUARIOS, VLAN20-VOIP, VLAN30-GERENCIA)
- Interface DMZ: `Gi0/0` → 192.168.100.1/24
- SSH habilitado — `ip domain-name empresa.local`, `username admin`

### SWd1 / SWd2 (Cisco 3560-24PS — Distribuição)
- VTP Server (SWd1) / VTP Client (SWd2)
- VTP domain: `EMPRESA`, password: `Vtp@2024`
- Trunks para switches de acesso e uplink para R1-FW
- Rapid-PVST+ como protocolo STP

### S1 (Cisco 2960-24TT — Acesso)
- VTP Client, domain EMPRESA
- Uplink trunk: `Fa0/20` → SWd1
- Portas acesso: `Fa0/1–8` → VLAN 10
- VLAN 30 (gerência): IP `10.30.30.13/24`, gateway `10.30.30.1`
- Port-security: sticky MAC, max 2, violation restrict
- Spanning-tree portfast + bpduguard nas portas de acesso
- SSH: `username admin privilege 15`

### S2 (Cisco 2960-24TT — Acesso)
- VTP Client, domain EMPRESA
- Uplink trunk: `Fa0/20` → SWd1
- Portas acesso: `Fa0/1–8` → VLAN 10
- VLAN 30 (gerência): IP `10.30.30.14/24`, gateway `10.30.30.1`
- Port-security, portfast, bpduguard, SSH configurados

### S3 (Cisco 2960-24TT — Acesso)
- VTP Client, domain EMPRESA
- Uplink trunk: `Fa0/3` → SWd2 (nativa VLAN 99)
- Portas acesso: `Fa0/1–8` → VLAN 20 (VoIP/MKT)
- VLAN 30 (gerência): IP `10.30.30.15/24`, gateway `10.30.30.1`
- Port-security, portfast, bpduguard, SSH configurados

### S4 (Cisco 2960-24TT — Acesso)
- VTP Client, domain EMPRESA
- Uplink trunk: `Gi0/2` → SWd2 (nativa VLAN 99)
- Portas acesso: `Fa0/1–8` → VLAN 20 (VoIP/MKT)
- VLAN 30 (gerência): IP `10.30.30.16/24`, gateway `10.30.30.1`
- Port-security, portfast, bpduguard, SSH configurados

### DNS-SRV (192.168.100.40)
- Status: **On**
- Registros A:
  - `www.empresa.local` → 192.168.100.10
  - `ftp.empresa.local` → 192.168.100.20
  - `mail.empresa.local` → 192.168.100.30
  - `dns.empresa.local` → 192.168.100.40

### EMAIL-SRV (192.168.100.30)
- Domain: `empresa.local`
- SMTP: **On** | POP3: **On**
- Usuários: `usuario1`, `usuario2`, `admin` (senha: `Cisco@2024`)

---

## Credenciais Padrão

| Dispositivo | Usuário | Senha       |
|-------------|---------|-------------|
| Todos       | admin   | Cisco@2024  |
| Enable      | —       | Cisco@2024  |
| VTP         | —       | Vtp@2024    |

---

## Status

- [x] S1–S4 configurados (VLANs, trunk, VTP, SSH, port-security)
- [x] R1-FW configurado (sub-interfaces, DHCP, DMZ)
- [x] DNS-SRV — Service ON, 4 registros A configurados via GUI
- [x] EMAIL-SRV — domínio empresa.local, SMTP/POP3 ON, 3 contas configuradas via GUI
- [x] S3/S4 — trunks uplink corrigidos (Fa0/3 / Gi0/2), VLAN 20 nas portas de acesso
- [x] DHCP — pools VLAN10/20/30 ativos no R1-FW; `ip dhcp snooping trust` em SWd2 Gi0/2 (uplink)
