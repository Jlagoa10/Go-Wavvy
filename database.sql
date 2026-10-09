-- Execute no projeto separado Go Wavvy quando ele estiver criado.
begin;
create table public.games (
  id text primary key,
  name text not null,
  category text not null,
  url text not null check (url like 'https://%'),
  description text not null,
  sort_order integer not null default 0,
  active boolean not null default true
);
alter table public.games enable row level security;
revoke all on public.games from anon, authenticated;
grant select on public.games to anon, authenticated;
create policy "Read active games" on public.games for select to anon, authenticated using (active = true);
insert into public.games (id,name,category,url,description,sort_order) values
('na-mosca','Na Mosca','Palpites','https://na-mosca.vercel.app/','Chute perto, aposte certo e tente cravar.',1),
('bagunca','Bagunça','Festa','https://bagunca.vercel.app/','Cinco minijogos misturados numa partida só.',2),
('tom-exato','Tom Exato','Cores','https://tom-exato.vercel.app/','Recrie uma cor de memória e desafie a galera.',3);
commit;
