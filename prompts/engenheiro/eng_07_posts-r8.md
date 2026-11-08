ID: eng_07_posts-r8
Trilha: engenheiro
Tela: passo 7 (resposta 8 do autor: revisão da etapa 7, derivadas, upload e novo post no cliente)
Data: 2026-11-07
Origem: leitura do Cowork (Anthropic) do export da sessão; o autor olhou as capturas; decisão do autor; redigida pelo Cowork, o autor revisou.

Notas de registro:
- Etapa 6 fechada em `7940ae5`, CI verde.
- Etapa 7: tela `/novo-post` (foto quadrada com escolher, trocar e remover; legenda com contador até 1.000; prêmio opcional entre as medalhas sem post; Publicar desativado sem conteúdo; professor vê aviso); `derivadas.ts` (recorte quadrado central, 1080 e 320 em JPEG, segunda tentativa comprimida); `envio.ts` (assinatura com tamanhos exatos, PUT direto, reaproveitamento do upload se o post falhar); campo `postId` em `/v1/eu/premios`; `TextField` multiline; `expo-image-picker` e `expo-image-manipulator`; 333 Jest no app (14 novos); capturas com pilha isolada e foto real no bucket (900 × 900 e 320 × 320 conferidas).
- Limites declarados: PUT de Blob no nativo só com Jest até o Maestro; HEIC na web com mensagem própria.

---
Etapa 7 aprovada. O campo postId no mesmo commit está certo. Os dois limites ficam registrados. Commita com a mensagem proposta, push, acompanha a CI e segue para a etapa 8; para para a minha revisão no fim dela, com capturas do feed e da tela de comentários ao lado da prancheta.
