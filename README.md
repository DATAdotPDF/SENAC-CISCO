# Network Project — Copa Norte LTDA

Academic project created by Pedro Dutra Ferreira for the SENAC RJ Cisco Cybersecurity course.

The lab simulates a company network with two buildings, internal services, protected Wi-Fi access, and an external connection through NAT/PAT.

## Objective

Plan and configure a small corporate network in Cisco Packet Tracer. The solution connects Buildings A and B, provides DHCP, DNS, and Web services, supports wired and wireless devices, and simulates Internet access.

## Requirements covered

- Two buildings on separate IPv4 networks.
- PCs and laptops connected by cable.
- Four mobile devices connected through Wi-Fi.
- One network printer in each building.
- DHCP, DNS, and Web servers.
- Applications reachable through `site.com`, `vendas.com`, and `cisco.com`.
- Automatic addressing in Building A.
- Static addressing in Building B.
- `PredioA` and `PredioB` Wi-Fi networks with WPA2 Personal and AES.
- Internet access simulated with NAT/PAT.
- Logical and physical topologies documented.

## Lab walkthrough

1. Gather requirements: separate the two buildings, wired users, four mobile devices, printers, servers, and external access.
2. Plan IPv4: reserve `192.168.0.0/24` for Building A, `192.168.1.0/24` for Building B, and `209.165.200.0/24` for the simulated Internet.
3. Build the topology: add the Cisco 2911 router, switches, access points, servers, computers, laptops, printers, and mobile devices.
4. Cable the network: connect the router and wired equipment to the switches. Connect the access points through their LAN ports and connect the Cisco server to the router's external interface.
5. Configure the router: name it `R-COPA-NORTE`, configure G0/0, G0/1, and G0/2, mark internal and external interfaces, and enable NAT/PAT.
6. Configure the switches: name them `SW-PREDIO-A` and `SW-PREDIO-B`, set management addresses, and specify each switch gateway.
7. Configure Building A: use DHCP for PCs and the laptop, configure the DHCP server, DNS server, Web Server A, and printer.
8. Configure Building B: use static addresses for PCs and the laptop, configure Web Server B, and configure the printer.
9. Configure Wi-Fi: create SSIDs `PredioA` and `PredioB`, disable internal DHCP on the access points, and apply WPA2 Personal with AES.
10. Configure services: add the `site.com`, `vendas.com`, and `cisco.com` DNS records, enable HTTP and HTTPS, and fill in the Web pages.
11. Test the network: check the gateway, DHCP, static addressing, inter-network communication, DNS resolution, access to all three sites, printers, Wi-Fi, and NAT translations.
12. Record the delivery: save the `.pkt` file, export logical and physical topologies, document commands, and organize project files.

## Topology

The `R-COPA-NORTE` router connects both internal networks to the simulated external network:

- Building A: `192.168.0.0/24`.
- Building B: `192.168.1.0/24`.
- Simulated Internet: `209.165.200.0/24`.

![Logical topology](imagens/PedroFerreira-topologia-logica.png)

![Physical topology](imagens/PedroFerreira-topologia-fisica.png)

### Physical layout

| Location | Contents |
|---|---|
| Building A | Technical Room A and devices on `192.168.0.0/24` |
| Building B | Technical Room B and devices on `192.168.1.0/24` |
| Internet Provider | Cisco Data Center and external server |

![Building A](imagens/PedroFerreira-fisica-predio-A.png)

![Building B](imagens/PedroFerreira-fisica-predio-B.png)

![Internet Provider](imagens/PedroFerreira-fisica-provedor.png)

## Equipment

| Quantity | Equipment | Function |
|---:|---|---|
| 1 | Cisco 2911 router | Routing between networks and NAT/PAT |
| 2 | Cisco 2960-24TT switches | Wired device connectivity |
| 2 | WRT300N wireless routers | Wi-Fi access points |
| 5 | Servers | DHCP, DNS, WEB-A, WEB-B, and external Cisco server |
| 4 | PCs | Wired workstations in both buildings |
| 2 | Laptops | Wired workstations in both buildings |
| 4 | Mobile devices | Smartphones and tablets over Wi-Fi |
| 2 | Printers | One network printer per building |

## Addressing table

### Infrastructure and servers

