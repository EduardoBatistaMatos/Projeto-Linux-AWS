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
1. Criar uma **VPC** (Virtual Private Cloud) é como uma rede LAN (Local Area Network) na nuvem, mas com mais flexibilidade e recursos de isolamento.
  * Na barra de pesquisa do concole AWS pesquise por VPC, click em Your VPCs e depois no botão "Create VPC".
  * Agora vamos configurar a VPC, primeiro temos duas opções a "VPC only" que podememos configurar mais especificamente e temos também a "VPC and more" que vem préviamente configurada, vamos selecionar a segunda opção, logo abaixo temos checkbox e um campo de texto para colocarmos uma etiqueta a qual sera  usada para dar nome a todos os recurso na VPC, nesse caso vamos marcar o check box para gerar automaticamente e vamos colocar o nome de "projeto_linux_aws".
  * Por padrão a VPC já vem com duas subnets publicas e duas subnets privadas em duas regioes diferentes com um internet gateway conectado as sub-redes publicas, mas vale dar uma conferida
  * Feito isso a VPC devera ficar dessa maneira:
  * 
    ![image](https://github.com/user-attachments/assets/5de410da-9847-48f8-98fe-d999febc1cbb)

  * Agora é só clicar em "Create VPC", esperar caregar e pronto a VPC está criada.
 

 
3. Criar **Security Groups** para permitir tráfego HTTP/HTTPS e SSH.  
4. Criar uma **instância EC2 (Amazon Linux)** e associá-la à VPC e Security Group.  
