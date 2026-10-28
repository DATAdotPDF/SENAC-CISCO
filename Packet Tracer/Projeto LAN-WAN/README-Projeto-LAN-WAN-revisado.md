# LAN-WAN Project Detailed Guide

Revision: 13 October 2026. Cisco Packet Tracer 9.0.1.

## Verified services and controls

| Area | Verified result |
|---|---|
| HTTP | Port 80 active on WEB-RIO, WEB-SAO, and WEB-VIT. |
| DNS | DNS-VIT at `30.0.0.11` contains `rio.com`, `sao.com`, and `vitoria.com`. |
| WEP | 64-bit WEP configured on all three APs. The three laptops associate and receive DHCP. |
| VLANs | Rio VLAN 10, São Paulo VLAN 20, and Vitória VLANs 30, 31, 32, and 33. The uplink uses 802.1Q trunking. |
| Guest VLAN | VLAN 99 is reserved for third parties and has no production clients. |
| Port security | Sticky MAC with the `restrict` action protects the selected access ports. |
| SSH | RSA 2048-bit keys and SSH version 2 are active on all three routers. |
| Management ACL | `MGMT-SSH` permits the IT subnet `30.32.0.0/16` and rejects other origins. |
| Inter-office ACL | ACL 100 on RT-SAO blocks Rio-to-São Paulo traffic and permits the remaining required flows. |
| Factory ACL | `VIT-FABRICA-ONLY` is applied inbound to the Factory subinterface. |
| OSPF | Area 0 neighbors reach `FULL` on the serial links. |
| DHCP | Pools are preserved on the three routers, including Factory, IT, and Management pools in Vitória. |

## Addressing

| Office | LAN | Gateway | Web server | DNS name |
|---|---|---:|---:|---|
| Rio de Janeiro | `10.0.0.0/8` | `10.0.0.1` | `10.0.0.10` | `rio.com` |
| São Paulo | `20.0.0.0/8` | `20.0.0.1` | `20.0.0.10` | `sao.com` |
| Vitória | `30.0.0.0/8` | `30.0.0.1` | `30.0.0.10` | `vitoria.com` |

DNS-VIT uses `30.0.0.11`. DHCP excludes `.1` through `.99` and supplies the branch gateway and central DNS address.

WAN links:

- Rio–São Paulo: `192.168.12.1/30` and `192.168.12.2/30`.
- São Paulo–Vitória: `192.168.23.1/30` and `192.168.23.2/30`.

Vitória departments:

- VLAN 31 Factory: `30.31.0.0/16`, gateway `30.31.0.1`.
- VLAN 32 IT: `30.32.0.0/16`, gateway `30.32.0.1`.
- VLAN 33 Management: `30.33.0.0/16`, gateway `30.33.0.1`.

## Reproduction procedure

1. Read the LAN-WAN requirement document and the addressing table.
2. Place the three routers, three switches, servers, APs, PCs, and laptops in the logical workspace.
3. Arrange Rio de Janeiro, São Paulo, and Vitória in Physical mode, with one building and one closet for each office.
4. Configure LAN and serial addresses and enable every interface.
5. Enable OSPF area 0 and advertise the LAN and serial networks.
6. Configure DHCP pools and reserve infrastructure addresses.
7. Configure DNS-VIT and add the three Web A records.
8. Enable HTTP on the three Web servers.
9. Create the Vitória VLANs, assign access ports, and configure the trunk.
10. Configure 64-bit WEP and associate the three laptops.
11. Apply port security, SSH version 2, `MGMT-SSH`, ACL 100, and `VIT-FABRICA-ONLY`.
12. Run ICMP, DNS, HTTP, SSH, WEP, VLAN, and ACL tests.
13. Save the running configuration and the `.pkt`, reopen it, and repeat the checks.

Useful commands:

```text
show ip ospf neighbor
show ip route
show ip dhcp binding
show vlan brief
show interfaces trunk
show port-security
show access-lists
show ip ssh
show running-config | section line vty
```

## Final evidence

The final evidence records 36 replies from 36 ICMP requests. HTTP was opened by DNS name. PC-TI authenticated with SSH while PC-RH was rejected. The three laptops received DHCP through WEP. The saved project reopened with the services, VLANs, ACLs, and OSPF state preserved.

The first ping after a topology change can lose packets while ARP resolves. An incomplete probe response with `sent=0` is not treated as a complete failed test.

## Physical mode

The map file is [Mapa-Brasil-Filiais-LAN-WAN.png](Mapa-Brasil-Filiais-LAN-WAN.png). In Packet Tracer, use `Set Background` to load it in the Physical workspace. The locations used are Rio de Janeiro, São Paulo, and Vitória. Salvador is outside this assignment.

## Scale and limits

The file uses representative equipment. It does not draw all 390 planned clients. The office blocks, department subnets, DHCP ranges, VLANs, and OSPF advertisements show how the design can be extended with more switches and ports. WEP is kept only because the academic requirement asks for it.

## Integrity

- Original backup SHA-256: `50663b7b69319ed65828473bcbe7be4e46c5234c113de2beb1580a458bae1554`.
- Final project SHA-256: `caab3be565bee5c5bbc34ccb5aa0373f6a88e0dea2613f85d3d17aefc8e8e89c`.
