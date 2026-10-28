# Contexto de continuidade — Projeto SENAC/Cisco

## Responsável

- Aluno: Pedro Dutra Ferreira
- Curso: Cibersegurança — Cisco
- Instituição: Senac RJ
- Projeto: Rede da empresa fictícia Copa Norte LTDA
- Data da tarefa: 18/09/2026

## Objetivo desta continuidade

Abrir a pasta do projeto no Codex do computador do aluno, organizar os arquivos, criar uma branch exclusiva do curso, preparar um README profissional, revisar o conteúdo e publicar no GitHub somente após confirmação do usuário.

## Regras de trabalho

1. Leia todos os arquivos da pasta antes de alterar qualquer conteúdo.
2. Preserve o arquivo funcional do Packet Tracer.
3. Não altere configurações de rede sem autorização.
4. Não exponha senhas de Wi-Fi no README público.
5. Considere que todos os endereços, domínios e equipamentos pertencem a um laboratório fictício.
6. Antes do push, mostre o `git status`, a lista de arquivos e o resumo do commit.
7. Aguarde confirmação explícita do usuário antes de executar o push.
8. Não inclua arquivos temporários, capturas duplicadas ou dados pessoais de colegas da turma.

## Git e GitHub

- Branch solicitada: `senac-cisco-ciberseguranca`
- Autor do projeto: Pedro Dutra Ferreira
- O repositório remoto ainda precisa ser informado ou identificado no computador do usuário.
- Se a pasta ainda não for um repositório, confirme com o usuário se ela deve ser inicializada ou conectada a um repositório existente.
- Crie um `.gitignore` adequado antes do primeiro commit.

## Estrutura desejada

```text
README.md
CONTEXTO.md
packet-tracer/
└── PedroFerreira-prjrede.pkt
configuracoes/
└── PedroFerreira-configuracoes.txt
imagens/
├── PedroFerreira-topologia-logica.png
├── PedroFerreira-topologia-fisica.png
├── PedroFerreira-fisica-predio-A.png
├── PedroFerreira-fisica-predio-B.png
└── PedroFerreira-fisica-provedor.png
```

Adapte a estrutura apenas se os nomes reais dos arquivos forem diferentes. Não invente arquivos ausentes.

## Requisitos do exercício

O projeto deve representar uma pequena rede para a empresa fictícia Copa Norte LTDA contendo:

- PCs cabeados nos dois prédios
- Laptops
- Quatro dispositivos móveis conectados por Wi-Fi
- Dispositivos de rede
- Uma impressora de rede em cada prédio
- Servidores WEB, DHCP e DNS
- Wi-Fi protegido por senha nos dois prédios
- Uma conexão simulada com a Internet
- Aplicações acessíveis pelos domínios `site.com`, `vendas.com` e `cisco.com`
- Topologias lógica e física
- Documento de configurações
- Arquivo funcional do Packet Tracer

## Arquitetura lógica concluída

### Roteador principal

- Nome: `R-COPA-NORTE`
- Modelo usado: Cisco 2911
- `GigabitEthernet0/0`: `192.168.0.1/24`
- `GigabitEthernet0/1`: `192.168.1.1/24`
- `GigabitEthernet0/2`: `209.165.200.1/24`
- G0/0 e G0/1 configuradas como NAT inside
- G0/2 configurada como NAT outside
- PAT/NAT overload habilitado para as duas redes internas

### Prédio A

- Rede: `192.168.0.0/24`
- Gateway: `192.168.0.1`
- Endereçamento dos computadores: DHCP
- Switch: `SW-PREDIO-A`, IP de gerenciamento `192.168.0.3`
- Access point/roteador sem fio: `AP-PREDIO-A`, IP `192.168.0.2`
- SSID: `PredioA`
- Segurança: WPA2 Personal com AES
- Servidor DHCP: `192.168.0.10`
- Servidor DNS: `192.168.0.11`
- Servidor WEB-A: `192.168.0.20`
- Aplicação: `site.com`
- Impressora A: `192.168.0.30`
- Pool DHCP principal iniciado em `192.168.0.100`

### Prédio B

