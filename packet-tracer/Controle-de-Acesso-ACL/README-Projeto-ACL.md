# Cisco Packet Tracer ACL Study Project

This NetAcad study project configures numbered standard IPv4 ACLs in a three-router EIGRP topology.

## Assignment goal

The ACLs must enforce the traffic rules from the activity:

- PC1 can reach PC2 and the Web Server.
- PC2 cannot reach the Web Server.
- PC1 cannot reach PC3.
- PC2 can reach PC3.
- PC3 can reach the Web Server.

## Topology

| Device | Addressing |
|---|---|
| R1 | G0/0 `192.168.10.1/24`, G0/1 `192.168.11.1/24`, serial `10.1.1.1/30` and `10.3.3.1/30` |
| R2 | G0/0 `192.168.20.1/24`, serial `10.1.1.2/30` and `10.2.2.1/30` |
| R3 | G0/0 `192.168.30.1/24`, serial `10.3.3.2/30` and `10.2.2.2/30` |
| PC1 | `192.168.10.10/24`, gateway `192.168.10.1` |
| PC2 | `192.168.11.10/24`, gateway `192.168.11.1` |
| PC3 | `192.168.30.10/24`, gateway `192.168.30.1` |
| Web Server | `192.168.20.254/24`, gateway `192.168.20.1` |

EIGRP process 1 advertises the LAN and serial networks. Each router formed two EIGRP neighbors.

## ACL configuration

R2 protects the Web Server network with a standard ACL on `G0/0` outbound:

```text
access-list 1 deny 192.168.11.0 0.0.0.255
access-list 1 permit any
interface GigabitEthernet0/0
 ip access-group 1 out
```

R3 protects PC3 with a standard ACL on `G0/0` outbound:

```text
access-list 1 deny 192.168.10.0 0.0.0.255
access-list 1 permit any
interface GigabitEthernet0/0
 ip access-group 1 out
```

The ACLs check the source address. The `permit any` line keeps all other sources allowed after the specific denial.

## Validation evidence

The Packet Tracer MCP tests returned:

| Test | Result |
|---|---|
| PC1 → PC2 | 4/4 replies, 0% loss |
| PC1 → Web Server | 4/4 replies, 0% loss |
| PC2 → Web Server | Blocked with `Destination host unreachable` |
| PC1 → PC3 | Blocked with `Destination host unreachable` |
| PC2 → PC3 | 4/4 replies, 0% loss |
| PC3 → Web Server | 4/4 replies, 0% loss |

`show ip access-lists` confirmed hits on both deny rules and on `permit any`.

## Files

- `PedroFerreira_2026-10-21_Projeto-ACL-3-Roteadores.pkt` — valid three-router Packet Tracer project.
- `PedroFerreira_2026-10-21_Projeto-ACL-Literal-Visual.pkt` — comparative one-router and switch topology preserved from the visual reference.
- `PedroFerreira_2026-10-21_Relatorio-Projeto-ACL-3-Roteadores.docx` — Portuguese report with the addressing table, configuration, and evidence.
- `Portuguese_4_5_6_Packet_Tracer_Configure_Numbered_Standard_IPv4_ACLs.docx` — assignment reference.
- `Portuguese_Configure_Named_Standard_IPv4_ACLs_pka.pka` — original reference activity.

The DOCX named above is the primary assignment reference and requires three routers. The visual one-router topology is kept as a separate comparative version because it matches a different reference activity shown in the screenshots. `PedroFerreira_2026-10-21_Projeto-ACL.pka` is the original container from that visual version.

## Integrity

SHA-1 of the valid `.pkt` saved from Packet Tracer: `23923f6c27a588c88c02189db9551448ad11c266`.

SHA-1 of the comparative visual `.pkt`: `f031b0f4edfe9c2e7bdb214f6c42b65aff080c86`.

