-- Execute no projeto Supabase novo (compartilhado pelos 4 jogos: Telestrations, Proibido, Quem sou eu, Ito).
-- Mesmo padrão dos jogos existentes: tabela "_salas" com estado em jsonb, "_jogadores" por sala,
-- e uma tabela de dados específicos da rodada por jogo. RLS pública (sem login), anon lê e escreve.
begin;

-- ===================== Telestrations (tele_) =====================
create table public.tele_salas (
  codigo text primary key,
  estado jsonb not null default '{}'::jsonb,
  atualizado_em timestamptz not null default now()
);
create table public.tele_jogadores (
  sala text not null references public.tele_salas(codigo) on delete cascade,
  id text not null,
  nome text not null,
  ativo boolean not null default true,
  entrou_em timestamptz not null default now(),
  primary key (sala, id)
);
create table public.tele_paginas (
  sala text not null references public.tele_salas(codigo) on delete cascade,
  cadeia integer not null,
  posicao integer not null,
  jogador text not null,
  tipo text not null check (tipo in ('palavra','desenho')),
  conteudo text not null,
  atualizado_em timestamptz not null default now(),
  primary key (sala, cadeia, posicao)
);

-- ===================== Proibido (proibido_) =====================
create table public.proibido_salas (
  codigo text primary key,
  estado jsonb not null default '{}'::jsonb,
  atualizado_em timestamptz not null default now()
);
create table public.proibido_jogadores (
  sala text not null references public.proibido_salas(codigo) on delete cascade,
  id text not null,
  nome text not null,
  time integer not null default 0,
  ativo boolean not null default true,
  entrou_em timestamptz not null default now(),
  primary key (sala, id)
);
create table public.proibido_rodadas (
  sala text not null references public.proibido_salas(codigo) on delete cascade,
  rodada integer not null,
  jogador text not null,
  palavra text not null,
  proibidas text[] not null default '{}',
  acertou boolean not null default false,
  pulou boolean not null default false,
  atualizado_em timestamptz not null default now(),
  primary key (sala, rodada)
);

-- ===================== Quem sou eu (qse_) =====================
create table public.qse_salas (
  codigo text primary key,
  estado jsonb not null default '{}'::jsonb,
  atualizado_em timestamptz not null default now()
);
create table public.qse_jogadores (
  sala text not null references public.qse_salas(codigo) on delete cascade,
  id text not null,
  nome text not null,
  personagem text,
  descobriu boolean not null default false,
  ativo boolean not null default true,
  entrou_em timestamptz not null default now(),
  primary key (sala, id)
);

-- ===================== Ito (ito_) =====================
create table public.ito_salas (
  codigo text primary key,
  estado jsonb not null default '{}'::jsonb,
  atualizado_em timestamptz not null default now()
);
create table public.ito_jogadores (
  sala text not null references public.ito_salas(codigo) on delete cascade,
  id text not null,
  nome text not null,
  numero integer,
  pista text,
  revelado boolean not null default false,
  ativo boolean not null default true,
  entrou_em timestamptz not null default now(),
  primary key (sala, id)
);

-- ===================== RLS: pública, sem login, igual aos jogos atuais =====================
do $$
declare t text;
begin
  for t in select unnest(array[
    'tele_salas','tele_jogadores','tele_paginas',
    'proibido_salas','proibido_jogadores','proibido_rodadas',
    'qse_salas','qse_jogadores',
    'ito_salas','ito_jogadores'
  ])
  loop
    execute format('alter table public.%I enable row level security', t);
    execute format('revoke all on public.%I from anon, authenticated', t);
    execute format('grant select, insert, update on public.%I to anon, authenticated', t);
    execute format('create policy "public read" on public.%I for select to anon, authenticated using (true)', t);
    execute format('create policy "public insert" on public.%I for insert to anon, authenticated with check (true)', t);
    execute format('create policy "public update" on public.%I for update to anon, authenticated using (true) with check (true)', t);
  end loop;
end $$;

commit;
