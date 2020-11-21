# GREEN SKULL

**Identificação do Jogo:** Green Skull  
**Identificação do Grupo:**  
- Diogo Santos (up201806878)  
- Tomás Gonçalves(up201806763)

---

# Instalação

Para poder instalar este jogo basta fazer o download dos ficheiros, depois no sicstus(ou outro ambiente de prolog) fazer consult do ficheiro *green_skull.pl* depois disso basta escrever o predicado *play* e o jogo começa a correr.

# Descrição
**Introdução**

Green Skull é um jogo de tabuleiro disputado por dois jogadores. O material necessário para jogar é: um tabuleiro, peças redondas (8 verdes, 10 roxas e 10 brancas) e uma peça não redonda (geralmente em formato de crânio). 

![tabuleiro_real](imagens/tabuleiro_real.png)


O tabuleiro é de formato triangular sendo que cada lado contém 10 células, e cada um destes lados apresenta bordas de cores correspondentes aos três tipos de peças.

Os três tipos de peças representam diferentes criaturas mitológicas (embora a representação seja apenas abstrata). As peças verdes são chamadas de Zombies, as brancas de Orcs e as roxas de Goblins. 

**Instruções de jogo**

Ao iniciar o jogo, um jogador toma posse dos Goblins enquanto que o adversário controla os Orcs. O controlo das peças Zombie vai alternando entre os dois jogadores à medida que vão jogando (embora seja primeiro atribuído ao jogador que possui os goblins). 

Ambos os jogadores podem efetuar um de dois movimentos possíveis:
-O primeiro é deslocar uma das suas peças para uma casa adjacente vazia. 

![movimento1](imagens/movimento1.png)


-Pode também efetuar um ou mais saltos em linha reta sobre outra peça (incluindo peças do próprio jogador) caindo numa casa vazia. Estas peças pelas quais a peça vai passando por cima vão sendo removidas do tabuleiro. Se o jogador que possui o crânio optar por este segundo movimento, deve ceder o crânio ao seu adversário tendo agora ele posse dos Zombies. 

![movimento2](imagens/movimento2.png)


O jogador que possui o crânio pode ainda mover uma das peças zombies após cada jogada com as suas respetivas peças. 

O jogo termina quando todas as peças de um tipo forem comidas ou estiverem em contacto com a borda da mesma cor. 
 
 **Pontuação**

Vence a espécie que obtiver mais pontos de acordo com a seguinte contagem:

-cada espécie recebe 2 pontos por cada peça que toque a borda da sua cor
-cada espécie recebe 1 ponto por cada peça capturada que não seja da sua cor

Página do Jogo: https://nestorgames.com/rulebooks/GREENSKULL_EN.pdf

# Lógica do Jogo

## Representação interna do estado do jogo

O estado do jogo é representado através da estrutura *state(Board, Player, ZPlayer, XEliminated, OEliminated, ZEliminated)*.

![state](imagens/state.png)

Nesta estrutura Board representa o tabuleiro de jogo, Player representa o jogador atual(*X*, *O* ou *Z*), ZPlayer representa o jogador que detém posso sobre o *green skull* (*X* ou *O*), ou seja, sobre os zombies, XEliminated representa o número de peças X eliminadas do tabuleiro, OEliminated representa o número de peças eliminadas do tabuleiro e finalmente ZEliminated representa o número de peças Z eliminadas do tabuleiro.

O tabuleiro triangular é representado através de uma lista de listas com a seguinte disposição:

**Estado inicial do jogo:**
![tabela_inicial](imagens/initial_board.png)

O tabuleiro é criado com as peças nas suas posições iniciais. As peças Zombie são representadas visualmente pela letra “Z”, Goblins por “O” e Orcs por “X”. 
 

Os três tabuleiros seguintes representam estados de jogo intermédios. Podemos observar algumas peças movidas e outras retiradas do tabuleiro.


**Estados intermédios do jogo:**
![tabela_intermedia](imagens/tabela_intermedia.png)


Esta última tabela mostra-nos o estado final do jogo. O jogo terminou pois todas as peças Zombie (“Z”) estão em contacto com a face do tabuleiro correspondente à sua cor (neste caso a base do triângulo). 

**Estado final do jogo:**
![tabela_final](imagens/tabela_final.png)


