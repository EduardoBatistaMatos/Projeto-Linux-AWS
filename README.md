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
  
### **Pré-requisitos**  
- **Conta AWS** com permissões de administração.  
- **Conta no Discord** para testarmos o sistema de notificações.  
- **Ter instalado o PuTTY** para acessar a instância via SSH.  

### **Provisionamento da Infraestrutura**  

**1️⃣ Criar uma VPC (Virtual Private Cloud).**
  * É semelhante a uma rede LAN (Local Area Network) na nuvem, mas com mais flexibilidade e recursos de isolamento.  
  * Na barra de pesquisa do console AWS, pesquise por VPC, clique em *Your VPCs* e depois no botão *Create VPC*.  
  * Agora vamos configurar a VPC. Primeiro, temos duas opções: *VPC only*, que podemos configurar mais especificamente, e *VPC and more*, que vem previamente configurada. Vamos selecionar a segunda opção. Logo abaixo, há um *checkbox* e um campo de texto para adicionarmos uma etiqueta que será usada para nomear todos os recursos na VPC. Nesse caso, vamos marcar o *checkbox* para gerar automaticamente as etiquetas e colocar o nome desejado.  
  * Por padrão, a VPC já vem com duas subnets públicas e duas subnets privadas em duas regiões diferentes, com um *Internet Gateway* conectado às sub-redes públicas, mas vale conferir.  
  * Feito isso, a VPC deverá ficar assim:  
    ![image](https://github.com/user-attachments/assets/5de410da-9847-48f8-98fe-d999febc1cbb)  
  * Agora é só clicar em *Create VPC*, esperar carregar e pronto, a VPC está criada.  

**2️⃣ Criar um Security Group**.
  * É basicamente um firewall que controla as regras de entrada e saída da instância EC2. Aqui, vamos permitir os tráfegos HTTPS/HTTP e SSH.  
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

**3️⃣ Criar uma instância EC2 (Amazon Linux) e associá-la à VPC e ao Security Group.**
  * Na barra de pesquisa do console AWS, pesquise por EC2, clique em *Instances* e depois em *Launch instances*.
  * No primeiro campo, escolhemos as tags para nossa instância EC2.
  * No segundo campo, escolhemos a AMI, que é uma imagem pré-configurada da instância EC2, ela contém o SO e outras configurações.
     * Nesse caso, vamos utilizar a Amazon Linux 2023.
  * No terceiro campo, temos o tipo da instância, vamos selecionar a "t2.micro".
  * A *Key pair* são as chaves de acesso para a instância EC2.
     * Clique em *Create new key pair* e escolha um nome para sua chave, o tipo vai ser *RSA* e o formato será *.ppk*.
  * No quarto campo, temos a configuração de *Network settings*, aqui temos algumas configurações importantes.
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
        * O script usado para o projeto está neste repositório com o nome "UserData.bash".

* Clicando em *Launch instance*, nossa instância será criada.
  
**4️⃣ Acessando a instância via SSH.**
  * Antes de acessar a instância, clique em *Security*, depois em *Security Group* e altere as *Inbound rules*.
  * Na regra de SSH, selecione a opção *My IP*, isso permitirá que acessemos a instância com o nosso IP.
  * Com a instância selecionada, copie o *Public IPv4 address*.
  * Cole o IP no PUTTY e, antes de conectarmos, siga esses passos:
     * Clique em *SSH < Auth < Credentials*.
     * Selecionando o botão *Browse*, encontre a Key Pair na sua máquina.
  * Agora sim podemos conectar à instância.
  * O usuário padrão é ec2-user.

**5️⃣ Configurando o servidor para reiniciar automaticamente.**
  * Siga os seguintes passos com os seguintes comandos:
  * Caminhe até o diretório *system*: ```cd /usr/lib/systemd/system/```
  * Edite o arquivo nginx.service: ```sudo nano nginx.service```
  * Insira o comando abaixo:
     * ```
       Restart=always
       RestartSec=5s
     ```
  * O arquivo ficará dessa forma:

      ![image](https://github.com/user-attachments/assets/ffb4f700-fc8b-4fde-aec3-d4227a55d864)
  * Para salvar e sair, basta dar os comandos ``CTRL + O``, ``Enter`` e ``CTRL + X``.
  * Recarregue as configurações do systemd após alterações: ```sudo systemctl daemon-reload```
  * Ative o Nginx para iniciar automaticamente no boot: ```sudo systemctl enable nginx```
  * Inicie o serviço Nginx:   ```sudo systemctl start nginx```
  * Reinicie o serviço Nginx: ```sudo systemctl restart nginx```
     
**6️⃣ Configurando o sistema de notificações via Discord.**
  * Antes de tudo, precisamos instalar o CROND, pois, por padrão, ele não vem instalado no Amazon Linux. Para fazer a instalação, siga os seguintes passos:
    * Instale o crond: ```sudo yum install cronie```
    * Inicie o serviço: ```sudo systemctl start crond```
    * Ative o crond para iniciar automaticamente no boot: ```sudo systemctl enable crond```
    * Verifique o status do serviço: ```sudo systemctl status crond```
    * A saída do comando deve ser assim:
      ![image](https://github.com/user-attachments/assets/0bd80955-8199-491f-a3b0-5aa2cd443c31)
  * Com o Discord aberto, clique no ícone de "+" para adicionar um novo servidor.
  * Clique em "Criar o meu", clique em "Para meus amigos e eu", escolha o nome desejado e clique em "Criar".
  * Selecione "Configurações do servidor", no menu à esquerda, clique em "Integrações", depois em "Webhooks", clique em "Novo webhook", dê um nome a ele e clique em "Copiar a URL".
  * Abra um bloco de notas e cole a URL do webhook.
  * No terminal Linux, siga esses passos:   
  * Caminhe até o diretório de log: ```cd /var/log```  
  * Crie e salve o arquivo monitoramento.sh:   ```sudo nano monitoramento.log```
  * Dê permissão de leitura e escrita para todos no arquivo monitoramento.log:   ```sudo chmod 666 monitoramento.log```
  * Volte ao diretório raiz: 	```cd /``` 
  * Crie o diretório monitoramento em /opt/:   ```sudo mkdir /opt/monitoramento```
  * Caminhe até o diretório monitoramento: ```cd /opt/monitoramento/```
  * Crie o arquivo monitorar_site.sh em /opt/monitoramento/:   ```sudo nano monitorar_site.sh```
  * Copie o script *Discord_logs.bash* colocando o IP e a URL do seu Discord, cole no arquivo e salve as alterações.
  * Conceda permissão de execução ao script: ```sudo chmod +x /opt/monitoramento/monitorar_site.sh```
  * Abra o editor do cron para agendar tarefas automáticas:  ```crontab -e```
  * Agende o script para rodar a cada minuto: ```*/1 * * * * /opt/monitoramento/monitorar_site.sh```

**7️⃣ Como funciona o Script de monitoramento.**
 * A explicação do script se encontra nele mesmo em forma de comentário.
   
**8️⃣ Testando a implementação.**

 * No seu navegador, cole o IP da sua instância.
 * Este IP deverá retornar este site:
    ![image](https://github.com/user-attachments/assets/a35e47be-6829-4e64-88cc-4cae28d46dff)
   
 * Para validar se o script de reinicialização está funcionando corretamente, siga estes passos:
     * Encerre o serviço Nginx com o comando kill, pause por 7 segundos e verifique o status do serviço Nginx.
     * ```
       sudo systemctl kill nginx
       sudo sleep 7
       sudo systemctl status nginx
     * A saída do comando deverá ser assim:
     ![image](https://github.com/user-attachments/assets/01bbcfd5-9ce6-4513-9ab7-9deaa34d3400)

 * Para validar se o sistema de monitoramento está funcionando corretamente, siga esses passos:
     * Encerre o serviço Nginx com o comando stop: ```sudo systemctl stop nginx```
     * Veja em tempo real as últimas linhas do log: ```sudo tail -f /var/log/monitoramento.log```
     * Abra o Discord e aguarde até um minuto para o sistema de alertas enviar a seguinte notificação:
       ![b32f2fe8-b217-4c52-8b80-4584f517ec2f](https://github.com/user-attachments/assets/3957bda5-2652-4ab0-b2fd-448e1ef44585)
 * Para iniciar o servidor Nginx novamente, basta inserir o seguinte comando: ```sudo systemctl start nginx```
