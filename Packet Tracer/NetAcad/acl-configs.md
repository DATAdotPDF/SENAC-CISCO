# ACL Configurations — NetAcad Activities

## 1. Configurar ACLs IPv4 padrão numeradas.pka
**Dispositivo:** R1 (index 2, modelo 1841)

```
! ACL 1 — bloqueia host específico, permite rede
R1(config)# access-list 1 deny host 192.168.11.10
R1(config)# access-list 1 permit 192.168.11.0 0.0.0.255
R1(config)# interface S0/0/0
R1(config-if)# ip access-group 1 out

! ACL 2 — permite só host de gestão no VTY
R1(config)# access-list 2 permit host 192.168.11.10
R1(config)# line vty 0 4
R1(config-line)# access-class 2 in
```

---

## 2. Configuração de ACLs IPv4 nomeadas padrão.pka
**Dispositivo:** R1 (index 2, modelo 1841)

```
! PERMIT_HOST — permite host de gestão
R1(config)# ip access-list standard PERMIT_HOST
R1(config-std-nacl)# permit host 192.168.11.10

! DENY_HOST — nega host específico
R1(config)# ip access-list standard DENY_HOST
R1(config-std-nacl)# deny host 192.168.11.10
R1(config-std-nacl)# permit any
```

---

## 3. configurar o cenário de ACLs estendidas 1.pka
**Dispositivo:** R1 (index 1, modelo 2911 — configurado via IPC)

```
! ACL 100 — permite FTP e ICMP da subnet de engenharia para o servidor
! Aplicada inbound em GigabitEthernet0/0
access-list 100 permit tcp 172.22.34.64 0.0.0.31 host 172.22.34.62 eq ftp
access-list 100 permit icmp 172.22.34.64 0.0.0.31 host 172.22.34.62

! HTTP_ONLY — permite HTTP e ICMP da subnet de vendas para o servidor
! Aplicada inbound em GigabitEthernet0/1
access-list HTTP_ONLY permit tcp 172.22.34.96 0.0.0.15 host 172.22.34.62 eq www
access-list HTTP_ONLY permit icmp 172.22.34.96 0.0.0.15 host 172.22.34.62
```

> Configurado via IPC (`AclProcess.addAcl` + `addStatement` + `RouterPort.setAclInID`)
> pois o modelo 2911 não responde ao `getCommandLine().enterCommand()` em atividades .pka.

---

## 4. Configurar Cenário de ACLs estendidas 2.pka
**Dispositivo:** RT1 (index 5, modelo 2911 — configurado via IPC)

```
! ACL "ACL" — aplicada inbound em GigabitEthernet0/0
! PC1 (172.31.1.101) — bloqueia HTTP e HTTPS para Server1 e Server2
access-list ACL deny tcp host 172.31.1.101 host 64.101.255.254 eq 80
access-list ACL deny tcp host 172.31.1.101 host 64.101.255.254 eq 443
access-list ACL deny tcp host 172.31.1.101 host 64.103.255.254 eq 80
access-list ACL deny tcp host 172.31.1.101 host 64.103.255.254 eq 443
! PC2 (172.31.1.102) — bloqueia FTP para Server1 e Server2
access-list ACL deny tcp host 172.31.1.102 host 64.101.255.254 eq 21
access-list ACL deny tcp host 172.31.1.102 host 64.103.255.254 eq 21
! PC3 (172.31.1.103) — bloqueia ICMP para Server1 e Server2
access-list ACL deny icmp host 172.31.1.103 host 64.101.255.254
access-list ACL deny icmp host 172.31.1.103 host 64.103.255.254
! Permit implícito
access-list ACL permit ip any any
```

> Configurado via IPC por ser modelo 2911.

---

## 5. Configurar ACLs IPv6.pka
**Topologia:** R1 (index 0), R3 (index 2)

### R1 — BLOCK_HTTP (inbound GigabitEthernet0/1)
```
R1(config)# ipv6 access-list BLOCK_HTTP
R1(config-ipv6-acl)# deny tcp any host 2001:DB8:1:30::30 eq 80
R1(config-ipv6-acl)# deny tcp any host 2001:DB8:1:30::30 eq 443
R1(config-ipv6-acl)# permit ipv6 any any
R1(config)# interface GigabitEthernet0/1
R1(config-if)# ipv6 traffic-filter BLOCK_HTTP in
```

### R3 — BLOCK_ICMP (outbound GigabitEthernet0/0)
```
R3(config)# ipv6 access-list BLOCK_ICMP
R3(config-ipv6-acl)# deny icmp any any
R3(config-ipv6-acl)# permit ipv6 any any
R3(config)# interface GigabitEthernet0/0
R3(config-if)# ipv6 traffic-filter BLOCK_ICMP out
```

> Configurado via `getCommandLine().enterCommand()` (CLI funciona nestas 1941).
> `Aclv6Process.addAcl().addStatement()` não suporta endereços IPv6 — retorna `false`.

---

