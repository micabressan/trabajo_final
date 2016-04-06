# Desenvolvedor: zCouDray #
# Skype: ramonxd131, Email: ramonxd1@hotmail.com #

# Variaveis: #
# {data} retorna a data que o log foi feito, exemplo: 10/04/2015 11:48:17 #
# {local} retorna a coordenada do jogador, exemplo: X- 10 Y- 15 Z-35 #
# {mundo} retorna o nome do mundo que o jogador esta! #
# {comando} retorna ao comando usado, exemplo: "/kill player" (USE APENAS NO LOG DE COMANDO) # 

Sistema:
  Senha: "abc123"
Mensagens:
  Senha-Incorreta: "&cA senha digitada esta incorreta!"
  Sucesso: "&aVoce adicionou o staff {staff} na lista."

Logs:
  Quebrou_Bloco:
    Ativar: true
    Formato:
    - "As {data} o staff {staff} quebrou um bloco"
    - "Localizado em: {local} no mundo {mundo}"
    - "----------------Separador------------------"
  Colocou_Bloco: 
    Ativar: true
    Formato:
    - "As {data} o staff {staff} colocou um bloco"
    - "Localizado em: {local} no mundo {mundo}"
    - "----------------Separador------------------"
  Bateu: 
    Ativar: true
    Formato:
    - "As {data} o staff {staff} bateu em um jogador"
    - "Localizado em: {local} no mundo {mundo}"
    - "----------------Separador------------------"
  Abriu_Bau: 
    Ativar: true
    Formato:
    - "As {data} o staff {staff} abriu um bau"
    - "Localizado em: {local} no mundo {mundo}"
    - "----------------Separador------------------"
  Dropou_Item: 
    Ativar: true
    Formato:
    - "As {data} o staff {staff} dropou um item"
    - "Localizado em: {local} no mundo {mundo}"
    - "----------------Separador------------------"
# Coloque os comandos que serao vigiados! #
  Comando: 
    Ativar: true
    Comandos:
    - "//set"
    - "/kill"
    - "/setwarp"
    - "/evento iniciar"
    Formato:
    - "As {data} o staff {staff} usou o comando"
    - "> {comando}"
    - "Localizado em: {local} no mundo {mundo}"
    - "----------------Separador------------------"