# GREEN SKULL

**Identificação do Jogo:** Green Skull  
**Identificação do Grupo:**  
- Diogo Santos (up201806878)  
- Tomás Gonçalves(up201806763)

---

Green Skull

Green Skull é um jogo de tabuleiro disputado por dois jogadores. O material necessário para jogar é: um tabuleiro, peças redondas (8 verdes, 10 roxas e 10 brancas) e uma peça não redonda (geralmente em formato de crânio).
O tabuleiro é de formato triangular apresentando bordas de cores correspondentes aos três tipos de peças.

Os três tipos de peças representam diferentes criaturas mitológicas (embora a representação seja apenas abstrata). As peças verdes são chamadas de Zombies, as brancas de Orcs e as roxas de Goblins.
Ao iniciar o jogo, um jogador toma posse dos Goblins enquanto que o adversário controla os Orcs. O controlo das peças Zombie vai alternando entre os dois jogadores à medida que vão jogando (embora seja primeiro atribuído ao jogador que possui os goblins).

Ambos os jogadores podem efetuar um de dois movimentos possíveis:
-O primeiro é deslocar uma das suas peças para uma casa adjacente vazia.
-Pode também efetuar um ou mais saltos em linha reta sobre outra peça (incluindo peças do próprio jogador) caindo numa casa vazia. Estas peças pelas quais a peça vai passando por cima vão sendo removidas do tabuleiro. Se o jogador que possui o crânio optar por este segundo movimento, deve ceder o crânio ao seu adversário tendo agora ele posse dos Zombies.

O jogador que possui o crânio pode ainda mover uma das peças zombies após cada jogada com as suas respetivas peças.

O jogo termina quando todas as peças de um tipo forem comidas ou estiverem em contacto com a borda da mesma cor.

Vence a espécie que obtiver mais pontos de acordo com a seguinte contagem:

cada espécie recebe 2 pontos por cada peça que toque a borda da sua cor
cada espécie recebe 1 ponto por cada peça capturada que não seja da sua cor


Página do Jogo: (https://nestorgames.com/rulebooks/GREENSKULL_EN.pdf)

---

#Estado inicial do jogo:
initial([
       [' '],
       [' ', ' '],
       ['Z', ' ', 'Z'],
       ['Z', ' ', ' ', 'Z'],
       [' ', ' ', 'Z', ' ', ' '],
       [' ', ' ', 'Z', 'Z', ' ', ' '],
       ['O', ' ', ' ', 'Z', ' ', ' ', 'X'],
       ['O', 'O', ' ', ' ', ' ', ' ', 'X', 'X'],
       ['O', 'O', 'O', ' ', ' ', ' ', 'X', 'X', 'X'],
       ['O', 'O', 'O', 'O', ' ', ' ', 'X', 'X', 'X', 'X']]).

#Estados intermédios do jogo:
intermediate1([
    ['O'],
    [' ', 'X'],
    ['Z', 'X', 'O'],
    ['O', 'Z', ' ', ' '],
    [' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', 'O', ' ', ' ', ' '],
    [' ', 'X', ' ', ' ', ' ', ' ', ' ', ' '],
    [' ', ' ', ' ', ' ', ' ', ' ', 'O', ' ', ' '],
    [' ', 'X', ' ', ' ', 'Z', ' ', ' ', ' ', ' ', ' ']]).

intermediate2([
    ['O'],
    [' ', 'X'],
    ['Z', 'X', 'O'],
    ['O', 'Z', 'X', ' '],
    [' ', ' ', 'Z', 'Z', ' '],
    [' ', ' ', ' ', ' ', 'O', ' '],
    [' ', 'X', ' ', 'O', ' ', ' ', ' '],
    [' ', 'X', 'O', ' ', 'Z', ' ', ' ', ' '],
    ['X', ' ', 'Z', ' ', ' ', ' ', 'O', 'O', 'O'],
    [' ', 'X', ' ', ' ', 'Z', ' ', ' ', ' ', ' ', ' ']]).

intermediate3([
    [' '],
    ['Z', ''],
    [' ', ' ', 'O'],
    [' ', 'Z', 'X', ' '],
    [' ', ' ', 'Z', 'Z', ' '],
    [' ', ' ', ' ', ' ', 'O', ' '],
    [' ', '', ' ', 'O', ' ', ' ', 'X'],
    [' ', '', 'X', ' ', 'Z', ' ', ' ', ' '],
    ['X', 'O', '', ' ', ' ', ' ', 'O', 'O', 'O'],
    ['Z', 'X', ' ', ' ', ' ', ' ', 'O', ' ', ' ', 'X']]).

#Estado final do jogo:
  final([
      ['O'],
      [' ', 'X'],
      [' ', 'X', 'O'],
      ['O', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', 'O', ' ', ' ', ' '],
      [' ', 'X', ' ', ' ', ' ', ' ', ' ', ' '],
      [' ', ' ', ' ', ' ', ' ', ' ', 'O', ' ', ' '],
      ['Z', 'X', ' ', ' ', 'Z', 'Z', ' ', ' ', ' ', ' ']]).
