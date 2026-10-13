# Projeto LAN-WAN e Segurança

Branch do projeto SENAC Cisco com três filiais: Rio de Janeiro, São Paulo e Vitória.

## O que foi feito

- WAN serial entre os três roteadores.
- OSPF área 0.
- Redes `10.0.0.0/8`, `20.0.0.0/8` e `30.0.0.0/8`.
- DHCP e DNS central em Vitória.
- WEB-RIO, WEB-SAO e WEB-VIT com `rio.com`, `sao.com` e `vitoria.com`.
- WEP de 64 bits nos três APs, com laptops associados e DHCP.
- VLANs por filial e por departamento em Vitória.
- Port-security nas portas de acesso.
- SSH versão 2 com ACL `MGMT-SSH` para a equipe de TI.
- ACL 100 para bloquear Rio → São Paulo.
- ACL `VIT-FABRICA-ONLY` para limitar a Fábrica.
- Organização Physical em Rio de Janeiro, São Paulo e Vitória, com building e closet por filial.

## Arquivos principais

- [Packet Tracer](packet-tracer/Projeto-LAN-WAN/PedroFerreira_2026-10-13_Projeto-LAN-WAN.pkt)
- [Relatório](packet-tracer/Projeto-LAN-WAN/PedroFerreira_2026-10-13_Relatorio-Projeto-LAN-WAN-revisado.docx)
- [README detalhado](packet-tracer/Projeto-LAN-WAN/README-Projeto-LAN-WAN-revisado.md)
- [Evidências](packet-tracer/Projeto-LAN-WAN/Evidencias-Projeto-LAN-WAN-atualizadas.json)
- [Mapa das filiais](packet-tracer/Projeto-LAN-WAN/Mapa-Brasil-Filiais-LAN-WAN.png)
- [Documentos de requisitos](documentos/)

## Escalabilidade

O arquivo usa equipamentos de teste. Os pools DHCP e as sub-redes representam a expansão para 390 clientes sem criar 390 dispositivos individuais.

## Validação

O relatório registra testes de DHCP, DNS, HTTP, WEP, OSPF, VLANs, SSH, ACLs e conectividade entre filiais.

## Autor

Pedro Dutra Ferreira

Curso Cibersegurança — Cisco

Senac RJ