Guardamos a informação de qual o jogador que deve jogar através do facto que vamos alterando dinamicamente chamado player_turn e guarda uma string que indica qual é o jogador a jogar. Da mesma forma, representamos o detentor do crânio verde com o facto z_belongs_to que também contém uma string que nos diz qual dos dois jogadores controla os zombies nesse instante.
Em relação a peças eliminadas, temos também três factos que alternam dinamicamente: o_eliminated, z_eliminated e x_eliminated; estes factos contêm o número de peças eliminadas da sua espécie. Sempre que alguma destas peças é eliminada no respetivo facto, incrementamos o valor de peças eliminadas.
Em relação à representação das peças, são utilizadas strings como descrito anteriormente, cada uma situada na sua posição específica do tabuleiro.


## Visualização do Estado de jogo

Para se poder visualizar o estado atual do jogo temos de recorrer ao predicado display_game/2 que recebe como primeiro parámetro o estado atual do jogo e como segundo o jogador atual.

![display_game](imagens/display_game.png)

Este predicado recorre a outros três predicados que fazem o seguinte:

- display_board/1: recebe como parâmetro o tabuleiro atual de jogo e apresenta também as linhas e colunas de cada elemento para facilitar a escolha da peça a mover, tal como a casa para onde a mesma deve ser movida. Este predicado recorre a outro predicado “print_row1/1” que imprime a linha 1, este por sua vez chama o “print_row2/1” que imprime a linha 2 e assim sucessivamente até à linha 10. Na imagem que se segue é possivel observar a representação do tabuleiro inicial do jogo.

![tabuleiro_jogo](imagens/display_initial_board.png)

- display_number_eliminated/4: recebe nos três primeiros parâmetros o número de peças de cada tipo eliminadas e no quarto argumento recebe o jogador que detém posse sobre os zombies. O que este predicado faz é apresentar uma tabela indicativa do número de peças eliminadas de cada espécie e indicar também o jogador que possui a caveira. 

- display_player_turn/1: recebe como primeiro parâmetro o jogador atual e apresenta no ecrã uma mensagem que indica quem é o jogador a fazer a próxima jogada. A imagem que se segue mostra o resultado destes dois últimos predicados.

![tabuleiro_jogo](imagens/tabela.png)

Em relação aos menus temos o seguinte: ao correr inicialmente o jogo é nos apresentado o menu principal no qual nos é pedido para escolher um dos três estilos de jogo: humano contra humano, humano contra computador ou computador contra computador.

![menu_principal](imagens/main_menu.png)

Para isto recorremos ao predicado main_menu/0 que por sua vez chama o display_main_menu/0 que simplesmente mostra o menu, recorremos também ao ask_menu_option/2 que vai pedir uma opção ao utilizador e ao mesmo tempo vai também validá-la e recorremos também ao predicado next_state/2 que com base no estado atual e na opção do utilizador vai decidir qual é o estado de jogo seguinte.

![menu_principal_predicado](imagens/main_menu_pred.png)

Temos outro menu no qual o utilizador pode selecionar qual a dificuldade do jogo(este menu só ocorre caso o utilizador tenha selecionado uma das opções de jogar com computador). Aqui o utilizador pode selecionar um de três niveís de dificuldade: fácil, médio ou difícil.

![menu_de_dificuldade](imagens/difficulty_menu.png)

Para isto recorri ao predicado menu_select_difficulty/1 que por sua vez recorre ao predicado display_menu_select_difficulty/0 que simplesmente mostra o menu e ask_menu_option/2 que vai pedir uma opção ao utilizador e ao mesmo tempo vai também validá-la. Este predicado retorna a dificuldade selecionada pelo utilizador.

![menu_de_dificuldade_predicado](imagens/select_difficulty_pred.png)

Por último temos também outro menu que só aparece caso o utilizador tenha selecionado a opção humano contra computador no qual é possível escolher qual das peças o computador será ou Os ou Xs.

![menu_de_seleção_de_peça](imagens/select_piece.png)

Para isso recorremos ao predicado menu_select_piece/1 que é idêntico ao predicado anterior. Simplesmente recorre ao predicado display_menu_select_piece/0 que mostra o menu e também recorre ao ask_menu_option/2 que vai pedir uma opção ao utilizador e ao mesmo tempo vai também validá-la. Este predicado retorna a peça selecionada pelo utilizador para o computador.

![menu_de_seleção_de_peça_pred](imagens/select_piece_pred.png)

## Lista de jogadas válidas

## Execução de jogadas

Para a a execução de jogadas temos o seguinte predicado move/3.

![move_pred](imagens/move.png)