| Device | Interface or function | IPv4 | Gateway |
|---|---|---|---|
| R-COPA-NORTE | G0/0 — Building A | `192.168.0.1/24` | — |
| R-COPA-NORTE | G0/1 — Building B | `192.168.1.1/24` | — |
| R-COPA-NORTE | G0/2 — external network | `209.165.200.1/24` | — |
| AP-PREDIO-A | Access point | `192.168.0.2/24` | `192.168.0.1` |
| SW-PREDIO-A | Management | `192.168.0.3/24` | `192.168.0.1` |
| SRV-DHCP | DHCP | `192.168.0.10/24` | `192.168.0.1` |
| SRV-DNS | DNS | `192.168.0.11/24` | `192.168.0.1` |
| SRV-WEB-A | `site.com` | `192.168.0.20/24` | `192.168.0.1` |
| IMPRESSORA-A | Printer | `192.168.0.30/24` | `192.168.0.1` |
| AP-PREDIO-B | Access point | `192.168.1.2/24` | `192.168.1.1` |
| SW-PREDIO-B | Management | `192.168.1.3/24` | `192.168.1.1` |
| SRV-WEB-B | `vendas.com` | `192.168.1.20/24` | `192.168.1.1` |
| IMPRESSORA-B | Printer | `192.168.1.30/24` | `192.168.1.1` |
| SRV-CISCO | `cisco.com` | `209.165.200.10/24` | `209.165.200.1` |

### Clients

| Device | Addressing | IPv4 |
|---|---|---|
| PC-A1 | DHCP | Pool starts at `192.168.0.100` |
| PC-A2 | DHCP | Pool starts at `192.168.0.100` |
| LAPTOP-A | DHCP | Pool starts at `192.168.0.100` |
| SMARTPHONE-A | Static | `192.168.0.40/24` |
| TABLET-A | Static | `192.168.0.41/24` |
| PC-B1 | Static | `192.168.1.100/24` |
| PC-B2 | Static | `192.168.1.101/24` |
| LAPTOP-B | Static | `192.168.1.110/24` |
| SMARTPHONE-B | Static | `192.168.1.40/24` |
| TABLET-B | Static | `192.168.1.41/24` |

Clients use DNS `192.168.0.11`. The main Building A pool starts at `192.168.0.100` and supports up to 50 clients.

## Services

### DHCP

Server `192.168.0.10` assigns addresses to the Building A PCs and laptop. It also provides gateway `192.168.0.1` and DNS `192.168.0.11`.

### DNS

Server `192.168.0.11` stores records for:

| Domain | Destination |
|---|---|
| `site.com` and `www.site.com` | `192.168.0.20` |
| `vendas.com` and `www.vendas.com` | `192.168.1.20` |
| `cisco.com` and `www.cisco.com` | `209.165.200.10` |

### Web

- `site.com`: application hosted in Building A.
- `vendas.com`: application hosted in Building B.
- `cisco.com`: external page used to test the simulated Internet.

All three Web servers have HTTP and HTTPS enabled in the lab.

## Wi-Fi security

| Building | SSID | Protection | Encryption |
|---|---|---|---|
| A | `PredioA` | WPA2 Personal | AES |
| B | `PredioB` | WPA2 Personal | AES |

Access keys are not published in this repository.

## NAT/PAT

G0/0 and G0/1 on `R-COPA-NORTE` are internal. G0/2 is external.

An access list permits `192.168.0.0/24` and `192.168.1.0/24`. The router applies PAT overload on `209.165.200.1` for traffic sent to the simulated external network.

## Tests performed

The project record marks these tests as completed:

- Communication between the two building networks.
- DHCP assignment in Building A.
- Static addressing in Building B.
- Resolution of all three domains by the DNS server.
- HTTP access to `site.com`, `vendas.com`, and `cisco.com`.
- Communication with both printers.
- Connection of all four mobile devices to the Wi-Fi networks.
- NAT/PAT translation checked with `show ip nat translations`.

The first ping may time out while devices resolve addresses through ARP. Later attempts should receive replies.

## Repository structure

```text
.
├── README.md
├── .gitignore
├── packet-tracer/
│   └── PedroFerreira-prjrede.pkt
├── configuracoes/
│   └── PedroFerreira-configuracoes.txt
└── imagens/
    ├── PedroFerreira-topologia-logica.png
    ├── PedroFerreira-topologia-fisica.png
    ├── PedroFerreira-fisica-predio-A.png
    ├── PedroFerreira-fisica-predio-B.png
    └── PedroFerreira-fisica-provedor.png
```

## Open the project

1. Install Cisco Packet Tracer.
2. Clone or download this repository.
3. Open Packet Tracer.
4. Select `File > Open`.
5. Open `packet-tracer/PedroFerreira-prjrede.pkt`.
6. Wait for the links to converge before repeating the tests.

## Author

Pedro Dutra Ferreira

Cisco Cybersecurity Course

Senac RJ