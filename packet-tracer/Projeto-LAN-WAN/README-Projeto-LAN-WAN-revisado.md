# Projeto LAN WAN de Pedro Ferreira

Revisão de 13/10/2026. Cisco Packet Tracer 9.0.1.

## Arquivos desta revisão

- [Projeto final](PedroFerreira_2026-10-13_Projeto-LAN-WAN.pkt)
- [Relatório revisado](PedroFerreira_2026-10-13_Relatorio-Projeto-LAN-WAN-revisado.docx)
- [Evidências dos testes](Evidencias-Projeto-LAN-WAN-atualizadas.json)

O arquivo principal foi salvo no nome original. A cópia de auditoria anterior continua em `lanwan-auditoria/original`.

## Resultado confirmado

| Item | Estado verificado |
| --- | --- |
| HTTP | Ativo na porta 80 de WEB-RIO, WEB-SAO e WEB-VIT. Já estava ativo antes da revisão. |
| DNS | DNS-VIT ativo em 30.0.0.11, com os três registros A. |
| WEP | Configurado nos três APs, autenticação WEP e criptografia de 64 bits. Os três laptops estão associados e receberam DHCP. |
| VLANs | VLAN 10 no Rio, 20 em São Paulo e 30, 31, 32 e 33 em Vitória, com trunk 802.1Q no uplink. |
| VLAN 99 | GUEST_TERCEIROS criada nos três switches, sem clientes nem portas associadas. |
| Port-security | Um MAC sticky por porta de PC, ação restrict. Oito portas protegidas, sem violações observadas. |
| SSH | RSA de 2048 bits e SSH versão 2 ativos nos três roteadores. PC-TI autenticou e PC-RH foi recusado. |
| ACL de gerenciamento | `MGMT-SSH` permite 30.32.0.0/16, sub-rede da VLAN TI, e nega as demais origens. |
| ACL entre filiais | ACL 100 em RT-SAO Gi0/0 de saída bloqueia 10.0.0.0/8 para 20.0.0.0/8 e permite os demais fluxos. |
| ACL da Fábrica | `VIT-FABRICA-ONLY` aplicada em Gi0/0.31 de entrada. Permite rede própria, DHCP, DNS e HTTP/ICMP para os três WEB. Bloqueia a rede de TI. |
| OSPF | Área 0. Vizinhos FULL nos dois enlaces seriais. |
| DHCP | Pools dos três roteadores preservados. Vitória tem pools próprios para Fábrica, TI e Diretoria. |

## Atividade de análise

Os funcionários recebem DHCP, DNS, HTTP e acesso entre filiais conforme a política. A equipe de TI administra os roteadores por SSH. A VLAN `GUEST_TERCEIROS` foi criada para fornecedores, terceirizados e clientes. Ela ainda não tem clientes associados, por isso a regra de produção para essa rede fica registrada como política: permitir apenas serviços publicados e bloquear administração e bases internas.

RH/Administração do Rio não alcança a rede de Estoque, Vendas e Marketing de São Paulo. A Fábrica de Vitória acessa a própria rede, DNS e os três portais WEB, mas não alcança a rede de TI. TI tem acesso SSH à infraestrutura. Essas relações foram testadas com ACLs.

A pesquisa individual usa amostras funcionais. Os 390 clientes exigem mais portas e equipamentos de acesso. Os blocos IP, gateways, pools DHCP e OSPF já permitem a expansão.

## Endereçamento

| Filial | LAN | Gateway | WEB | Nome |
| --- | --- | --- | --- | --- |
| Rio | 10.0.0.0/8 | 10.0.0.1 | 10.0.0.10 | rio.com |
| São Paulo | 20.0.0.0/8 | 20.0.0.1 | 20.0.0.10 | sao.com |
| Vitória | 30.0.0.0/8 | 30.0.0.1 | 30.0.0.10 | vitoria.com |

DNS central: 30.0.0.11. Os pools DHCP excluem .1 a .99 e entregam o gateway da filial e o DNS central.

WAN Rio–São Paulo: 192.168.12.1/30 e 192.168.12.2/30. WAN São Paulo–Vitória: 192.168.23.1/30 e 192.168.23.2/30.

Portas da VLAN da filial: SW-RIO Fa0/1–4 e Gi0/1, SW-SAO Fa0/1–5 e Gi0/1. Em Vitória, Fa0/3 é Fábrica na VLAN 31, Fa0/4 é TI na VLAN 32, Fa0/5 é Diretoria na VLAN 33 e Gi0/1 é trunk.

Port-security: SW-RIO Fa0/2–3, SW-SAO Fa0/2–4, SW-VIT Fa0/3–5.

## Testes

| Origem | Destino | Respostas na rodada final |
| --- | --- | --- |
| PC-RH | DNS-VIT 30.0.0.11 | 4/4 |
| PC-VEN | WEB-RIO 10.0.0.10 | 4/4 |
| PC-TI | WEB-SAO 20.0.0.10 | 4/4 |
| PC-TI | WEB-RIO 10.0.0.10 | 4/4 |
| PC-FAB | Gateway 30.31.0.1 | 4/4 |
| PC-ADM | WEB-RIO 10.0.0.10 | 4/4 |
| PC-EST | Gateway 20.0.0.1 | 4/4 |
| PC-MKT | WEB-VIT 30.0.0.10 | 4/4 |
| PC-DIR | Gateway 30.33.0.1 | 4/4 |

