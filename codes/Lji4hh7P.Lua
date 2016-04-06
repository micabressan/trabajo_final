base_power = 50;
seu_ataque = 15;
level = 5;
stab = 1;

local def_alvo, type, critico, other = string.match(parametro, "(%d+) (%d+) (%d+) (%d+)");
escrever(n1);
escrever(n2);
escrever(n3);
escrever(n4);

if n1 == nil then
  escrever("Tente de novo. o uso correto é /macro <defesa do alvo>, <vantagem desvantagem>, <critico>, <other>");
  return;
end;


damage = ((2 * level + 10) / 250) * (seu_ataque / def_alvo) * (base_power + 2);
modifier = stab * critico * other * type;

final_damage = damage * modifier;

function enviar("O dano do Tackle de Tyrunt foi: " .. final_damage);