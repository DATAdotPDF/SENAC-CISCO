# Projeto de Rede — Copa Norte LTDA

Projeto acadêmico criado por Pedro Dutra Ferreira no curso Cibersegurança — Cisco, do Senac RJ.

O laboratório simula a rede de uma empresa com dois prédios, serviços internos, acesso Wi-Fi protegido e uma conexão externa por NAT/PAT.

## Objetivo

Planejar e configurar uma pequena rede corporativa no Cisco Packet Tracer. A solução conecta os Prédios A e B, oferece serviços DHCP, DNS e Web, atende dispositivos cabeados e sem fio e simula o acesso à Internet.

## Requisitos atendidos

- Dois prédios em redes IPv4 distintas.
- PCs e laptops conectados por cabo.
- Quatro dispositivos móveis conectados por Wi-Fi.
- Uma impressora de rede em cada prédio.
- Servidores DHCP, DNS e Web.
- Aplicações acessíveis por `site.com`, `vendas.com` e `cisco.com`.
- Endereçamento automático no Prédio A.
- Endereçamento estático no Prédio B.
- Redes Wi-Fi `PredioA` e `PredioB` com WPA2 Personal e AES.
- Saída para a Internet simulada por NAT/PAT.
- Topologias lógica e física documentadas.

## Passo a passo do laboratório

1. Levantamento dos requisitos: separar os dois prédios, os usuários cabeados, os quatro dispositivos móveis, as impressoras, os servidores e o acesso externo.
2. Planejamento IPv4: reservar `192.168.0.0/24` para o Prédio A, `192.168.1.0/24` para o Prédio B e `209.165.200.0/24` para a Internet simulada.
3. Montagem da topologia: adicionar o roteador Cisco 2911, os switches, os pontos de acesso, os servidores, os computadores, os laptops, as impressoras e os dispositivos móveis.
4. Cabeamento: conectar roteador e equipamentos cabeados aos switches. Ligar os pontos de acesso pela porta LAN e o servidor Cisco à interface externa do roteador.
5. Configuração do roteador: nomear `R-COPA-NORTE`, configurar G0/0, G0/1 e G0/2, marcar as interfaces internas e externas e ativar o NAT/PAT.
6. Configuração dos switches: nomear `SW-PREDIO-A` e `SW-PREDIO-B`, definir os endereços de gerenciamento e informar o gateway de cada switch.
7. Configuração do Prédio A: usar DHCP para PCs e laptop, configurar o servidor DHCP, o servidor DNS, o servidor Web A e a impressora.
8. Configuração do Prédio B: usar endereços estáticos nos PCs e no laptop, configurar o servidor Web B e a impressora.
9. Configuração do Wi-Fi: criar os SSIDs `PredioA` e `PredioB`, desativar o DHCP interno dos pontos de acesso e aplicar WPA2 Personal com AES.
10. Configuração dos serviços: cadastrar no DNS os domínios `site.com`, `vendas.com` e `cisco.com`, ativar HTTP e HTTPS e preencher as páginas Web.
11. Testes: verificar gateway, DHCP, endereçamento estático, comunicação entre redes, resolução DNS, acesso aos três sites, impressoras, Wi-Fi e traduções NAT.
12. Registro da entrega: salvar o arquivo `.pkt`, exportar as topologias lógica e física, documentar os comandos e organizar os arquivos do projeto.

## Topologia

O roteador `R-COPA-NORTE` liga as duas redes internas à rede externa simulada:

- Prédio A: `192.168.0.0/24`.
- Prédio B: `192.168.1.0/24`.
- Internet simulada: `209.165.200.0/24`.

![Topologia lógica](imagens/PedroFerreira-topologia-logica.png)

![Topologia física](imagens/PedroFerreira-topologia-fisica.png)

### Distribuição física

| Local | Conteúdo |
|---|---|
| Prédio A | Sala Técnica A e dispositivos da rede `192.168.0.0/24` |
| Prédio B | Sala Técnica B e dispositivos da rede `192.168.1.0/24` |
| Provedor de Internet | Data Center Cisco e servidor externo |

![Prédio A](imagens/PedroFerreira-fisica-predio-A.png)

![Prédio B](imagens/PedroFerreira-fisica-predio-B.png)

![Provedor de Internet](imagens/PedroFerreira-fisica-provedor.png)

## Equipamentos

| Quantidade | Equipamento | Função |
|---:|---|---|
| 1 | Roteador Cisco 2911 | Roteamento entre redes e NAT/PAT |
| 2 | Switches Cisco 2960-24TT | Conexão dos dispositivos cabeados |
| 2 | Roteadores sem fio WRT300N | Pontos de acesso Wi-Fi |
| 5 | Servidores | DHCP, DNS, WEB-A, WEB-B e Cisco externo |
| 4 | PCs | Estações cabeadas nos dois prédios |
| 2 | Laptops | Estações cabeadas nos dois prédios |
| 4 | Dispositivos móveis | Smartphones e tablets via Wi-Fi |
| 2 | Impressoras | Impressão em rede, uma por prédio |

## Tabela de endereçamento

