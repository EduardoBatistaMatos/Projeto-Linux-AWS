# 🔥 Projeto Linux + AWS  

## 📌 Visão Geral  
Este projeto configura uma infraestrutura na AWS baseada em **Linux**, utilizando **VPC, Subnets, Security Groups e EC2 (Amazon Linux)** para hospedar um servidor **Nginx**. Além disso, há um **webhook do Discord** para envio de notificações automáticas.  

## 🛠️ Tecnologias Utilizadas  
- **AWS VPC** → Configuração de rede isolada.  
- **Subnets** → Organização dos recursos em diferentes zonas de disponibilidade.  
- **Security Groups** → Regras de firewall para controle de acesso.  
- **EC2 (Amazon Linux)** → Instância principal do servidor.  
- **Nginx** → Servidor web configurado na instância.  
- **Webhook do Discord** → Notificações automáticas sobre o status do servidor.  

### 1️⃣ **Pré-requisitos**  
- **Conta AWS** com permissões de administração.  
- **Conta no Discord** para testarmos o sistema de notificações.  
- **Ter instalado o PuTTY** para acessar a instância via SSH.  

### 2️⃣ **Provisionamento da Infraestrutura**  

**1**. Criar uma **VPC** (Virtual Private Cloud), que é como uma rede LAN (Local Area Network) na nuvem, mas com mais flexibilidade e recursos de isolamento.  
  * Na barra de pesquisa do console AWS, pesquise por VPC, clique em *Your VPCs* e depois no botão *Create VPC*.  
  * Agora vamos configurar a VPC. Primeiro, temos duas opções: *VPC only*, que podemos configurar mais especificamente, e *VPC and more*, que vem previamente configurada. Vamos selecionar a segunda opção. Logo abaixo, há um *checkbox* e um campo de texto para adicionarmos uma etiqueta que será usada para nomear todos os recursos na VPC. Nesse caso, vamos marcar o *checkbox* para gerar automaticamente as etiquetas e colocar o nome desejado.  
  * Por padrão, a VPC já vem com duas subnets públicas e duas subnets privadas em duas regiões diferentes, com um *Internet Gateway* conectado às sub-redes públicas, mas vale conferir.  
  * Feito isso, a VPC deverá ficar assim:  
    ![image](https://github.com/user-attachments/assets/5de410da-9847-48f8-98fe-d999febc1cbb)  
  * Agora é só clicar em *Create VPC*, esperar carregar e pronto, a VPC está criada.  

**2**. Criar um **Security Group**, que é basicamente um firewall que controla as regras de entrada e saída da instância EC2. Aqui, vamos permitir os tráfegos HTTPS/HTTP e SSH.  
  * Na barra de pesquisa do console AWS, pesquise por EC2. Dentro das opções de *Network & Security*, clique em *Security Groups* e depois no botão *Create Security Group*.  
  * No primeiro campo, colocamos o nome do Security Group, no segundo campo, colocamos a descrição e, no terceiro, a VPC à qual ele será associado (no caso, selecionamos a VPC criada anteriormente).  
  * Abaixo, temos as *Inbound rules* e *Outbound rules*, que são as regras de entrada e saída.  
    Vamos adicionar as seguintes *Inbound rules* clicando em *Add rule*:  
      ![image](https://github.com/user-attachments/assets/aac4c330-7e46-4698-8bda-d39b6a7f16bb)  
      ![image](https://github.com/user-attachments/assets/c5a56817-3b4e-40f7-9203-0cc6ff528349)  
      ![image](https://github.com/user-attachments/assets/50651544-a188-42e0-b5c1-e9b9603e493b)  

  * Já nas *Outbound rules*, podemos deixar o tráfego de saída aberto para todos, assim:  
      ![image](https://github.com/user-attachments/assets/76f059d1-8b56-4138-aea9-180a1e921319)  

  * Por último, temos a opção de adicionar *tags*, que são rótulos personalizados usados para organização, filtragem, gestão de custos e até segurança. Neste caso, vamos adicionar a seguinte:  
      ![image](https://github.com/user-attachments/assets/6525841b-66d9-4647-91cc-0469dd918d8f)  

  * Feito isso, é só clicar em *Create Security Group*.  

**3**. Criar uma **instância EC2 (Amazon Linux)** e associá-la à VPC e ao Security Group.
  * Na barra de pesquisa do console AWS, pesquise por EC2, clique em *Instances* e depois em *Launch instances*.
  * No primeiro campo escolhemos as tags para nossa instância EC2.
  * No segundo campo escolhemos a AMI, que é uma imagem pré-configurada da instância EC2, ela contém o SO e outras configurações.
     * Nesse caso, vamos utilizar a Amazon Linux 2023.
  * No terceiro campo temos o tipo da instância, vamos selecionar a "t2.micro".
  * A *Key pair* são as chaves de acesso para a instância EC2.
     * Clique em *Create new key pair* e escolha um nome para sua chave, o tipo vai ser *RSA* e o formato vai ser *.ppk*.
  * No quarto campo temos a configuração de *Network settings*, aqui temos algumas configurações importantes.
     * *VPC* - Vamos selecionar a VPC criada anteriormente.
     * *Subnet* - Seleciona uma subnet pública.
     * *Auto-assign public IP* - Clique em *Enable* para habilitar o IP público da nossa instância.
     * *Firewall (security groups)* - Marque a opção *Select existing security group*.
        * *Common security groups* - Selecione o security group criado anteriormente.
  * *Configure storage*:
     * É a configuração do armazenamento.
        * Vamos utilizar 8 GB e selecionar o tipo *GP3*.
  * *Advanced details*:
    * Aqui há diversas configurações, mas o que vamos configurar é a chamada *User Data*, que é um script executado automaticamente ao iniciar a instância.
        * O script usado para o projeto está neste repositório como o nome "ScriptUserData.txt"

* Clicando em *Launch instance*, nossa instância será criada.
  
**4** Acessando a instância via SSS.
  * Antes de acessar a instância click em *Security*, depois em *Security Group* e altere as *Inbound roles*
  * Na regra de SSH selecionamos a opção *My Ip*, isso vai permitir que acessemos a isntancia com o nosso IP.
  * Com a instância selecionada copiamos o *Public IPv4 address*.
  * Cole o Ip no PUTTY e antes de conectarmos devemos seguir esses passos:
     * Click em *SSH < Auth < Credentials*
     * Selecionando o botão *browser* ache Key Pair na sua máquina.
  * Agora sim podemos conectar a instância.

**5** Configurando o servidor para reiniciar automaticamente.
  * Siga os seguintes passos com os seguintes comandos:
  * Caminhe até o diretório *system*
     * ```cd /usr/lib/systemd/system/ ```
     * ```sudo nano nginx.service```
     * ```
       Restart=always
       RestartSec=5s ```
     * ```sudo systemctl daemon-reload```
     * ```sudo systemctl enable nginx```
     * ```sudo systemctl restart nginx```
     * ```
       sudo systemctl kill nginx
       sudo sleep 7
       sudo systemctl status nginx
**6** Configurando o sistema de notificações via Discord.
**7** Testando a implementação.
    
