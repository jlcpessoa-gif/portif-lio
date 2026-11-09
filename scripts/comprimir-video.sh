#!/usr/bin/env bash
# Comprime um vídeo para a web (H.264 + AAC, começa a tocar rápido).
# Uso: ./scripts/comprimir-video.sh entrada.mov saida.mp4 [altura]
#   altura opcional: 1080, 720, 540... (mantém a proporção). Sem altura, mantém o tamanho original.
# Precisa do ffmpeg instalado (macOS: brew install ffmpeg | Windows: winget install ffmpeg).
set -euo pipefail
IN="${1:?informe o vídeo de entrada}"
OUT="${2:?informe o arquivo de saída (.mp4)}"
H="${3:-}"
VF="format=yuv420p"
if [ -n "$H" ]; then VF="scale=-2:${H},${VF}"; fi
ffmpeg -y -i "$IN" -vf "$VF" -c:v libx264 -preset slow -crf 23 -maxrate 6M -bufsize 12M \
  -c:a aac -b:a 160k -movflags +faststart "$OUT"
ls -lh "$OUT"
