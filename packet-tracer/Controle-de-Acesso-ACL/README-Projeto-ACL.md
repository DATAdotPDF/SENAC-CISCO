# Cisco Packet Tracer ACL Project

This project configures a numbered standard IPv4 access control list on router R1.

## Objective

Only PC1 and the Web Server may access the File Server. All other sources must be denied.

## Topology

| Device | Address | Connection |
|---|---|---|
| PC0 | 192.168.20.3/24 | R1 Ethernet0/1/0 |
| PC1 | 192.168.20.4/24 | R1 Ethernet0/1/0 |
| PC2 | 192.168.10.3/24 | R1 Ethernet0/0/0 |
| Web Server | 192.168.100.100/24 | R1 FastEthernet0/0 |
| File Server | 192.168.200.100/24 | R1 FastEthernet0/1 |

## ACL configuration

```text
access-list 1 permit host 192.168.20.4
access-list 1 permit host 192.168.100.100
access-list 1 deny any
interface FastEthernet0/1
ip access-group 1 out
```

The ACL is a standard IPv4 ACL, so it checks the source address. It is applied outbound on R1 FastEthernet0/1, the interface that leads to the File Server network. This placement filters traffic headed to the protected server while keeping the rule set simple.

## Validation

- PC1 to File Server: 4 of 4 replies received.
- Web Server to File Server: 4 of 4 replies received.
- PC0 to File Server: denied. Packet Tracer returned `Destination host unreachable` from 192.168.20.1.
- PC2 to File Server: denied. Packet Tracer returned `Destination host unreachable` from 192.168.10.1.
- R1 ACL readback confirmed the two permitted hosts followed by `deny any`.

## Files

- `PedroFerreira_2026-10-21_Projeto-ACL.pka` — completed Packet Tracer project.
- `PedroFerreira_2026-10-21_Relatorio-Projeto-ACL.docx` — written explanation of the objective, configuration, and tests.
- `Portuguese_4_5_6_Packet_Tracer_Configure_Numbered_Standard_IPv4_ACLs.docx` — assignment reference.
- `Portuguese_Configure_Named_Standard_IPv4_ACLs_pka.pka` — original reference activity.

## Integrity

SHA-256 of the completed project file:

`453861627504337A9A1980E3704F14D3105CD03279612A80AA16207C7782C86B`