Este predicado recebe como primeiro parâmetro o estado de jogo atual, como segundo a jogada a efetuar e como terceiro(valor a retornar) o novo estado de jogo que irá existir depois da jogada.  
Como se pode ver este predicado recorre a outros predicados entre os quais estão:

- verifyEatMove/3: este predicado recebe como primeiro parâmetro a jogada a efetuar, como segundo parâmetor recebe o tabuleiro atual e como terceiro e também valor a retornar uma variável que nos diz se a jogada a efetuar é uma jogada de movimento normal ou se alguma peça é "comida". No fundo é isso que este predicado faz, verifica o tipo de jogada, normal ou uma em que se "come" peças;

- execute_moves/11: este predicado recebe no 1º parâmetro o tabuleiro atual, no 2º o jogador atual, no 3º, 4º e 5º o número de cada peças comidas de cada tipo, 6º a jogada atual, 7º o tipo de jogada, 8º o novo tabuelrio depois da execução da jogada, 9º, 10º e 11º os novos valores de peças comidas de cada tipo depois da execução da jogada. No fundo este predicado executa a jogada  removendo a peça selecionada da posição atual, e colocando-a na nova posição e elimina as peças comidas(se tiver sido alguma);

- change_Player_Has_Z/4: este predicado recebe como 1º parâmetro o tipo de jogada, 2º o jogador atual, 3º jogador que detém posse sobre os zombies e como 4º e valor a retornar o jogador que detém posse sobre os zombies depois da jogada ser executada. No fundo o que este predicado faz é tendo em conta a jogada atual muda ou não o jogador que detém o controlo sobre os zombies;

- next_player/4: este predicado recebe como 1º parâmetro o jogador atual, 2º parâmetro o jogador que tinha posse sobre os zombies antes da jogada ser executada, 3º o jogador que detém posso sobre os zombies depois da executada ser executada e como 4º e valor a retornar quem será o jogador a executar a próxima jogada. No fundo o que este predicado faz é tendo em conta a jogada atual dá-nos quem será o jogador seguinte.

## Final de jogo

Para avaliarmos se o jogo chegou ao fim recorremos ao seguinte predicado game_over/2.
Este predicado recebe como 1º parâmetro o estado atual do jogo e como 2º e valor a retornar o vencedor, caso o jogo ainda não tenha chegado a um fim o predicado falha.  

Se o jogo chegou a um fim significa que atingimos uma das 6 seguintes possibilidades:

- todas as peças X foram eliminadas nesse caso este predicado sussede:

![game_over_x_elim_pred](imagens/game_over_x_elim_pred.png)

- todas as peças O foram eliminadas nesse caso este predicado sussede:

![game_over_o_elim_pred](imagens/game_over_o_elim_pred.png)

- todas as peças Z foram eliminadas nesse caso este predicado sussede:

![game_over_z_elim_pred](imagens/game_over_z_elim_pred.png)

- todas as peças X restantes em tabuleiro estão a tocar a borda do seu tipo:

![game_over_x_bord_pred](imagens/game_over_x_bord_pred.png)

- todas as peças O restantes em tabuleiro estão a tocar a borda do seu tipo:

![game_over_o_bord_pred](imagens/game_over_o_bord_pred.png)

- todas as peças Z restantes em tabuleiro estão a tocar a borda do seu tipo:

![game_over_z_bord_pred](imagens/game_over_z_bord_pred.png)

Como se pode ver todos estes predicados têm em comum os dois últimos predicados:

- calcElemPontuation/7: este predicado recebe como 1º parâmetro o tabuleiro atual, 2º, 3º e 4º o número de peças de cada tipo eliminadas e 5º, 6º e 7º e valores a retornar a pontução de cada peça tendo em conta os parâmetros anteriores. No fundo o que este predicado faz é calcular a pontuação de cada tipo de peças;

- calcWinner/4: este predicado recebe como 1º, 2º e 3º parâmetros as pontuações de cada peça e como 4º e valor a retornar o vencedor ou em caso de empate este parâmtro fica em branco. No fundo o que este predicado faz é calcular o vencedor tendo em conta a pontuação de cada tipo de peças.

## Avaliação do tabuleiro

## Jogada do computador

# Conclusões

# Bibliografia

Manual do Sicstus: https://sicstus.sics.se/sicstus/docs/latest4/pdf/sicstus.pdf

Página do Jogo: https://nestorgames.com/rulebooks/GREENSKULL_EN.pdf

---

