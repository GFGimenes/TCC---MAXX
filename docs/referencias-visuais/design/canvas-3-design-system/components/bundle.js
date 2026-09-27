(function () {
  var BLOB = {
    logoOuro: '../assets/Logos/maxx-ouro.png',
    logoBranco: '../assets/Logos/maxx-branco.png',
    unimax: '../assets/Logos/unimax.png',
    campus: '../assets/Fotos/campus.jpg'
  };

  var DIRS = {
    a: { id: 'a', nome: 'Marinho & Ouro', rotulo: 'MAXX',
      intencao: 'Institucional e cerimonial: a UniMax entrega o prêmio. Marinho dá confiança, o ouro aparece só onde há conquista, e os selos são medalhões metálicos como os da colação.',
      tipo: [['Archivo ExtraBold Itálico', 'Display e números: ecoa a inclinação do logo'], ['Figtree', 'Texto de interface, legível em 12 a 15px']] }
  };

  var TIERS = {
    bronze: { nome: 'Bronze', faixa: '1 a 30 pts', letra: 'B' },
    prata: { nome: 'Prata', faixa: '31 a 70 pts', letra: 'P' },
    ouro: { nome: 'Ouro', faixa: '71 a 100 pts', letra: 'O' },
    diamante: { nome: 'Diamante', faixa: '101 a 150 pts', letra: 'D' }
  };
  var RAR = { comum: { nome: 'Comum', n: 1 }, raro: { nome: 'Raro', n: 2 }, epico: { nome: 'Épico', n: 3 }, lendario: { nome: 'Lendário', n: 4 } };

  var P = {
    ana: { nome: 'Ana Souza', user: 'ana.souza', ra: '2023001', curso: 'ADS', sem: '3º semestre', pts: 15020, pos: 29, cor: '#f2c9a0', ini: 'AS' },
    joao: { nome: 'João Lima', user: 'joao.lima', ra: '2022110', curso: 'Engenharia de Produção', curto: 'Eng. de Produção', sem: '5º semestre', pts: 9870, pos: 112, cor: '#b9d3e8', ini: 'JL' },
    maria: { nome: 'Maria Costa', user: 'maria.costa', ra: '2023045', curso: 'Psicologia', sem: '2º semestre', pts: 21400, pos: 4, cor: '#d7c6e8', ini: 'MC' },
    pedro: { nome: 'Pedro Alves', user: 'pedro.alves', ra: '2021088', curso: 'ADS', sem: '7º semestre', pts: 18300, pos: 15, cor: '#c9dec0', ini: 'PA', ex: true },
    carla: { nome: 'Prof. Carla Mendes', user: 'carla.mendes', curso: 'ADS', cor: '#ebc3c3', ini: 'CM' },
    ricardo: { nome: 'Prof. Ricardo Nunes', user: 'ricardo.nunes', curso: 'Engenharia', cor: '#d3d3c1', ini: 'RN' }
  };
  var A = {
    techday: { nome: 'Techday 2026', tipo: 'trofeu', tier: 'ouro', pts: 80, rar: 'raro' },
    assiduidade: { nome: 'Assiduidade semestral', tipo: 'trofeu', tier: 'prata', pts: 50, rar: 'comum' },
    top2: { nome: 'Top 2% Integrativa', tipo: 'trofeu', tier: 'ouro', pts: 95, rar: 'raro' },
    seminario: { nome: 'Participação no seminário', tipo: 'medalha', tier: 'prata', pts: 40, rar: 'comum', por: 'Prof. Carla Mendes' },
    tcc: { nome: 'Apresentação de TCC', tipo: 'medalha', tier: 'diamante', pts: 120, rar: 'epico' },
    dez: { nome: '10 medalhas', tipo: 'trofeu', tier: 'bronze', pts: 25, rar: 'comum' },
    passaro: { nome: 'Pássaro Raro no Campus', tipo: 'trofeu', tier: 'diamante', pts: 150, rar: 'lendario', foto: true }
  };

  function fmt(n) { return String(n).replace(/\B(?=(\d{3})+(?!\d))/g, '.'); }
  var uid = 0;

  var ICON = {
    home: '<path d="M3 10.2 12 3l9 7.2V20a1 1 0 0 1-1 1h-5v-6.5H9V21H4a1 1 0 0 1-1-1z"/>',
    search: '<circle cx="11" cy="11" r="7"/><path d="m20 20-3.9-3.9"/>',
    news: '<rect x="3" y="4" width="18" height="16" rx="2.5"/><rect x="6.5" y="7.5" width="5" height="5" rx="1"/><path d="M14.5 8h3M14.5 11.5h3M6.5 16h11"/>',
    trophy: '<path d="M7 4h10v5a5 5 0 0 1-10 0z"/><path d="M7 5.5H4.5v1.2A3.8 3.8 0 0 0 8 10.6M17 5.5h2.5v1.2a3.8 3.8 0 0 1-3.5 3.9"/><path d="M12 14v3.5M8 21h8M9.5 17.5h5V21h-5z"/>',
    medal: '<path d="M8 2.5h8l-2.6 7M8 2.5l2.6 7"/><circle cx="12" cy="15.5" r="5.5"/><path d="m12 13 .8 1.6 1.8.3-1.3 1.2.3 1.8-1.6-.8-1.6.8.3-1.8-1.3-1.2 1.8-.3z"/>',
    heart: '<path d="M12 20.5s-7.5-4.6-9.2-9.4C1.6 7.6 3.9 4.5 7.2 4.5c2 0 3.6 1.1 4.8 2.8 1.2-1.7 2.8-2.8 4.8-2.8 3.3 0 5.6 3.1 4.4 6.6-1.7 4.8-9.2 9.4-9.2 9.4z"/>',
    comment: '<path d="M20.5 11.6a8.4 8.4 0 0 1-12.3 7.4L3.5 20.5l1.5-4.6A8.4 8.4 0 1 1 20.5 11.6z"/>',
    send: '<path d="M21.5 3 10 14.5M21.5 3l-7 18.5-4.5-7-7-4.5z"/>',
    bookmark: '<path d="M6 3.5h12v17.5l-6-4.8-6 4.8z"/>',
    bell: '<path d="M6 16.5V11a6 6 0 1 1 12 0v5.5l1.5 2h-15z"/><path d="M10 21h4"/>',
    grid: '<rect x="3.5" y="3.5" width="17" height="17" rx="2"/><path d="M9.2 3.5v17M14.8 3.5v17M3.5 9.2h17M3.5 14.8h17"/>',
    plus: '<rect x="3.5" y="3.5" width="17" height="17" rx="4.5"/><path d="M12 8v8M8 12h8"/>',
    menu: '<path d="M4 6.5h16M4 12h16M4 17.5h16"/>',
    down: '<path d="m7 10 5 5 5-5"/>',
    right: '<path d="m10 6 6 6-6 6"/>',
    more: '<circle cx="5" cy="12" r="1.2"/><circle cx="12" cy="12" r="1.2"/><circle cx="19" cy="12" r="1.2"/>',
    building: '<path d="M4 21V6l8-3 8 3v15M2.5 21h19M9.5 21v-4h5v4M8 9.5h.01M12 9.5h.01M16 9.5h.01M8 13h.01M12 13h.01M16 13h.01"/>',
    book: '<path d="M5 4.5h11a3 3 0 0 1 3 3V20H8a3 3 0 0 1-3-3z"/><path d="M5 17a3 3 0 0 1 3-3h11"/>',
    user: '<circle cx="12" cy="8" r="4"/><path d="M4.5 20.5a7.5 7.5 0 0 1 15 0"/>',
    check: '<path d="m2.5 12.5 4 4 8-9M11 16.5l1 1 9-10"/>',
    addp: '<circle cx="10" cy="8" r="4"/><path d="M3 20.5a7 7 0 0 1 12.5-4.3M19 14v6M16 17h6"/>',
    lock: '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8 10.5V8a4 4 0 0 1 8 0v2.5"/>',
    rank: '<path d="M4 20v-7h4.5v7M9.75 20V7h4.5v13M15.5 20v-9.5H20V20M3 20.5h18"/>',
    back: '<path d="m15 5-7 7 7 7"/>',
    eye: '<path d="M2.5 12S6 5.5 12 5.5 21.5 12 21.5 12 18 18.5 12 18.5 2.5 12 2.5 12z"/><circle cx="12" cy="12" r="3"/>',
    camera: '<path d="M3 8.5A2.5 2.5 0 0 1 5.5 6h2l1.5-2h6l1.5 2h2A2.5 2.5 0 0 1 21 8.5v9a2.5 2.5 0 0 1-2.5 2.5h-13A2.5 2.5 0 0 1 3 17.5z"/><circle cx="12" cy="13" r="3.5"/>'
  };
  function ic(n, cls) { return '<svg class="ic ' + (cls || '') + '" viewBox="0 0 24 24" aria-hidden="true">' + ICON[n] + '</svg>'; }

  function ava(p, size, fs) { return '<div class="mx-ava" style="width:' + size + 'px;height:' + size + 'px;font-size:' + (fs || Math.round(size * 0.34)) + 'px;background:' + p.cor + '">' + p.ini + '</div>'; }

  /* glifo do prêmio dentro do selo, em coordenadas 0..24 */
  function glyph(tipo, color, sw) {
    return '<g fill="none" stroke="' + color + '" stroke-width="' + (sw || 1.9) + '" stroke-linecap="round" stroke-linejoin="round">' + ICON[tipo === 'medalha' ? 'medal' : 'trophy'] + '</g>';
  }
  function tv(t, k) { return 'var(--tier-' + t + (k ? '-' + k : '') + ')'; }

  /* ----- selos: um desenho por direção ----- */
  function seloA(tier, rar, tipo, s) {
    var id = 'ga' + (++uid), n = RAR[rar].n, orn = 'var(--primary)', o = '';
    if (n >= 2) o += '<circle cx="50" cy="50" r="45.5" fill="none" stroke="' + orn + '" stroke-width="' + (n >= 3 ? 2 : 3) + '"/>';
    if (n >= 3) o += '<circle cx="50" cy="50" r="49" fill="none" stroke="' + orn + '" stroke-width="1.6"/>';
    if (n >= 4) { for (var i = 0; i < 24; i++) { o += '<rect x="49.2" y="0.5" width="1.6" height="6" fill="' + orn + '" transform="rotate(' + (i * 15) + ' 50 50)"/>'; } }
    var r = n >= 4 ? 36 : n >= 2 ? 38.5 : 42;
    return '<svg width="' + s + '" height="' + s + '" viewBox="0 0 100 100" aria-label="' + TIERS[tier].nome + ', ' + RAR[rar].nome + '"><defs><linearGradient id="' + id + '" x1="0" y1="0" x2="1" y2="1">' +
      '<stop offset="0" style="stop-color:' + tv(tier, 'hi') + '"/><stop offset=".45" style="stop-color:' + tv(tier) + '"/><stop offset="1" style="stop-color:' + tv(tier, 'lo') + '"/></linearGradient></defs>' + o +
      '<circle cx="50" cy="50" r="' + r + '" fill="url(#' + id + ')"/><circle cx="50" cy="50" r="' + (r - 6) + '" fill="none" style="stroke:' + tv(tier, 'hi') + '" stroke-width="1.5" opacity=".9"/>' +
      '<g transform="translate(' + (50 - r * 0.62) + ' ' + (50 - r * 0.62) + ') scale(' + (r * 1.24 / 24) + ')">' + glyph(tipo, tv(tier, 'lo'), 1.8) + '</g></svg>';
  }
  function selo(d, aw, s, opt) {
    opt = opt || {};
    return seloA(aw.tier, aw.rar, aw.tipo, s);
  }

  /* selo compacto do post */
  function tag(d, aw, noPts) {
    return '<span class="mx-tag t-' + aw.tier + '">' + selo(d, aw, 20, { noPips: 1 }) + aw.nome + '</span>';
  }
  function rarLabel(d, aw) {
    return '<span style="color:' + tv(aw.tier, 'text') + ';font-weight:700">' + TIERS[aw.tier].nome + '</span> · ' + RAR[aw.rar].nome;
  }

  /* ----- partes das telas ----- */
  function status() {
    return '<div class="mx-status"><span>9:41</span><span class="sb">' +
      '<svg width="18" height="11" viewBox="0 0 18 11"><rect x="0" y="7" width="3" height="4" rx="1" fill="currentColor"/><rect x="5" y="5" width="3" height="6" rx="1" fill="currentColor"/><rect x="10" y="2.5" width="3" height="8.5" rx="1" fill="currentColor"/><rect x="15" y="0" width="3" height="11" rx="1" fill="currentColor"/></svg>' +
      '<svg width="16" height="11" viewBox="0 0 16 11"><path d="M8 10.5 5.6 8a3.4 3.4 0 0 1 4.8 0zM3.4 5.8a6.5 6.5 0 0 1 9.2 0l-1.4 1.4a4.5 4.5 0 0 0-6.4 0zM1 3.4a9.9 9.9 0 0 1 14 0l-1.4 1.4a7.9 7.9 0 0 0-11.2 0z" fill="currentColor"/></svg>' +
      '<svg width="26" height="12" viewBox="0 0 26 12"><rect x=".5" y=".5" width="22" height="11" rx="3.2" fill="none" stroke="currentColor" opacity=".4"/><rect x="2" y="2" width="19" height="8" rx="2" fill="currentColor"/><rect x="23.5" y="4" width="1.8" height="4" rx=".9" fill="currentColor" opacity=".45"/></svg></span></div>';
  }
  function nav(active) {
    var it = function (k, n) { return '<div class="it' + (k === 'news' ? ' mid' : '') + '">' + ic(n, active === k ? 'on' : '') + '</div>'; };
    return '<div class="mx-nav">' + it('home', 'home') + it('search', 'search') + it('news', 'news') + it('trophy', 'trophy') +
      '<div class="it"><div class="mx-ava nav' + (active === 'perfil' ? ' on' : '') + '" style="background:' + P.ana.cor + '">AS</div></div></div><div class="mx-home"></div>';
  }
  function phone(d, body, active, theme) {
    return '<div class="mx" data-dir="' + d + '"' + (theme ? ' data-theme="' + theme + '"' : '') + '><div class="mx-phone">' + status() + '<div class="mx-body">' + body + '</div>' + nav(active) + '</div></div>';
  }
  function logo(theme) { return '<img class="logo" alt="MAXX" src="' + BLOB.logoOuro + '">'; }

  function post(d, p, aw, opt) {
    opt = opt || {};
    var award = '';
    if (opt.banner) award = '<div class="award">' + selo(d, aw, 34, { noPips: 1 }) + '<div style="flex:1"><b>' + aw.nome + '</b>' + rarLabel(d, aw) + '</div><div class="num" style="font-size:15px;text-align:right;line-height:18px">+' + aw.pts + '<small style="display:block;font:500 11px/14px var(--fb);opacity:.8">' + (aw.foto ? 'foto validada' : 'pontos') + '</small></div></div>';
    return '<div class="mx-post"><div class="ph">' + ava(p, 34) + '<div class="who"><b>' + p.nome + '</b><span>' + (p.curto || p.curso) + ' · ' + p.sem + '</span></div>' + tag(d, aw, opt.banner || opt.short) + '</div>' +
      '<div class="img" style="background-image:url(' + BLOB.campus + ');' + (opt.pos ? 'background-position:' + opt.pos + ';background-size:' + (opt.size || 'cover') : '') + (opt.h ? ';height:' + opt.h + 'px' : '') + '"></div>' +
      (opt.short ? '' : '<div class="acts"><span class="heart">' + ic('heart') + '</span>' + ic('comment') + ic('send') + '<span class="sp"></span>' + ic('bookmark') + '</div>' + award +
      '<div class="txt"><p><b>' + opt.likes + ' curtidas</b></p><p><b>' + p.user + '</b> ' + opt.cap + '</p><p class="muted">Ver todos os ' + opt.com + ' comentários</p>' + (opt.reply ? '<p><b>' + opt.reply[0] + '</b> ' + opt.reply[1] + '</p>' : '') + '<div class="when">' + opt.when + '</div></div>') + '</div>';
  }

  function feed(d, theme) {
    var b = '<div class="mx-hd">' + logo(theme) + '<div class="acts"><span class="bell">' + ic('bell') + '<i></i></span></div></div>' +
      post(d, P.ana, A.passaro, { likes: 128, com: 12, cap: 'Finalmente! Arara-canindé em cima do bloco B às 7h40. Foto enviada e validada pela coordenação.', when: 'Há 2 horas', banner: true }) +
      post(d, P.joao, A.techday, { short: true, pos: '100% 60%', size: '180%' });
    return phone(d, b, 'home', theme);
  }

  function profile(d, theme) {
    var a = P.ana, hlAw = [A.passaro, A.top2, A.techday, A.seminario, A.assiduidade];
    var hl = hlAw.map(function (w) { return '<div class="h"><div class="ring">' + selo(d, w, 46, { noPips: 1 }) + '</div><span>' + ({ 'Pássaro Raro no Campus': 'Pássaro', 'Top 2% Integrativa': 'Top 2%', 'Techday 2026': 'Techday', 'Participação no seminário': 'Seminário', 'Assiduidade semestral': 'Assiduidade' }[w.nome]) + '</span></div>'; }).join('');
    var tiles = [
      '<div class="g" style="background-image:url(' + BLOB.campus + ')"></div>',
      '<div class="g" style="background:linear-gradient(160deg,var(--tier-diamante-hi),var(--tier-diamante))">' + selo(d, A.passaro, 70, { noPips: 1 }) + '</div>',
      '<div class="g" style="background-image:url(' + BLOB.campus + ');background-size:300%;background-position:95% 80%"></div>',
      '<div class="g" style="background:linear-gradient(160deg,var(--tier-ouro-hi),var(--tier-ouro))">' + selo(d, A.top2, 70, { noPips: 1 }) + '</div>',
      '<div class="g" style="background-image:url(' + BLOB.campus + ');background-size:260%;background-position:30% 20%"></div>',
      '<div class="g" style="background:linear-gradient(160deg,var(--tier-prata-hi),var(--tier-prata))">' + selo(d, A.seminario, 70, { noPips: 1 }) + '</div>'
    ].join('');
    var b = '<div class="mx-hd"><div class="user">' + a.user + ic('down', 'sm') + '</div><div class="acts">' + ic('plus') + ic('menu') + '</div></div>' +
      '<div class="mx-pf"><div class="top">' + '<div class="mx-ava ava" style="background:' + a.cor + '">AS</div>' +
      '<div class="stats"><div class="rk"><span class="num">' + fmt(a.pts) + '</span><span>pontos</span></div><div class="rk"><span class="num">#' + a.pos + '</span><span>geral</span></div><div><span class="num">' + fmt(1234) + '</span><span>seguidores</span></div><div><span class="num">231</span><span>seguindo</span></div></div></div>' +
      '<div class="nm">' + a.nome + '</div><div class="meta">ADS · 3º semestre · UniMax</div><div class="bio">Dev em formação. Colecionando conquistas pelo campus.</div>' +
      '<div class="last">' + selo(d, A.passaro, 18, { noPips: 1 }) + '<span>Último troféu: <b>Pássaro Raro no Campus</b></span></div>' +
      '<div class="fol"><span class="stack">' + ava(P.joao, 20) + ava(P.maria, 20) + '</span><span>Seguida por <b>joao.lima</b>, <b>maria.costa</b> e outras 48 pessoas</span></div>' +
      '<div class="btns"><span class="mx-btn sec">Editar perfil</span><span class="mx-btn sec">Compartilhar perfil</span><span class="mx-btn sec ico">' + ic('addp', 'sm') + '</span></div>' +
      '<div class="hl">' + hl + '</div></div>' +
      '<div class="mx-tabs"><div class="on">' + ic('grid', 'sm') + '</div><div>' + ic('trophy', 'sm') + '</div><div>' + ic('medal', 'sm') + '</div></div>' +
      '<div class="mx-grid">' + tiles + '</div>';
    return phone(d, b, 'perfil', theme);
  }

  function mural(d, theme) {
    var b = '<div class="mx-hd"><div class="ttl disp">Mural</div><div class="acts"><span class="bell">' + ic('bell') + '<i></i></span></div></div>' +
      '<div class="mx-mu"><div class="chips"><span class="mx-chip on">Todos</span><span class="mx-chip">Faculdade <span class="n">1</span></span><span class="mx-chip">Curso</span><span class="mx-chip">Professores</span></div>' +
      '<div class="row"><span>3 avisos · 1 não lido</span><span class="mx-btn txt">' + ic('check', 'xs') + ' Marcar todos como lidos</span></div>' +
      '<div class="mx-card mx-av open"><div class="src"><span class="srcic">' + ic('building', 'xs') + '</span><span>Faculdade · UniMax · hoje, 09:12</span><span class="sp"></span><span class="new"><i class="dot"></i>Não lido</span></div>' +
      '<h4>Matrícula do 2º semestre até 30/07</h4><p>A rematrícula do 2º semestre de 2026 está aberta no Portal do Aluno. Quem tiver pendência financeira ou documental deve procurar a secretaria antes do prazo para não perder a vaga nas disciplinas.</p>' +
      '<div class="more"><span style="color:var(--ink2);font-size:12px">Secretaria acadêmica</span><a>Ler aviso completo</a></div></div>' +
      '<div class="mx-card mx-av shut"><span class="srcic">' + ic('book', 'xs') + '</span><span class="t">Techday: inscrições abertas</span>' + ic('right', 'sm') + '</div>' +
      '<div class="mx-card mx-av shut"><span class="srcic">' + ic('user', 'xs') + '</span><span class="t">Prova integrativa remarcada para 14/08</span>' + ic('right', 'sm') + '</div>' +
      '</div>';
    return phone(d, b, 'news', theme);
  }

  /* ----- itens de lista ----- */
  function rankRow(d, p, me) {
    var pos = '#' + p.pos;
    return '<div class="mx-li' + (me ? ' me' : '') + '"><span class="pos num">' + pos + '</span>' + ava(p, 40).replace('mx-ava"', 'mx-ava ava"') +
      '<div class="who"><b>' + p.nome + (p.ex ? '<span class="alum">ex-aluno</span>' : '') + '</b><span>' + (p.curto || p.curso) + ' · ' + p.sem + '</span></div><div class="pts num">' + fmt(p.pts) + '<small>pontos</small></div></div>';
  }
  function trail(d) {
    var st = [['bronze', 5, '1º sem.'], ['prata', 35, '2º sem.'], ['ouro', 75, '3º sem.']];
    var o = st.map(function (s) { return '<div class="st">' + selo(d, { tier: s[0], rar: 'comum', tipo: 'trofeu' }, 40, { noPips: 1 }) + '<b>' + TIERS[s[0]].nome + '</b>+' + s[1] + ' pts<br>' + s[2] + '</div>'; }).join('');
    o += '<div class="st next"><div class="lock">' + ic('lock', 'sm') + '</div><b>Diamante</b>próximo<br>4º sem.</div>';
    return '<div class="mx-trail"><div class="h"><b>Média 10 em uma matéria</b><span>3 de 4 · 115 pts</span></div><div class="steps">' + o + '</div></div>';
  }

  /* ----- prancheta ----- */
  function swatches(d, theme) {
    var names = [['bg', 'Fundo'], ['surface', 'Superfície'], ['line', 'Linha'], ['ink', 'Texto'], ['ink-2', 'Texto 2'], ['primary', 'Primária'], ['on-primary', 'Sobre primária'], ['accent', 'Ouro'], ['highlight', 'Destaque'], ['hero', 'Faixa de marca'], ['link', 'Link']];
    return '<div class="mx-pal" data-theme="' + theme + '"><div class="t">Tema ' + (theme === 'light' ? 'claro' : 'escuro') + '<span>tokens de cor</span></div><div class="sw">' +
      names.map(function (n) { return '<div class="s"><div class="c" style="background:var(--' + n[0] + ')"></div><div class="n">' + n[1] + '</div><div class="v" data-var="--' + n[0] + '">' + n[0] + '</div></div>'; }).join('') + '</div></div>';
  }
  function comps(d, theme) {
    var postMini = '<div class="fr">' + post(d, P.joao, A.techday, { h: 180, pos: '50% 45%', likes: 64, com: 5, cap: 'Stand da Produção no Techday, obrigado a quem passou!', when: 'Há 1 dia' }) + '<div style="height:12px"></div></div>';
    return '<div class="mx-comp" data-theme="' + theme + '">' +
      '<div class="lbl">Botões</div><div class="rw"><span class="mx-btn pri">Entrar</span><span class="mx-btn sec">Editar perfil</span><span class="mx-btn sec ico">' + ic('addp', 'sm') + '</span><span class="mx-btn txt">Esqueci minha senha</span></div>' +
      '<div class="lbl">Chips de filtro</div><div class="rw"><span class="mx-chip on">Todos</span><span class="mx-chip">Faculdade <span class="n">1</span></span><span class="mx-chip">Curso</span><span class="mx-chip">Professores</span></div>' +
      '<div class="lbl">Selo de tier (compacto, no post)</div><div class="rw">' + tag(d, A.dez) + tag(d, A.assiduidade) + tag(d, A.techday) + tag(d, A.passaro) + '</div>' +
      '<div class="lbl">Card de post</div>' + postMini +
      '<div class="lbl">Item de lista: ranking</div><div class="fr">' + rankRow(d, P.maria) + rankRow(d, P.pedro) + rankRow(d, P.ana, true) + '</div>' +
      '<div class="lbl">Item de lista: trilha de conquista</div><div class="fr">' + trail(d) + '</div>' +
      '</div>';
  }
  function typeSpec(d) {
    var rows = {
      a: [['Display', 'Archivo 800 itálico · 28/32', '<span class="disp" style="font-size:28px">Pássaro Raro no Campus</span>'], ['Numeral', 'Archivo 800 itálico · 18/22', '<span class="num" style="font-size:22px">15.020 pts · #29</span>'], ['Título', 'Figtree 700 · 15/20', '<b style="font-size:15px">Ana Souza</b>'], ['Texto', 'Figtree 400 · 14/19', '<span style="font-size:14px">Arara-canindé em cima do bloco B às 7h40.</span>'], ['Legenda', 'Figtree 500 · 12/16', '<span style="font-size:12px;font-weight:500;color:var(--ink2)">ADS · 3º semestre · há 2 horas</span>']]
    }[d];
    return '<div class="mx-type">' + rows.map(function (r) { return '<div class="r"><div class="l"><b>' + r[0] + '</b>' + r[1] + '</div><div>' + r[2] + '</div></div>'; }).join('') + '</div>';
  }
  function tierSpec(d) {
    var t = Object.keys(TIERS).map(function (k) { return '<div class="tc">' + selo(d, { tier: k, rar: 'comum', tipo: 'trofeu' }, 64) + '<b style="color:' + tv(k, 'text') + '">' + TIERS[k].nome + '</b><span>' + TIERS[k].faixa + '</span></div>'; }).join('');
    var r = Object.keys(RAR).map(function (k) { return '<div class="tc">' + selo(d, { tier: 'ouro', rar: k, tipo: k === 'epico' ? 'medalha' : 'trofeu' }, 64) + '<b>' + RAR[k].nome + '</b><span>' + ['sem anel', 'anel simples', 'anel duplo', 'anel com raios'][RAR[k].n - 1] + '</span></div>'; }).join('');
    var note = {
      a: 'Tier é o metal (cor e gradiente); raridade é o ornamento em volta, na cor primária. Troféu leva taça, medalha leva fita. Os dois eixos nunca usam a mesma variável visual.'
    }[d];
    return '<div class="mx-tiers">' + t + '</div><div class="mx-tiers" style="margin-top:12px">' + r + '</div><p class="mx-note">' + note + '</p>';
  }
  function fillVars(root) {
    var els = root.querySelectorAll('[data-var]');
    for (var i = 0; i < els.length; i++) {
      var v = getComputedStyle(els[i]).getPropertyValue(els[i].getAttribute('data-var')).trim();
      if (v) els[i].textContent = v.toLowerCase();
    }
  }
  function mount(el, html) { el.innerHTML = html; fillVars(el); }


  /* ----- login ----- */
  function login(d, theme) {
    var hero = '<div class="lg-hero"><img src="' + BLOB.logoOuro + '" alt="MAXX"><span>A rede de conquistas da UniMax</span></div>';
    var b = '<div class="mx-login">' + hero +
      '<div class="lg-card"><div class="seg"><span class="on">Entrar</span><span>Cadastrar</span></div>' +
      '<label>RA ou e-mail institucional</label><div class="fld">2023001</div>' +
      '<label>Senha</label><div class="fld pw"><span>••••••••••</span>' + ic('eye', 'sm') + '</div>' +
      '<div class="fg"><span class="mx-btn txt">Esqueci minha senha</span></div>' +
      '<span class="mx-btn pri big">Entrar</span>' +
      '<p class="hint">Primeiro acesso? Alunos e professores vinculam a conta pelo <b>Portal UniMax</b> com o RA.</p></div>' +
      '<div class="lg-foot"><img src="' + BLOB.unimax + '" alt="UniMAX"><span>Rede UniEduk<br>UniMax e UniFaj</span></div></div>';
    return '<div class="mx" data-dir="' + d + '"' + (theme ? ' data-theme="' + theme + '"' : '') + '><div class="mx-phone">' + status() + '<div class="mx-body">' + b + '</div><div class="mx-home"></div></div></div>';
  }

  /* ----- troféus e medalhas ----- */
  function awardRow(d, aw, meta, locked) {
    return '<div class="mx-aw' + (locked ? ' locked' : '') + '"><div class="sl">' + selo(d, aw, 48, { noPips: 1 }) + '</div><div class="who"><b>' + aw.nome + '</b><span class="rl">' + rarLabel(d, aw) + '</span><span>' + meta + '</span></div>' +
      '<div class="pts num">' + (locked ? ic('lock', 'sm') : '+' + aw.pts) + '</div></div>';
  }
  function trofeus(d, theme, aba) {
    var med = aba === 'medalhas';
    var head = '<div class="mx-hd"><div class="ttl disp">Conquistas</div><div class="acts"><span class="mx-btn sec" style="height:32px">' + ic('rank', 'sm') + 'Rankings</span></div></div>' +
      '<div class="mx-tabs tx" style="margin-top:0"><div' + (med ? '' : ' class="on"') + '>' + ic('trophy', 'sm') + 'Troféus <span class="num">6</span></div><div' + (med ? ' class="on"' : '') + '>' + ic('medal', 'sm') + 'Medalhas <span class="num">1</span></div></div>' +
      '<div class="mx-sw"><span>' + (med ? '1 medalha · 40 pts' : '6 troféus · 515 pts') + '</span><span class="tg">Mostrar não obtidos <i class="sw' + (med ? ' on' : '') + '"><i></i></i></span></div>';
    var list;
    if (!med) {
      list = awardRow(d, A.passaro, 'Conquista com foto · validada pela coordenação') +
        '<div class="mx-aw tr">' + trail(d) + '</div>' +
        awardRow(d, A.top2, 'Regra automática · prova integrativa') +
        awardRow(d, A.techday, 'Instituição · Techday 2026') +
        awardRow(d, A.assiduidade, 'Regra automática · presença em 1/2026') +
        awardRow(d, A.dez, 'Acúmulo · 10 medalhas recebidas');
    } else {
      list = awardRow(d, A.seminario, 'Dada pela Prof. Carla Mendes · ADS') +
        awardRow(d, A.tcc, 'Não obtida · dada na banca de TCC', true) +
        '<p class="mx-foot">Medalhas são dadas por professores. A cada 10 medalhas você recebe o troféu <b>10 medalhas</b>.</p>';
    }
    return phone(d, head + '<div class="mx-awl">' + list + '</div>', 'trophy', theme);
  }
  function medalhas(d, theme) { return trofeus(d, theme, 'medalhas'); }

  /* ----- rankings ----- */
  function rankings(d, theme) {
    var gap = '<div class="mx-gap">···</div>';
    var b = '<div class="mx-hd"><div class="user">' + ic('back') + '<span class="disp ttl" style="margin-left:6px">Rankings</span></div><div class="acts">' + ic('search') + '</div></div>' +
      '<div class="mx-mu"><div class="chips"><span class="mx-chip on">Geral</span><span class="mx-chip">Por curso</span><span class="mx-chip">All-time geral</span><span class="mx-chip">All-time por curso</span></div>' +
      '<div class="row"><span>Semestre 2/2026 · todos os cursos</span><span>Atualizado hoje</span></div></div>' +
      '<div class="mx-rk">' + rankRow(d, P.maria) + gap + rankRow(d, P.pedro) + gap + rankRow(d, P.ana, true) + gap + rankRow(d, P.joao) + '</div>' +
      '<p class="mx-foot" style="margin:14px 16px">Ex-alunos aparecem com a pontuação final e não pontuam mais. Toque em um aluno para ver o perfil.</p>';
    return phone(d, b, 'trophy', theme);
  }

  /* ----- partes da prancheta, separadas ----- */
  function sheet(d, inner, w) { return '<div class="mx" data-dir="' + d + '" data-theme="light"><div class="mx-board" style="width:' + w + 'px">' + inner + '</div></div>'; }
  function parte(d, p) {
    var D = DIRS[d], h2 = function (t) { return '<h2 class="mx-h2">' + t + '</h2>'; };
    if (p === 'paleta') {
      var lg = 'background:var(--hero)';
      return sheet(d, '<div class="bh"><div><div class="k">MAXX · design system</div><h1 class="disp">' + D.nome + '</h1><p>' + D.intencao + '</p></div>' +
        '<div class="lg" style="' + lg + '"><img src="' + BLOB.logoOuro + '" alt="MAXX"></div></div>' +
        '<div class="bsec">' + h2('Paleta') + '<div class="two">' + swatches(d, 'light') + swatches(d, 'dark') + '</div></div>', 1440);
    }
    if (p === 'tipografia') return sheet(d, h2('Tipografia') + typeSpec(d) + '<p class="mx-note">' + D.tipo.map(function (t) { return '<b style="color:var(--ink)">' + t[0] + '</b>: ' + t[1]; }).join('<br>') + '</p>', 900);
    if (p === 'tiers') return sheet(d, h2('Tiers e raridade') + tierSpec(d), 900);
    if (p === 'componentes') return sheet(d, h2('Componentes, claro e escuro') + '<div class="two">' + comps(d, 'light') + comps(d, 'dark') + '</div>', 1440);
  }
  function par(d, t) {
    return '<div class="mx-cmp"><div class="col"><div class="cap">Claro</div>' + TELAS[t](d, 'light') + '</div>' +
      '<div class="col"><div class="cap">Escuro</div>' + TELAS[t](d, 'dark') + '</div></div>';
  }

  var TELAS = { login: login, feed: feed, perfil: profile, mural: mural, trofeus: trofeus, medalhas: medalhas, rankings: rankings };
  window.MAXX = {
    identidade: DIRS.a, tiers: TIERS, raridades: RAR, pessoas: P, premios: A, blob: BLOB,
    selo: function (aw, s) { return selo('a', aw, s); }, tag: function (aw, semPontos) { return tag('a', aw, semPontos); },
    tela: function (t, theme) { return TELAS[t]('a', theme); },
    parte: function (p) { return parte('a', p); }, par: function (t) { return par('a', t); }, mount: mount, icon: ic
  };
})();