## 6. packet-tracer-configure-ip-acls-to-mitigate-attacks.pksz
**Atividade 4.6.5 / 8.6.5 — Topologia:** R1, R2, R3 (modelo 1941), PC-A (server), PC-C (mgmt)
**Credenciais:** enable `ciscoenpa55` · console `ciscoconpa55` · SSH `SSHadmin/ciscosshpa55`

### Part 2 — ACL 10: acesso remoto só de PC-C (192.168.3.3)
```
! Aplicado em R1, R2 e R3
access-list 10 permit host 192.168.3.3

line vty 0 4
 access-class 10 in
```

### Part 3 + 4 — ACL 120 em R1 (inbound S0/0/0)
```
! Permite DNS, SMTP, FTP ao PC-A; nega HTTPS; permite SSH de PC-C ao R1
access-list 120 permit udp any host 192.168.1.3 eq domain
access-list 120 permit tcp any host 192.168.1.3 eq smtp
access-list 120 permit tcp any host 192.168.1.3 eq ftp
access-list 120 deny tcp any host 192.168.1.3 eq 443
access-list 120 permit tcp host 192.168.3.3 host 10.1.1.1 eq 22
! ICMP: permite echo-reply e unreachable, nega o resto
access-list 120 permit icmp any any echo-reply
access-list 120 permit icmp any any unreachable
access-list 120 deny icmp any any
access-list 120 permit ip any any

interface s0/0/0
 ip access-group 120 in
```

### Part 5 — ACL 110 em R3 (inbound G0/1) — anti-spoofing saída
```
access-list 110 permit ip 192.168.3.0 0.0.0.255 any

interface g0/1
 ip access-group 110 in
```

### Part 6 — ACL 100 em R3 (inbound S0/0/1) — bloqueia RFC 1918 + loopback + multicast de entrada
```
! Permite SSH vindo de 10.x.x.x de volta para PC-C
access-list 100 permit tcp 10.0.0.0 0.255.255.255 eq 22 host 192.168.3.3
! Bloqueia endereços privados / especiais vindos de fora
access-list 100 deny ip 10.0.0.0 0.255.255.255 any
access-list 100 deny ip 172.16.0.0 0.15.255.255 any
access-list 100 deny ip 192.168.0.0 0.0.255.255 any
access-list 100 deny ip 127.0.0.0 0.255.255.255 any
access-list 100 deny ip 224.0.0.0 15.255.255.255 any
access-list 100 permit ip any any

interface s0/0/1
 ip access-group 100 in
```

---

## 7. packet-tracer-configure-a-zpf.pksz
**Atividade ZPF — Topologia:** R1, R2, R3 (modelo 1941), S1, S3, PC-A (server 192.168.1.x), PC-C (192.168.3.x)
**Endereçamento pré-configurado:**
- R1: G0/1=192.168.1.1/24 (LAN), S0/0/0=10.1.1.1/30 → R2
- R2: S0/0/0=10.1.1.2/30, S0/0/1=10.2.2.2/30 (simula Internet)
- R3: S0/0/1=10.2.2.1/30 → R2, G0/1=192.168.3.1/24 (LAN)
- Rotas: default estática em R1 e R3 via R2

### ZPF em R3 (firewall de borda)

```
! 1. Criar zonas de segurança
R3(config)# zone security IN-ZONE
R3(config)# zone security OUT-ZONE

! 2. ACL para identificar tráfego interno
R3(config)# ip access-list extended INSIDE-NET
R3(config-ext-nacl)# permit ip 192.168.3.0 0.0.0.255 any

! 3. Class-map: inspeciona TCP, UDP e ICMP vindos de dentro
R3(config)# class-map type inspect match-all INSIDE-PROTOCOLS
R3(config-cmap)# match access-group name INSIDE-NET
R3(config-cmap)# match protocol tcp
R3(config-cmap)# match protocol udp
R3(config-cmap)# match protocol icmp

! 4. Policy-map: ação inspect (stateful) para o tráfego classificado
R3(config)# policy-map type inspect IN-2-OUT-PMAP
R3(config-pmap)# class type inspect INSIDE-PROTOCOLS
R3(config-pmap-c)# inspect

! 5. Zone-pair: aplica a policy de IN-ZONE → OUT-ZONE
R3(config)# zone-pair security IN-2-OUT-ZPAIR source IN-ZONE destination OUT-ZONE
R3(config-sec-zone-pair)# service-policy type inspect IN-2-OUT-PMAP

! 6. Atribuir interfaces às zonas
R3(config)# interface GigabitEthernet0/1
R3(config-if)# zone-member security IN-ZONE
R3(config)# interface Serial0/0/1
R3(config-if)# zone-member security OUT-ZONE
```

> ZPF configurado via `getCommandLine().enterCommand()` — modelo 1941 responde ao CLI.
> Tráfego de OUT-ZONE → IN-ZONE bloqueado por padrão (ZPF deny implícito).
> `.pksz` é sealed — configuração avaliada pelo activity checker do PT.
