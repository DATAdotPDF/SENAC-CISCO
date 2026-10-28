# Numbered Standard IPv4 ACL Study

This NetAcad study activity configures numbered standard IPv4 access control lists in a three-router EIGRP topology. The original PKA remains available beside the completed copy.

## Objective

The activity applies these policies:

- R2 blocks source network \`192.168.11.0/24\` from reaching the Web Server at \`192.168.20.254\`.
- R3 blocks source network \`192.168.10.0/24\` from reaching \`192.168.30.0/24\`.
- All other traffic remains permitted.

## Topology

\`\`\`mermaid
flowchart LR
  PC1["PC1<br/>192.168.10.10"] --> R1["R1<br/>192.168.10.1"]
  PC2["PC2<br/>192.168.11.10"] --> R1
  R1 ---|"10.1.1.0/30"| R2["R2<br/>192.168.20.1"]
  R1 ---|"10.3.3.0/30"| R3["R3<br/>192.168.30.1"]
  R2 ---|"10.2.2.0/30"| R3
  R2 --> WS["Web Server<br/>192.168.20.254"]
  R3 --> PC3["PC3<br/>192.168.30.10"]
\`\`\`

The routers already contain the IPv4 addressing and EIGRP configuration supplied by the activity.

## Addressing table

| Device | Interface | Address | Mask | Gateway |
|---|---|---|---|---|
| R1 | G0/0 | 192.168.10.1 | 255.255.255.0 | N/A |
| R1 | G0/1 | 192.168.11.1 | 255.255.255.0 | N/A |
| R1 | S0/0/0 | 10.1.1.1 | 255.255.255.252 | N/A |
| R1 | S0/0/1 | 10.3.3.1 | 255.255.255.252 | N/A |
| R2 | G0/0 | 192.168.20.1 | 255.255.255.0 | N/A |
| R2 | S0/0/0 | 10.1.1.2 | 255.255.255.252 | N/A |
| R2 | S0/0/1 | 10.2.2.1 | 255.255.255.252 | N/A |
| R3 | G0/0 | 192.168.30.1 | 255.255.255.0 | N/A |
| R3 | S0/0/0 | 10.3.3.2 | 255.255.255.252 | N/A |
| R3 | S0/0/1 | 10.2.2.2 | 255.255.255.252 | N/A |
| PC1 | NIC | 192.168.10.10 | 255.255.255.0 | 192.168.10.1 |
| PC2 | NIC | 192.168.11.10 | 255.255.255.0 | 192.168.11.1 |
| PC3 | NIC | 192.168.30.10 | 255.255.255.0 | 192.168.30.1 |
| Web Server | NIC | 192.168.20.254 | 255.255.255.0 | 192.168.20.1 |

## Configuration procedure

### R2

\`\`\`text
enable
configure terminal
access-list 1 deny 192.168.11.0 0.0.0.255
access-list 1 permit any
interface GigabitEthernet0/0
 ip access-group 1 out
end
\`\`\`

### R3

\`\`\`text
enable
configure terminal
access-list 1 deny 192.168.10.0 0.0.0.255
access-list 1 permit any
interface GigabitEthernet0/0
 ip access-group 1 out
end
\`\`\`

A standard ACL checks the source address. The \`permit any\` entry preserves access for sources that do not match the deny rule.

## Verification

Use these commands on R2 and R3:

\`\`\`text
show access-lists
show ip interface GigabitEthernet0/0
\`\`\`

The final counters were:

| Router | Rule 10 | Rule 20 |
|---|---|---|
| R2 | deny 192.168.11.0 0.0.0.255 — 4 matches | permit any — 8 matches |
| R3 | deny 192.168.10.0 0.0.0.255 — 4 matches | permit any — 8 matches |

## Connectivity evidence

| Source | Destination | Expected result | Observed result |
|---|---|---|---|
| PC1 | PC2 | Allowed | 4/4 replies, 0% loss |
| PC1 | Web Server | Allowed | 4/4 replies, 0% loss |
| PC2 | Web Server | Blocked | Destination host unreachable |
| PC1 | PC3 | Blocked | Destination host unreachable |
| PC2 | PC3 | Allowed | 4/4 replies, 0% loss |
| PC3 | Web Server | Allowed | 4/4 replies, 0% loss |

## Files

- \`PedroFerreira_2026-10-21_Configurar-ACLs-IPv4-Padrao-Numeradas-base.pka\` — original activity supplied by NetAcad.
- \`PedroFerreira_2026-10-21_Configurar-ACLs-IPv4-Padrao-Numeradas-concluido.pka\` — completed activity with both ACLs and test results saved.
- \`PedroFerreira_2026-10-21_Configurar-ACLs-IPv4-Padrao-Numeradas-Relatorio.docx\` — Portuguese procedure report with addressing, commands, counters, and connectivity evidence.

SHA-256 of the completed PKA:

\`\`\`text
3C916E4EB8F4442223A4BCE0DDAF70BAA3CE30A508081C9CB34428B80E1AAC87
\`\`\`

This folder is a study deliverable from the SENAC RJ Cisco Cybersecurity course.

