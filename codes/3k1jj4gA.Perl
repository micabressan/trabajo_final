#!/bin/bash

#Shell para converter video.
#Dependências:
# - ffmeg

#Parâmetro:
# - $1 = Nome do arquivo ou diretorio do arquivo original.
# - $2 = Nome do arquivo que será gerado
# - $3 = Resolucao do video que será gerado.


ffmpeg -i $1   -b 500 -s $3 $2


#Usando:
# 1 - Altere a permissão do arquivo criado para execução(chmod +x)
# 2 - ./{$nomeDoArquivo} video.flv video.mp4 1280x720