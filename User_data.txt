#!/bin/bash
# Projeto Linux + AWS

# Configure repository for nginx (latest released)
sudo cat << 'EOF' >> /etc/yum.repos.d/nginx.repo
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/amzn2/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true
priority=9
EOF

# Update system and install nginx
sudo yum update -y && sudo yum install nginx -y

# Create sample HTML file
sudo cat << 'EOF' > /usr/share/nginx/html/index.html

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
 		<meta lang = "pt-br">
		 <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="img" href="img" type="img">
		<style>
			@charset "UTF-8";

			@import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&display=swap');

			@font-face {
				font-family: 'Android';
				src: url('../fontes/idroid.otf') format('opentype');
				
			}

			:root {
				--cor0: hsl(252, 54%, 79%);
				--cor2: hsl(219, 31%, 35%);
				--cor3: rgb(50, 44, 85);

				--fonte-padrao: Arial, Verdana, Helvetica, sans_serif;
				--fonte-destaque: 'Bebas Neue', cursive;
				--font-android: 'Android', cursive;

				--box-shadow-padrao-texto: 2px 2px 5px rgba(0, 0, 0, 0.400);

				--simbolo-link-externo: "\00a0\1F517";
			}

			* {
				font-family: var(--fonte-padrao);
				margin: 0px;
				padding: 0px;
			}

			body {
				padding: 1px;
				margin: 0px;
				background: var(--cor0);
			}

			/* Palavras Grifadas no texto */
			strong {
				color: var(--cor3);
				font-weight: bold;
				text-shadow: var(--box-shadow-padrao-texto)
			}


			header {
				height: 110px;
				margin: 0px;
				padding: 10px;
				background-image: linear-gradient(to bottom, var(--cor2), var(--cor3));
				box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.400);
			}

			header h1 {
				color: white;
				font-size: 40px;
				font-family: var(--fonte-destaque);
				padding: 15px;
				margin-top: 12px;
				text-align: center;
				text-shadow: var(--box-shadow-padrao-texto)
			}

			header p {
				color: white;
				font-size: 1em;
				padding: 0px;
				padding-top: 20px;
				text-align: center;
				text-shadow: var(--box-shadow-padrao-texto)
			}


			nav {
				background-color: var(--cor3);
				padding: 10px;
				box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.400);
			}

			nav > a {
				color: white;
				padding: 10px;
				text-decoration: none;
				font-weight: bold;
				border-radius: 5px;
				transition-duration: 1s;
			}

			nav > a:link, nav > a:visited {
				color: white;
			}

			
			nav > a:hover {
				background-color: var(--cor2);
			}

			main {
				min-width: 300px;
				max-width: 1000px;
				margin: auto;
				margin-bottom: 10px;
			}

			/* Paragrafos */ 
			main p {
				color: black;
				text-align: justify;
				text-indent: 2em;
				line-height: 2em;
				padding-bottom: 20px;
			}

			main a {
				text-decoration: none;
				color: var(--cor3);
				font-weight: bolder;
				padding: 2px;
			}

			main a::after {
				content: var(--simbolo-link-externo);
			}

			main a:hover {
				color: white;
				background-color: var(--cor3);
				padding: 2px;
			}


			article {
				background-color: white;
				box-shadow: 0px 0px 6px rgba(0, 0, 0, 0.400);
				border-radius: 0px 0px 5px 5px;
				padding: 20px;
				padding-bottom: 10px;
			}

			/* Tutulos */
			article h1 {
				color: var(--cor3);
				font-size: 2em;

				text-align: center;
				text-shadow: 2px 2px 3px rgba(0, 0, 0, 0.400);

				font-family: var(--font-android);
				padding: 20px;
				margin: 0px;
			}

			/* Subtitulos */
			article h2 {
				color: var(--cor3);
				background-image:  linear-gradient(to right, var(--cor0), transparent);

				font-family: var(--font-android);
				text-shadow: var(--box-shadow-padrao-texto);

				border-radius: 10px 0px 0px 10px;
				
				padding: 2px;
				padding-left: 10px;

				margin: 20px;
				margin-left: 0px;
			}


			img {
				width: 100%;
			}


			.pequena {
				display: block;
				width: 200px;
				margin: auto;
			}


			.boxVideo {
				position: relative;
				background-color: var(--cor3);
			
				padding-bottom: 56.25%; 
				padding-top: 25px;
				margin: 0px;
			}

			.boxVideo iframe {
				position: absolute;
				top: 2.5%;
				left: 5%;
				width: 90%;
				height: 95%;
			}


			aside {
				background-color: #C5EBD6;
				border-radius:0px 0px 5px 5px;
				box-shadow: 1px 1px 3px rgba(0, 0, 0, 0.400);
				padding: 10px;
				margin-top: 20px;
				margin-bottom: 20px;
			}

			aside h3 {
				border-radius:5px 5px 0px 0px;
				background-color: #39338d;	
				color: white;
				font-size: 1em;
				padding: 10px;
				margin: -10px -10px 20px -10px;
			}

			aside p {
				text-align: justify;
				text-indent: 1em;
			}

			aside > ul {
				list-style-type: '\2714\00a0\00a0';
				list-style-position: inside;
				columns: 2;
				padding: 30px;
			}


			/* Rodapé */
			footer > p {
				background-color: var(--cor3);
				color: white;
				text-align: center;
				font-size: 0.8em;
				padding: 5px;
				margin-bottom: 0px;
			}

			footer a {
				font-weight: bold;
				color: white;
				text-shadow: var(--box-shadow-padrao-texto);
				text-decoration: none;
				padding: 2px;
			}

			footer a:hover {
				color: black;
				background-color: white;
				padding: 2px;
			}

			footer a::after {
				content: var(--simbolo-link-externo);
			}
		</style>
	<body>
		<header>	
		   <h1>PROJETO LINUX + AWS </h1>
		</header>
		<nav>
			<a href="#introducao" target="_self">Introdução</a>
			<a href="#projeto" target="_self">Projeto</a>
			<a href="#conclusao" target="_self">Conclusão</a>
		</nav>
		<main>
			<article id="introducao">
				<h2>Introdução</h2>
				<h4>Este projeto tem como objetivo <strong> desenvolver e testar habilidades em Linux, AWS e automação de processos</strong> por meio da configuração de um ambiente de servidor web monitorado. A implementação será dividida em quatro etapas principais:</h4><br>
				<br>

				<ul style="padding-left: 50px;">
					<li><strong>Configuração do Ambiente</strong> - Criar uma VPC na AWS com sub-redes públicas e privadas, configurar uma instância EC2 Linux e definir regras de segurança adequadas.</li>
					<li><strong>Configuração do Servidor Web</strong> - Instalar e configurar o Nginx para hospedar uma página HTML simples.</li>
					<li><strong>Monitoramento e Notificações</strong> - Criar um script de monitoramento que verifica a disponibilidade do site e envia alertas via Webhook do Discord ou outra plataforma.</li>
					<li><strong>Automação e Testes</strong> - Validar a implementação, documentar o processo e garantir que os alertas e a recuperação automática do serviço estejam funcionando corretamente. Este projeto simula um ambiente real de administração de servidores e monitoração, fortalecendo o conhecimento prático em infraestrutura na nuvem e automação.</li>
				</ul>
				<br>

				<picture>
					<img src="https://blog.schoolofnet.com/wp-content/uploads/2018/11/expert-amazonAWS.png" alt="AWS">
					</picture>

					</div>
						<h2 id = "projeto">Projeto</h2>
						<h3>Configuração do Ambiente</h3>
						<p>Nesta etapa, configuramos a infraestrutura necessária para hospedar nosso servidor web na AWS.</p>
						<ul style="padding-left: 50px;">
							<li><strong>Criar uma VPC na AWS</strong> com sub-redes públicas e privadas.</li>
							<li><strong>Criar uma instância EC2</strong> baseada em Linux.</li>
							<li><strong>Associar um Security Group</strong> permitindo HTTP (porta 80) e SSH (porta 22).</li>
							<li><strong>Acessar a instância via SSH</strong> para configurações futuras.</li>
						</ul><br>
						
						<h3>Configuração do Servidor Web</h3>
						<p>Após configurar a infraestrutura, instalamos e configuramos um servidor Nginx na EC2.</p>
						<ul style="padding-left: 50px;">
							<li>Instalar o Nginx.</li>
							<li>Criar uma página HTML para exibição.</li>
							<li>Configurar o Nginx corretamente.</li>
							<li>Garantir que o Nginx reinicie automaticamente com systemd.</li>
						</ul><br>
						
						<h3>Monitoramento e Notificações</h3>
						<p>Para garantir a disponibilidade do site, criamos um sistema de monitoramento e notificações.</p>
						<ul style="padding-left: 50px;">
							<li>Script em (Bash/Python) para verificar se o site responde corretamente.</li>
							<li>Registrar logs das verificações em <code>/var/log/monitoramento.log</code>.</li>
							<li>Enviar alertas via Discord.</li>
							<li>Automatizar a execução com cron ou systemd.</li>
						</ul><br><br>
						
						<h3>Automação e Testes</h3>
						<p>Por fim, testamos e documentamos toda a configuração.</p>
						<ul style="padding-left: 50px;">
							<li>Verificar acessibilidade do site.</li>
							<li>Testar notificações ao parar o Nginx.</li>
							<li>Criar documentação explicando a implementação.</li>
							<li>Adicionar prints dos testes no GitHub.</li>
						</ul><br>

						<br><br>
						<div>
							<h2 id = "projeto">Conclusão</h2>
							<p>Este projeto foi fundamental para consolidar o conhecimento prático em administração de servidores e infraestrutura na nuvem. A criação da VPC, a configuração da instância EC2 e a implementação do Nginx garantiram a construção de uma base sólida para a hospedagem e a segurança do ambiente. A automação do monitoramento e a integração com o Webhook do Discord trouxeram um nível de inteligência e proatividade ao processo, permitindo respostas rápidas a eventuais falhas.</p>
							<p>Além disso, a validação dos testes e a documentação do processo foram essenciais para garantir a robustez e a confiabilidade do sistema, criando um ambiente resiliente e eficiente. Com a conclusão deste projeto, é possível simular um cenário real de administração de servidores em nuvem, adquirindo experiência valiosa em ferramentas modernas de infraestrutura e automação.</p>
						</div>
					</ul>			
		</article>
		</main>
		<footer id="conclusao">
			<p>Para mais informações entre em contato: dudubmatos@gmail.com</p>
		</footer>
	</body>
</html>
 
EOF

# Enable and start nginx service
sudo systemctl enable nginx --now
