# Portfólio · Júlio César (editor de vídeo)

Site estático de uma página só (sem build, sem framework). Tudo roda direto do navegador.
O dono do projeto é o Júlio, editor de vídeo em São Paulo. Fale com ele em português do Brasil.

## Estrutura

```
site/
  index.html     página inteira: HTML + CSS + JS num arquivo só
  content.json   TODO o conteúdo (textos, projetos, contatos) — edite aqui primeiro
  media/         vídeos (.mp4) e imagens (.jpg), nomeados pelo id usado no content.json
  favicon.svg
  ajustes/       ferramentas do dono, carregadas só sob demanda:
    dialkit/       DialKit 2.1.0 (painel de animação + timeline) — abre com ?ajustes
    agentation/    Agentation 3.1.2 empacotado com React 18.3.1 — abre com ?feedback
scripts/
  comprimir-video.sh   comprime um vídeo para a web com ffmpeg
```

## Como o site funciona

- `index.html` busca `content.json` ao abrir e desenha tudo a partir dele (função `render()`).
  O objeto `DEFAULT` dentro do `index.html` é só reserva caso o JSON não carregue; não precisa mantê-lo em dia.
- Mídia: campos `foto`, `projetos[].capa` e `projetos[].video` guardam um **id**. O mapa `MEDIA`
  no `index.html` liga cada id ao arquivo em `media/`. Para adicionar mídia nova:
  1. coloque o arquivo em `site/media/` (ex.: `fashion2.mp4`);
  2. adicione a entrada no objeto `MEDIA` (`"fashion2": "fashion2.mp4"`);
  3. use o id (`"fashion2"`) no `content.json`.
- Navegação por hash. Páginas: Início (`#inicio`, com cenas `#sobre`, `#servicos`, `#destaques`),
  `#trabalhos`, `#contato` e cada projeto em `#projeto-<titulo-em-slug>`. Ao abrir/recarregar, o site
  sempre começa no Início, no topo — só links de projeto abrem direto o projeto.
- Transições (função `route()`), escolhidas por contexto:
  - menu → cortina escura com claquete (`curtain`), invertida ao voltar;
  - lista → projeto → "match cut" com View Transitions (`matchIn`/`matchOut`): o título voa entre a lista e a página
    e, no computador, a prévia vira o player; volta para a lista na mesma posição de rolagem;
  - projeto → projeto → deslize lateral (`slide`), invertido ao voltar.
  Navegadores sem View Transitions usam a cortina.
- Prévia dos projetos (hover na lista, só computador): duas camadas que se dissolvem ao trocar de projeto,
  capa aparece na hora e o vídeo entra quando já está tocando.
- "Ímã" do nome: cada palavra (Júlio / César) reage sozinha ao mouse, em onda horizontal.
- `projetos[0..2]` são os "Trabalhos em destaque" do Início.
- Campos com `"ph": true` são textos provisórios (aparecem mais apagados). Ao trocar o texto, remova o `ph`.
- `"exemplo": true` num projeto mostra a etiqueta "exemplo". Projetos reais devem ter `false`.
- `tipos` define os filtros da página Trabalhos; o `tipo` de cada projeto precisa estar nessa lista.
- Descrições aceitam quebras de linha (`\n`) e tópicos com "•".
- `duracao` é timecode `hh:mm:ss:qq` a 24 fps.

## Identidade visual (manter)

- Tema escuro por padrão, com tema claro alternativo (tokens CSS em `:root`).
- Fontes: Schibsted Grotesk (texto) e IBM Plex Mono (timecodes/rótulos), via Google Fonts.
- Linguagem de sala de edição: timecode, timeline fixa no rodapé, "burn-ins" nos vídeos, nomes de clipe.
- Cor só nos clipes da timeline e no ponto vermelho de REC. O resto é preto e branco.
- Sempre testar no celular (~390px): nada pode passar da largura da tela.

## Animações e painel DialKit

Os valores das animações ficam em `content.json`, no campo `animacao` (se não existir, valem os padrões de
`ANIM_DEFAULT` no `index.html`). A função `applyAnim()` aplica esses valores no carregamento, para todo visitante:
- variáveis CSS: `--ease`, `--rv-dur`, `--char-dur`, `--char-stagger`, `--name-scale`;
  cores `--rec`, `--bg`, `--fg` só no tema escuro;
- objeto `TUNE` (JS): ímã das letras, parallax da foto, faixa de ferramentas, prévia e tempos do corte.

Formato do campo:
```json
"animacao": {
  "cores": { "destaque": "#e5484d", "fundo": "#0e0e0d", "texto": "#e9e7e2" },
  "nome": { "tamanho": 1, "duracao": 1.2, "intervalo": 38 },
  "curva": { "duracao": 1.1, "ease": [0.16, 0.84, 0.24, 1] },
  "ima": { "raio": 260, "forca": 26, "suavidade": 0.12 },
  "parallax": 0.12,
  "faixa": { "velocidade": 0.6, "reacao": 0.9, "inclinacao": 0.35 },
  "previa": { "suavidade": 0.13 },
  "corte": { "entrada": 560, "pausa": 300, "saida": 640 },
  "transicao": { "match": 0.65, "deslize": 0.55 },
  "abertura": {
    "status": { "at": 0, "dur": 1.1, "ease": "cubic-bezier(...)" },
    "nome":   { "at": 0.08, "dur": 1.2, "ease": "" },
    "foto":   { "at": 0.2, "dur": 1.4, "ease": "" },
    "texto":  { "at": 0.52, "dur": 1.1, "ease": "" },
    "botoes": { "at": 0.64, "dur": 1.1, "ease": "" }
  }
}
```
`abertura` é a coreografia da primeira tela (segundos; `ease` vazio = curva geral). Vira as variáveis
`--ab-<clipe>-at/-dur/-ease` usadas nas animações de `.hero`. `transicao` vira `--vt-match` e `--vt-slide`.

