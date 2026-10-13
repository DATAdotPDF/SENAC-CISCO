# LAN-WAN and Security Project

Project branch for SENAC Cisco with three offices: Rio de Janeiro, São Paulo, and Vitória.

## Completed work

- Serial WAN between the three routers.
- OSPF area 0.
- Networks `10.0.0.0/8`, `20.0.0.0/8`, and `30.0.0.0/8`.
- Central DHCP and DNS in Vitória.
- WEB-RIO, WEB-SAO, and WEB-VIT with `rio.com`, `sao.com`, and `vitoria.com`.
- 64-bit WEP on all three access points, with associated laptops and DHCP.
- VLANs by branch and department in Vitória.
- Port security on access ports.
- SSH version 2 with the `MGMT-SSH` ACL for the IT team.
- ACL 100 blocks Rio → São Paulo.
- `VIT-FABRICA-ONLY` ACL limits the Factory network.
- Physical organization in Rio de Janeiro, São Paulo, and Vitória, with a building and closet for each branch.

## Main files

- [Packet Tracer](packet-tracer/Projeto-LAN-WAN/PedroFerreira_2026-10-13_Projeto-LAN-WAN.pkt)
- [Report](packet-tracer/Projeto-LAN-WAN/PedroFerreira_2026-10-13_Relatorio-Projeto-LAN-WAN-revisado.docx)
- [Detailed README](packet-tracer/Projeto-LAN-WAN/README-Projeto-LAN-WAN-revisado.md)
- [Evidence](packet-tracer/Projeto-LAN-WAN/Evidencias-Projeto-LAN-WAN-atualizadas.json)
- [Branch map](packet-tracer/Projeto-LAN-WAN/Mapa-Brasil-Filiais-LAN-WAN.png)
- [Requirement documents](documentos/)

## Scalability

The file uses test equipment. DHCP pools and subnets represent an expansion to 390 clients without creating 390 individual devices.

## Validation

The report records DHCP, DNS, HTTP, WEP, OSPF, VLAN, SSH, ACL, and inter-branch connectivity tests.

## Author

Pedro Dutra Ferreira

Cisco Cybersecurity Course

Senac RJ