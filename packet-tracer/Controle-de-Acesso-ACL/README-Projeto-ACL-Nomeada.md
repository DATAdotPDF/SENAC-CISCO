# Named Standard ACL Study Project

This NetAcad study project follows the named standard IPv4 ACL activity from the Packet Tracer PKA.

## Objective

Protect the File Server so that only PC1, the Web Manager workstation, and the Web Server can reach it. All three PCs must keep access to the Web Server.

## Topology

- R1 FastEthernet0/0: 192.168.100.1/24
- R1 FastEthernet0/1: 192.168.200.1/24
- R1 Ethernet0/0/0: 192.168.10.1/24
- R1 Ethernet0/1/0: 192.168.20.1/24
- File Server: 192.168.200.100/24, gateway 192.168.200.1
- Web Server: 192.168.100.100/24, gateway 192.168.100.1
- PC0: 192.168.20.3/24, gateway 192.168.20.1
- PC1: 192.168.20.4/24, gateway 192.168.20.1
- PC2: 192.168.10.3/24, gateway 192.168.10.1

## ACL configuration

The ACL name and statement order match the PKA exactly:

```
ip access-list standard File_Server_Restrictions
 permit host 192.168.20.4
 permit host 192.168.100.100
 deny any
```

It is applied outbound on R1 FastEthernet0/1:

```
interface FastEthernet0/1
 ip access-group File_Server_Restrictions out
```

## Verification

Before the ACL, all six paths passed with 4/4 replies:

- PC0, PC1, and PC2 to the Web Server
- PC0, PC1, and PC2 to the File Server

After the ACL:

- PC0, PC1, and PC2 to the Web Server: 4/4
- PC1 to the File Server: 4/4
- Web Server to the File Server: 4/4
- PC0 to the File Server: blocked with `Destination host unreachable`
- PC2 to the File Server: blocked with `Destination host unreachable`

The final ACL counters were:

```
10 permit host 192.168.20.4 (4 match(es))
20 permit host 192.168.100.100 (4 match(es))
30 deny any (8 match(es))
```

## Files

- `PedroFerreira_2026-10-21_Projeto-ACL-Nomeada.pkt`: configured Packet Tracer project
- `PedroFerreira_2026-10-21_Relatorio-Projeto-ACL-Nomeada.docx`: Portuguese traceability report
- `Portuguese_Configure_Named_Standard_IPv4_ACLs_pka.pka`: preserved source activity

This is a study exercise and is separate from the three-router EIGRP ACL project in the same folder.