Timeline: ao abrir o painel, também abre a Timeline do DialKit ("Abertura"), com um clipe por elemento.
Arrastar/esticar os clipes muda `abertura`; a agulha faz scrub das animações reais (`scrub()` pausa as
CSS animations do `.hero` e posiciona `currentTime`).

Painel: o módulo `AnimPanel` (no `index.html`) carrega o DialKit (dialkit@2.1.0, versão JavaScript puro, MIT)
de `site/ajustes/dialkit/` só quando é aberto. Nesta versão ele abre com `?ajustes` no endereço
(ex.: http://localhost:8000/?ajustes) e não tem botão de publicar: os valores ficam só no navegador.
Para gravar: o Júlio usa o botão de copiar do painel e cola aqui; converta para o formato acima e salve em
`content.json` → `animacao`. (No site hospedado no claude.ai existe um botão "Animar" que já publica sozinho.)
Para adicionar um controle: inclua o valor em `ANIM_DEFAULT`, aplique em `applyAnim`, e adicione o controle
em `toPanel`/`fromPanel` dentro de `AnimPanel`. Documentação: https://github.com/joshpuckett/dialkit

## Feedback visual (Agentation)

O módulo `Feedback` carrega `site/ajustes/agentation/agentation.js` (Agentation 3.1.2 + React 18.3.1 num
bundle IIFE; licença PolyForm Shield em `LICENSE.txt`) só quando é aberto:
- `http://localhost:8000/?feedback` → barra do Agentation; o Júlio marca elementos, escreve notas e usa Copiar;
- `http://localhost:8000/?feedback=mcp` → envia as notas para o servidor MCP local na porta 4747.
  Para receber aqui: `claude mcp add agentation -- npx -y agentation-mcp server` e use as ferramentas
  `agentation_*` (ex.: `agentation_get_all_pending`); confirme com uma anotação de teste.
O feedback copiado traz o seletor do elemento ("Location"), o que basta para achar o trecho no `index.html`.
Atalhos do site ignoram teclas digitadas em campos, inclusive dentro do shadow DOM (`isTyping`).

## Rodar localmente

```bash
cd site && python3 -m http.server 8000
```
Abra http://localhost:8000 (abrir o index.html direto pelo arquivo não carrega o content.json).

## Publicar (GitHub → Vercel)

Este repositório está ligado à Vercel (projeto "jcesar" → https://jcesar.vercel.app).
Todo push na branch principal publica sozinho em ~1 minuto; outras branches ganham um link de prévia.
`vercel.json` serve a pasta `site/` sem build. Fluxo de trabalho:
1. edite `site/content.json` (conteúdo) ou `site/index.html` (visual/animações);
2. teste localmente (`cd site && python3 -m http.server 8000`), inclusive no celular (~390px);
3. faça commit e push.

Arquivos em `site/media/` têm cache de 1 ano (`immutable`): para trocar um vídeo ou imagem, use um
NOME NOVO (novo id no `MEDIA` e no `content.json`), nunca sobrescreva um arquivo existente.
GitHub recusa arquivos acima de 100 MB: mantenha cada vídeo abaixo de ~95 MB.

O site também existe como artifact no claude.ai (https://claude.ai/artifact/Sr8gua7Nviaxa2xL2FfUvy), usado
como área de testes com os botões Editar/Animar/Feedback. A versão oficial é ESTE repositório.

### Combinado com o Júlio: tudo vai direto para a Vercel

O endereço de produção hoje é https://jcesar-ten.vercel.app (o domínio `.com` próprio será ligado depois).
Toda mudança que o Júlio faz ou pede (pelo chat, pelo Editar/Animar do claude.ai ou pelo Feedback) deve ir
para o artifact E para este repositório (branch `main`) na mesma hora, sem esperar ele pedir "leva para o GitHub":
- Mudou pelo Editar/Animar no claude.ai: a sessão é acordada ao salvar; leia o `content.json` publicado e leve
  o conteúdo (textos, projetos, contatos, `animacao`) para `site/content.json`.
- Pediu no chat ou pelo Feedback: aplique nos dois lugares (artifact e `site/`), teste e dê push na `main`.
- Mídia nova entra com NOME NOVO e abaixo de ~95 MB (veja acima). O artifact limita cada arquivo a 20 MB, então
  lá os vídeos são mais comprimidos que os de `site/media/`.
- Antes do push: teste local, inclusive ~390px. Depois: confira que a Vercel respondeu (`gh api .../status`).
- Peça confirmação só para o que for destrutivo ou não pedido: apagar projetos/arquivos, trocar vídeos já
  publicados, mexer em domínio/DNS ou conta.
- Fale com o Júlio SEMPRE aqui no chat (ele não quer respostas nos comentários do site).

## Vídeos

Aqui os vídeos estão em qualidade maior (podcasts em 1080p ou no original 720p); no claude.ai o limite é 20 MB.
Use `scripts/comprimir-video.sh entrada.mp4 saida.mp4 [altura]` (H.264 + AAC, faststart).
Os originais em alta ficam no Google Drive do Júlio.
