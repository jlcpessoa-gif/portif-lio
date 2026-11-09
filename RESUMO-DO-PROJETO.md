# Portfólio do Júlio César · resumo do projeto

Documento de memória para retomar o trabalho em qualquer conversa nova com o Claude.
Atualizado em 09/11/2026.

## Quem é
- **Júlio César Pessoa**, editor de vídeo, São Paulo (SP). 3 anos editando.
- Especialidade: Motion, Reels e YouTube. Formação: Técnico em Produção Audiovisual. Atendimento remoto.
- Contatos no site: jlc.pessoa@gmail.com · WhatsApp 11 99552-3946 · Instagram @jcesar.cp · X @juliocfx · LinkedIn Julio Cesar Pessoa.

## Onde o site está
- **Versão no claude.ai (a principal, com edição):** https://claude.ai/artifact/Sr8gua7Nviaxa2xL2FfUvy
  - Compartilhada como "qualquer pessoa com o link".
  - O conteúdo fica em `content.json`; a página em `index.html`; vídeos e imagens como arquivos do próprio site.
- **Versão independente** (para Netlify/Vercel/domínio próprio): pasta `site/` do pacote `juliocesar-portfolio-projeto.zip`.
  - Não tem os botões Editar/Animar/Feedback; o conteúdo é editado no `content.json`.
  - Ferramentas do dono pelo endereço: `?ajustes` (DialKit) e `?feedback` (Agentation).

## Páginas e estrutura
- **Início** (apresentação): nome grande com animação de letras e "ímã" por palavra, foto com REC/timecode,
  status e horário local, "Sobre mim" (texto que acende com a rolagem + ficha técnica), "O que eu faço",
  faixa de ferramentas, **Trabalhos em destaque** (os 3 primeiros projetos) e chamada "Tem um projeto em mente?".
- **Trabalhos:** lista estilo bin de edição, filtros por tipo, prévia que segue o mouse (vídeo tocando).
- **Página de cada projeto:** player próprio (play, linha do tempo arrastável, timecode, som, tela cheia),
  descrição, ficha técnica e "Próximo projeto".
- **Contato:** página separada com e-mail, WhatsApp e redes.
- Timeline fixa no rodapé mostrando as cenas/páginas, com agulha que acompanha a rolagem.
- Ao abrir/recarregar, sempre começa no Início, no topo (links de projeto abrem o projeto).

## Projetos (ordem atual)
1. **Fashion Film** — ensaio streetwear, 9:16, 29 s (destaque).
2. **Cortes de podcast** — Reels, 9:16, 1:18.
3. **Vídeo dinâmico para YouTube** — MedCof, "Choro, café & questão" (Singular Cast), 16:9, 9:19.
4. **Quadro de PodCast** — MedCof, 16:9, 11:29.
5. **Motion do QUIZ** — relatório do Quiz ENEM, motion design, 16:9, 30 s, 60 fps.
6. **Motion feito 100% com IA** — 9:16, 20 s (Gemini TTS, MusicGen, Claude + HyperFrames).
Tipos (filtros): Fashion Film, Reels, YouTube, Motion, Cortes.

## Ferramentas de edição no site (só para o dono, logado no claude.ai)
- **Editar** (Shift+E): textos, foto, ficha, serviços, projetos (vídeo, capa, ordem), contatos. Salva e publica.
- **Animar** (Shift+A): painel DialKit 2.1.0 + **Timeline "Abertura"** (clipes Status, Nome, Foto, Texto, Botões).
  Ajusta curvas, tempos, ímã do nome, parallax, faixa, prévia, corte entre páginas, match cut e deslize. Salva e publica.
- **Feedback** (Shift+F): Agentation 3.1.2. Marca elementos e escreve notas; **Send Annotations** envia direto
  para a sessão do Claude como comentário no site (a sessão é acordada, aplica e responde no comentário).
  Também dá para **Copiar** e colar no chat.

## Decisões de design
- Linguagem de sala de edição: timecode, burn-ins, nomes de clipe (A001_C001), timeline, claquete.
- Preto e branco + vermelho do REC; fontes Schibsted Grotesk e IBM Plex Mono. Tema claro alternativo.
- Transições por contexto: cortina escura (menu), match cut lista↔projeto (View Transitions), deslize entre projetos;
  invertidas ao voltar.
- Animação atual escolhida: curva ease-out forte (0.22, 1, 0.36, 1), corte 460/240/600 ms, parallax 0.07
  (acima disso aparecia faixa vazia na foto). O Júlio ajustou a abertura na Timeline (nome entra primeiro, foto e
  nome com leve "overshoot").
- Foto: recorte vertical 4:5 com o rosto centralizado; o fundo (parede listrada) foi estendido para cima para o
  cabelo não ser cortado.

## Vídeos: como foram tratados
- No claude.ai cada arquivo tem limite de **20 MB**. Os vídeos vieram do Google Drive do Júlio e foram comprimidos
  com ffmpeg (H.264 + AAC, faststart). Podcasts longos em 960×540; verticais curtos em 720×1280 ou 1080×1920.
- Vídeos já pequenos (Quiz ENEM, Motion IA) entraram sem compressão.
- Os originais em alta continuam no Drive. Fora do claude.ai (Netlify/Vercel) não há limite de 20 MB.

## Pendências sugeridas
- Textos provisórios no Início: apresentação, "Sobre mim", disponibilidade, cidade ("Brasil"), idiomas.
- Projetos 2, 3 e 4 ainda marcados como "exemplo"; cliente do "Cortes de podcast" está como "Podcast".
- Legenda de teste no "Quadro de PodCast" ("— O verão começa quando você decide.").
- Domínio próprio (ideias: juliocesarpessoa.com.br, juliocesar.art.br, jcesar.com.br) e hospedagem na Vercel/Netlify.
- Instalar o Claude Code no computador e usar o pacote `juliocesar-portfolio-projeto.zip` (tem `CLAUDE.md`).
