#!/bin/bash
# Define o interpretador do script como Bash.


SITE_URL="http://COLE O IP DA SUA INSTÂNCIA"
# Variável que armazena a URL do site que será monitorado (endereço IP neste caso).


DISCORD_WEBHOOK_URL="COLE O IP DO SEU WEBHOOK"
# Variável que armazena a URL do webhook do Discord, para onde serão enviados os alertas.


LOG_FILE="/var/log/monitoramento.log"  # Corrigido o caminho para o diretório completo
# Define o caminho do arquivo de log onde as informações do monitoramento serão armazenadas.

DATE=$(date "+%Y-%m-%d %H:%M:%S")
# Cria uma variável que armazena a data e hora atual no formato "YYYY-MM-DD HH:MM:SS".

# Verifica se o site está acessível
HTTP_STATUS=$(curl -s --head --request GET "$SITE_URL" | grep HTTP | awk '{print $2}')
# Utiliza o comando `curl` para enviar uma requisição HEAD ao site especificado (sem baixar o conteúdo), capturando apenas o código HTTP retornado.
# O comando `grep HTTP` filtra a linha com o código HTTP, e `awk '{print $2}'` extrai o código HTTP (o número que aparece após "HTTP/1.1").

# Verifica se o código de status HTTP está entre 200 e 399 (site acessível)
if [[ "$HTTP_STATUS" -ge 200 && "$HTTP_STATUS" -le 399 ]]; then
    echo "$DATE: O site está online." >> "$LOG_FILE"
    # Se o código HTTP for entre 200 e 399, o site está online.
    # A data e uma mensagem confirmando que o site está online são gravadas no arquivo de log.
else
    echo "$DATE: O site está fora do ar! Enviando alerta para o Discord." >> "$LOG_FILE"
    # Se o código HTTP não estiver entre 200 e 399, significa que o site está fora do ar.
    # A data e uma mensagem de erro são gravadas no arquivo de log, informando que o site está fora do ar e que um alerta será enviado.

    # Mensagem JSON para o Discord
    JSON_PAYLOAD=$(cat <<EOF
{
  "username": "Monitor de Site",
  "content": "🚨 O site **$SITE_URL** está fora do ar! 🚨"
}
EOF
)
# Cria a mensagem em formato JSON, que será enviada ao Discord. A mensagem informa que o site está fora do ar e inclui a URL do site monitorado.

    # Envia a mensagem JSON ao Discord através do webhook configurado, utilizando o comando `curl`.
    curl -H "Content-Type: application/json" -X POST -d "$JSON_PAYLOAD" "$DISCORD_WEBHOOK_URL"
    # O `Content-Type: application/json` especifica que o corpo da requisição está no formato JSON.
    # O `-d "$JSON_PAYLOAD"` envia os dados JSON gerados.
    # A URL do webhook (armazenada na variável `DISCORD_WEBHOOK_URL`) é o destino da requisição POST.
fi