Total: 36 respostas em 36 solicitações. As primeiras tentativas após mudanças tiveram perdas. A causa dos 0% históricos não foi comprovada. Um retorno da ferramenta com `sent=0` e sem estatística final é incompleto e não comprova falha total.

HTTP por nome: PC-RH abriu `http://sao.com`, PC-VEN abriu `http://vitoria.com` e PC-TI abriu `http://rio.com`. O conteúdo HTML foi lido no cliente. As páginas continuam com o conteúdo padrão do Packet Tracer.

O arquivo original foi salvo e reaberto. Os IPs estáticos das três VLANs de Vitória, HTTP, DNS, WEP, VLANs, port-security, SSH e ACLs persistiram. OSPF alcançou FULL novamente. O PC-TI acessou Rio e São Paulo por ICMP e o PC-RH foi bloqueado ao tentar alcançar WEB-SAO.

## Limites e pendências

- Há 21 equipamentos de rede: 3 roteadores, 3 switches, 4 servidores, 8 PCs e 3 APs. O dispositivo interno de distribuição de energia pode aparecer como um item adicional na API.
- Os PCs representam departamentos. O arquivo não contém os 390 clientes previstos no enunciado. A expansão exige dimensionar switches e portas.
- WEP foi configurado conforme o requisito acadêmico. Os três laptops estão associados pela interface Wireless e receberam DHCP: LAP-RIO 10.0.0.102, LAP-SAO 20.0.0.103 e LAP-VIT 30.0.0.101.
- Mapa de referência para o modo Physical: [Mapa-Brasil-Filiais-LAN-WAN.png](Mapa-Brasil-Filiais-LAN-WAN.png). No Packet Tracer, use `Set Background` no local físico para carregar essa imagem.
- O modo Physical foi organizado manualmente. Os equipamentos foram distribuídos em Rio de Janeiro, São Paulo e Vitória, com um building e um closet por filial. A ponte MCP desta versão só expõe o canvas lógico. Para conferir o mapa, use Rio de Janeiro (-22.9068, -43.1729), São Paulo (-23.5505, -46.6333) e Vitória (-20.3155, -40.3128). As distâncias em linha reta são cerca de 361 km, 744 km e 413 km, respectivamente. O enunciado anexado usa São Paulo. Salvador exigiria mudança de escopo.
- Fábrica, TI e Diretoria estão nas VLANs 31, 32 e 33, com sub-redes /16 e gateways próprios.
- MGMT-SSH foi limitado à sub-rede 30.32.0.0/16. O PC-TI autenticou e o PC-RH foi recusado.
- A ACL 100 do guia está aplicada. Como ela é sem estado, o bloqueio Rio → São Paulo também pode impedir respostas iniciadas em São Paulo para hosts do Rio. A ACL `VIT-FABRICA-ONLY` também foi aplicada e testada na VLAN 31.

## Procedimento confirmado pela ponte MCP

1. Ler requisitos, relatório e README. Conferir o nome do arquivo aberto com `pt_read_project_metadata` e inventariar a topologia.
2. Copiar o original e comparar SHA-256. Salvar uma cópia de trabalho antes das mudanças.
3. Conferir o estado dos serviços pela API interna. Nesta versão, `HttpServer`, `DnsServerProcess` e `WirelessServer.getWepProcess()` expõem as operações necessárias.
4. Criar registros com `addARecordToNameServerDb` e conferir nome e IP com `getARecordWithAddress`. `getIpAddOfDomain` não serviu como leitura da tabela autoritativa nesta sessão.
5. Configurar e conferir switches. `CiscoDevice.enterCommand(comando, modo)` retornou status e texto completos. As ferramentas genéricas de CLI apresentaram saída vazia, paginação ou sessão em modo inadequado. Sucesso só foi aceito após leitura da configuração.
6. Testar ICMP, DNS e HTTP. Esperar a estatística final do ping e ler a página recebida pelo cliente HTTP.
7. Executar `write memory`, salvar o `.pkt`, reabrir a cópia e repetir as leituras e os testes.

A ponte MCP usa `http://127.0.0.1:39001/mcp`. A extensão do Packet Tracer consulta `http://127.0.0.1:54321`. O serviço foi iniciado em segundo plano e a extensão se reconectou. Não foi necessário controle visual por `sky`.

## Integridade

Backup do arquivo original antes da alteração, 122467 bytes:

```text
SHA-256 50663b7b69319ed65828473bcbe7be4e46c5234c113de2beb1580a458bae1554
```

Arquivo principal salvo no nome original, 264077 bytes:

```text
SHA-256 caab3be565bee5c5bbc34ccb5aa0373f6a88e0dea2613f85d3d17aefc8e8e89c
```
