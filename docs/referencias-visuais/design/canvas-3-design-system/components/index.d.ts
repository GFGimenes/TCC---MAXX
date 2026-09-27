/** MAXX: renderizadores em HTML (sem React). */
declare namespace MAXX {
  type Tela = 'login' | 'feed' | 'perfil' | 'mural' | 'trofeus' | 'medalhas' | 'rankings';
  type Parte = 'paleta' | 'tipografia' | 'tiers' | 'componentes';
  interface Premio { nome: string; tipo: 'trofeu' | 'medalha'; tier: 'bronze' | 'prata' | 'ouro' | 'diamante'; pts: number; rar: 'comum' | 'raro' | 'epico' | 'lendario'; por?: string; foto?: boolean }
  /** SVG do medalhão de um prêmio: metal do tier, anel da raridade. */
  function selo(premio: Premio, tamanho: number): string;
  /** Selo compacto (pílula metálica) usado no cabeçalho do post. */
  function tag(premio: Premio, semPontos?: boolean): string;
  /** Uma tela 390 x 844. */
  function tela(t: Tela, tema?: 'light' | 'dark'): string;
  /** A tela em claro e escuro lado a lado. */
  function par(t: Tela): string;
  /** Um cartão da prancheta. */
  function parte(p: Parte): string;
  function mount(el: HTMLElement, html: string): void;
}
