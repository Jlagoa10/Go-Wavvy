# Go Wavvy — protótipo publicado

Site: https://go-wavvy.vercel.app/
Status Vercel: READY, ambiente production.
Equipe: jlagoaa10-6546s-projects

Interface com a logo do usuário, catálogo de três jogos, busca, filtros, favoritos locais, ondas animadas, gradientes, brilho e cartões com hover. Referências visuais: 21st.dev (Wavy, cards e Shimmer Button), adaptadas em código próprio.

Atualização mobile: ícones SVG da biblioteca Lucide, favoritos centralizados com estado acessível, controles do player em duas linhas no celular e cartões do Bagunça com espaçamento interno. Tom Exato inclui 16 imagens de personagens, exibidas em preto e branco no palpite e coloridas no resultado. Fontes e licença dos ícones em ATTRIBUTION.md e assets/.

## Rodar com os colegas

Clone o repositório, abra a pasta e execute `python -m http.server 4173 --bind 127.0.0.1`. Acesse http://127.0.0.1:4173. É um site estático em HTML, CSS e JavaScript, sem etapa de build. Para jogar juntos à distância, use o site publicado e compartilhe o código de sala.

Estrutura: index.html/app.js para o catálogo; components.css/icons.js para os componentes; games/ para os três jogos; assets/references/ para as imagens. Não envie tokens, arquivos .env ou a pasta .vercel para o GitHub. Os config.js dos jogos contêm apenas configuração pública do cliente Supabase.

Os arquivos públicos de Na Mosca, Bagunça e Tom Exato foram incorporados em games/, com estilo compartilhado, cores próprias e tela de entrada redesenhada. Lógica e conexão Supabase pública original preservadas. Não há chaves privilegiadas no frontend. Tela cheia e abertura em nova aba disponíveis.

Verificação: home e três páginas com HTTP 200; criação de salas nos três jogos; uma rodada solo de Tom Exato com envio de cor e resultado; layout desktop e celular sem rolagem horizontal na página inicial. Partidas completas com múltiplos dispositivos não foram testadas.

Verificação das correções: favoritos persistem após recarregar e filtram o catálogo; ícones SVG presentes nos três cartões; Bagunça com 17 px de padding em tela de 390 px; 16 imagens verificadas sem falha de carregamento; rodada de imagem do Mario testada com atualização da amostra, envio e resultado (96 pontos).

Pendente: criar o projeto Supabase Go Wavvy separado na organização KenaiQuest e migrar dados/schema dos jogos. A integração de criação está bloqueada pela indisponibilidade dos métodos de custo/confirmacao. O SQL de catálogo é apenas preparatório e ainda não foi aplicado. Favoritos continuam no navegador.

Executar localmente: python -m http.server 4173 --bind 127.0.0.1
Publicar: Vercel CLI, projeto go-wavvy, equipe jlagoaa10-6546s-projects, ambiente production. README e database.sql são excluídos da publicação por .vercelignore.
