# 🔥 Projeto Linux + AWS  

## 📌 Visão Geral
Este projeto configura uma infraestrutura na AWS baseada em **Linux**, utilizando **VPC, Subnets, Security Groups e EC2 (Amazon Linux)** para hospedar um servidor **Nginx**. Além disso, há um **webhook do Discord** para envio de notificações automáticas.

## 🛠️ Tecnologias Utilizadas
- **AWS VPC** → Configuração de rede isolada.  
- **Subnets** → Organização dos recursos em diferentes zonas de disponibilidade.  
- **Security Groups** → Regras de firewall para controle de acesso.  
- **EC2 (Amazon Linux)** → Instância principal do servidor.  
- **Nginx** → Servidor web configurado na instância.  
- **Webhook do Discord** → Notificações automáticas sobre status do servidor.  

### 1️⃣ **Pré-requisitos**
- **Conta AWS** com permissões de administração.
  
### 2️⃣ **Provisionamento da Infraestrutura**
**1**. Criar uma **VPC** (Virtual Private Cloud) é como uma rede LAN (Local Area Network) na nuvem, mas com mais flexibilidade e recursos de isolamento.
  * Na barra de pesquisa do concole AWS pesquise por VPC, click em Your VPCs e depois no botão "Create VPC".
  * Agora vamos configurar a VPC, primeiro temos duas opções a "VPC only" que podememos configurar mais especificamente e temos também a "VPC and more" que vem préviamente configurada, vamos selecionar a segunda opção, logo abaixo temos checkbox e um campo de texto para colocarmos uma etiqueta a qual sera  usada para dar nome a todos os recurso na VPC, nesse caso vamos marcar o check box para gerar automaticamente as etiquetas e colocar o nome desejado.
  * Por padrão a VPC já vem com duas subnets publicas e duas subnets privadas em duas regioes diferentes com um internet gateway conectado as sub-redes publicas, mas vale dar uma conferida
  * Feito isso a VPC devera ficar dessa maneira:
  * 
    ![image](https://github.com/user-attachments/assets/5de410da-9847-48f8-98fe-d999febc1cbb)

  * Agora é só clicar em "Create VPC", esperar caregar e pronto a VPC está criada.
 
**2**. Criar um **Security Groups**, é basicamnete um firewall que controla as regras de entrada e de saida da instancia EC2, aqui no caso vamos permitir os tráfegos HTTPS/HTTP e SSH.
  * Na barra de pesquisa do concole AWS pesquise por EC2, dentro das opçcões de Network & Security click em "Security group" e depois no botão "Create security grop".
  * No primero campo colocamos o nome do Security Group, no segundo campo colocamos a descrição do mesmo e no terceiro a VPC a qual ele vai ser associada (no caso vamos selecionar a VPC criada anteriormente).
  * Abaixo temos as Inbound rules e as Outbound rules que são as regras de entrada e de saida.
    Vamos adicionar as seguintes Inbound rules clicando em "Add rule".
      ![image](https://github.com/user-attachments/assets/aac4c330-7e46-4698-8bda-d39b6a7f16bb)
      ![image](https://github.com/user-attachments/assets/c5a56817-3b4e-40f7-9203-0cc6ff528349)
      ![image](https://github.com/user-attachments/assets/50651544-a188-42e0-b5c1-e9b9603e493b)
   
  * Já na outbound rules nesse caso podemos deixar o trafico de saida aberto para todos desta maneira:
      ![image](https://github.com/user-attachments/assets/76f059d1-8b56-4138-aea9-180a1e921319)

  * Por ultimo temos a opção de adicionar tags, são rótulos personalizados que servem para organização, filtragem, gestão de custos e até segurança, nesse caso vamos por a seguinte:
      ![image](https://github.com/user-attachments/assets/6525841b-66d9-4647-91cc-0469dd918d8f)

  * Feito isso é só clicar em "Create security group".


4. Criar uma **instância EC2 (Amazon Linux)** e associá-la à VPC e Security Group.  
