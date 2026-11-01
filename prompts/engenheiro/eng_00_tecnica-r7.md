ID: eng_00_tecnica-r7
Trilha: engenheiro
Tela: abertura (resposta 7 do autor: revisão da E0.3, `docs/decisoes/` com oito ADRs e índice)
Data: 2026-11-01
Origem: leitura do Cowork (Anthropic) dos ADRs e do índice no repo, aprovada pelo autor e redigida pelo Cowork; o autor revisou.

Notas de registro:
- O agente commitou a E0.2c (famílias) e entregou oito ADRs (contexto, opções com peso, decisão, consequências com as negativas, Mermaid em seis) e o índice de todas as decisões em cinco grupos. Levantou três observações próprias (saúde do worker no passo 13; reencode no cliente remove EXIF e GPS, mitigação da foto pública; assimetria de pontos congelados e raridade viva), todas aceitas.
- Pedido do autor: sem travessões nos docs (padrão do projeto) e "revisão humana do autor" na definição de pronto. O agente substituiu 34 travessões em 11 arquivos e commitou em `13c5ccf`.

---
E0.3 aprovada, com as três observações aceitas: verificação de saúde do worker e alerta de fila parada entram no passo 13; o reencode no cliente removendo EXIF e GPS fica registrado no ADR 0003 como mitigação ligada ao ADR 0002; a assimetria do 0007 fica com a frase que você escreveu. Dois ajustes de texto antes do commit: troca os travessões por vírgula, dois pontos ou parênteses em todos os arquivos de docs/ (padrão do projeto, vale para o CLAUDE.md também), e em "Pronto" escreve "revisão humana do autor". Commita e segue para a E0.4.