- Rede: `192.168.1.0/24`
- Gateway: `192.168.1.1`
- Endereçamento dos computadores: estático
- Switch: `SW-PREDIO-B`, IP de gerenciamento `192.168.1.3`
- Access point/roteador sem fio: `AP-PREDIO-B`, IP `192.168.1.2`
- SSID: `PredioB`
- Segurança: WPA2 Personal com AES
- Servidor WEB-B: `192.168.1.20`
- Aplicação: `vendas.com`
- Impressora B: `192.168.1.30`
- PC-B1: `192.168.1.100`
- PC-B2: `192.168.1.101`
- Laptop-B: `192.168.1.110`

### Internet simulada

- Servidor Cisco: `209.165.200.10/24`
- Gateway: `209.165.200.1`
- Aplicação: `cisco.com`
- HTTP e HTTPS habilitados

### DNS

O servidor DNS interno resolve:

- `site.com` e `www.site.com`
- `vendas.com` e `www.vendas.com`
- `cisco.com` e `www.cisco.com`

### Dispositivos móveis

- Smartphone A: `192.168.0.40`
- Tablet A: `192.168.0.41`
- Smartphone B: `192.168.1.40`
- Tablet B: `192.168.1.41`
- DNS usado: `192.168.0.11`

## Cabeamento adotado

- Equipamentos finais ligados aos switches com cabo de cobre direto.
- Roteador ligado aos switches com cabo de cobre direto.
- Roteador ligado ao servidor Cisco com cabo de cobre cruzado.
- Access points conectados aos switches por uma porta LAN, não pela porta Internet.

## Organização física concluída

Foi criada a cidade `Copa Norte LTDA` com três prédios:

- Prédio A, contendo a `Sala Técnica A`
- Prédio B, contendo a `Sala Técnica B`
- Provedor de Internet, contendo o `Data Center Cisco`

Os equipamentos do Prédio A foram movidos para a Sala Técnica A. Os equipamentos do Prédio B foram movidos para a Sala Técnica B. O Servidor Cisco foi movido para o Data Center Cisco.

## Validações realizadas

- Comunicação entre as redes `192.168.0.0/24` e `192.168.1.0/24`
- DHCP funcionando no Prédio A
- Endereçamento estático funcionando no Prédio B
- Resolução DNS funcionando
- Acesso a `site.com`
- Acesso a `vendas.com`
- Acesso a `cisco.com`
- Wi-Fi funcionando nos dois prédios
- Comunicação dos dispositivos móveis
- NAT/PAT confirmado na tabela de traduções do roteador
- Projeto testado novamente após a distribuição física

## README a ser produzido

O `README.md` deve conter:

1. Título e descrição curta
2. Contexto acadêmico
3. Objetivo do projeto
4. Requisitos atendidos
5. Visão da arquitetura
6. Equipamentos usados
7. Tabela de endereçamento
8. Serviços DHCP, DNS e WEB
9. Configuração de Wi-Fi e segurança, sem revelar senhas
10. NAT/PAT e acesso à Internet simulada
11. Testes realizados
12. Imagens das topologias
13. Estrutura do repositório
14. Instruções para abrir o `.pkt` no Cisco Packet Tracer
15. Autor e contexto do curso

## Sequência recomendada no Codex do PC

1. Inspecionar a pasta e conferir os nomes reais dos arquivos.
2. Identificar ou configurar o repositório remoto.
3. Criar ou mudar para a branch `senac-cisco-ciberseguranca`.
4. Criar as pastas e mover os arquivos preservando seus conteúdos.
5. Criar `.gitignore` e `README.md`.
6. Conferir se nenhuma senha aparece no README.
7. Validar links das imagens e nomes dos arquivos.
8. Mostrar `git diff`, `git status` e proposta de mensagem do commit.
9. Criar o commit após aprovação.
10. Executar o push somente após nova confirmação do usuário.

## Prompt curto para iniciar a sessão

```text
Leia integralmente o arquivo CONTEXTO.md e inspecione todos os arquivos desta pasta. Continue o projeto seguindo as regras documentadas. Prepare a branch senac-cisco-ciberseguranca, a estrutura de diretórios, o .gitignore e o README.md. Não faça push antes de mostrar as mudanças e receber minha confirmação.
```