### Infraestrutura e servidores

| Dispositivo | Interface ou função | IPv4 | Gateway |
|---|---|---|---|
| R-COPA-NORTE | G0/0 — Prédio A | `192.168.0.1/24` | — |
| R-COPA-NORTE | G0/1 — Prédio B | `192.168.1.1/24` | — |
| R-COPA-NORTE | G0/2 — rede externa | `209.165.200.1/24` | — |
| AP-PREDIO-A | Ponto de acesso | `192.168.0.2/24` | `192.168.0.1` |
| SW-PREDIO-A | Gerenciamento | `192.168.0.3/24` | `192.168.0.1` |
| SRV-DHCP | DHCP | `192.168.0.10/24` | `192.168.0.1` |
| SRV-DNS | DNS | `192.168.0.11/24` | `192.168.0.1` |
| SRV-WEB-A | `site.com` | `192.168.0.20/24` | `192.168.0.1` |
| IMPRESSORA-A | Impressora | `192.168.0.30/24` | `192.168.0.1` |
| AP-PREDIO-B | Ponto de acesso | `192.168.1.2/24` | `192.168.1.1` |
| SW-PREDIO-B | Gerenciamento | `192.168.1.3/24` | `192.168.1.1` |
| SRV-WEB-B | `vendas.com` | `192.168.1.20/24` | `192.168.1.1` |
| IMPRESSORA-B | Impressora | `192.168.1.30/24` | `192.168.1.1` |
| SRV-CISCO | `cisco.com` | `209.165.200.10/24` | `209.165.200.1` |

### Clientes

| Dispositivo | Endereçamento | IPv4 |
|---|---|---|
| PC-A1 | DHCP | Pool iniciado em `192.168.0.100` |
| PC-A2 | DHCP | Pool iniciado em `192.168.0.100` |
| LAPTOP-A | DHCP | Pool iniciado em `192.168.0.100` |
| SMARTPHONE-A | Estático | `192.168.0.40/24` |
| TABLET-A | Estático | `192.168.0.41/24` |
| PC-B1 | Estático | `192.168.1.100/24` |
| PC-B2 | Estático | `192.168.1.101/24` |
| LAPTOP-B | Estático | `192.168.1.110/24` |
| SMARTPHONE-B | Estático | `192.168.1.40/24` |
| TABLET-B | Estático | `192.168.1.41/24` |

Os clientes usam o DNS `192.168.0.11`. O pool principal do Prédio A começa em `192.168.0.100` e aceita até 50 clientes.

## Serviços

### DHCP

O servidor `192.168.0.10` entrega endereços aos PCs e ao laptop do Prédio A. Ele também informa o gateway `192.168.0.1` e o DNS `192.168.0.11`.

### DNS

O servidor `192.168.0.11` mantém registros para:

| Domínio | Destino |
|---|---|
| `site.com` e `www.site.com` | `192.168.0.20` |
| `vendas.com` e `www.vendas.com` | `192.168.1.20` |
| `cisco.com` e `www.cisco.com` | `209.165.200.10` |

### Web

- `site.com`: aplicação hospedada no Prédio A.
- `vendas.com`: aplicação hospedada no Prédio B.
- `cisco.com`: página externa usada para testar a Internet simulada.

Os três servidores Web têm HTTP e HTTPS habilitados no laboratório.

## Segurança Wi-Fi

| Prédio | SSID | Proteção | Criptografia |
|---|---|---|---|
| A | `PredioA` | WPA2 Personal | AES |
| B | `PredioB` | WPA2 Personal | AES |

As chaves de acesso não são publicadas neste repositório.

## NAT/PAT

As interfaces G0/0 e G0/1 do `R-COPA-NORTE` são internas. A interface G0/2 é externa.

Uma lista de acesso permite as redes `192.168.0.0/24` e `192.168.1.0/24`. O roteador aplica PAT com sobrecarga no endereço `209.165.200.1` para o tráfego destinado à rede externa simulada.

## Testes realizados

O registro do projeto marca os seguintes testes como concluídos:

- Comunicação entre as redes dos dois prédios.
- Concessão DHCP no Prédio A.
- Endereçamento estático no Prédio B.
- Resolução dos três domínios pelo servidor DNS.
- Acesso HTTP a `site.com`, `vendas.com` e `cisco.com`.
- Comunicação com as duas impressoras.
- Conexão dos quatro dispositivos móveis às redes Wi-Fi.
- Tradução NAT/PAT conferida com `show ip nat translations`.

A primeira tentativa de ping pode expirar enquanto os dispositivos resolvem endereços por ARP. As tentativas seguintes devem responder.

## Estrutura do repositório

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

## Como abrir o projeto

1. Instale o Cisco Packet Tracer.
2. Clone ou baixe este repositório.
3. Abra o Packet Tracer.
4. Selecione `File > Open`.
5. Abra `packet-tracer/PedroFerreira-prjrede.pkt`.
6. Aguarde a convergência dos links antes de repetir os testes.

## Autor

Pedro Dutra Ferreira

Curso Cibersegurança — Cisco

Senac RJ
