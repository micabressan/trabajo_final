base_power = 50;
seu_ataque = 15;
level = 5;
stab = 1;

local defesa_alvo = tonumber(parametro);
if defesa_alvo == nil then
	escrever("Digite a defesa do alvo: ");
	return;
end;

local type = tonumber(parametro);
if type == nil then
	escrever("Vantagem ou desvantagem? Digite a efetividade do golpe. EX: 2 = Super efetivo, 0.5 = não é efetivo ");
	return;
end;

local critico = tonumber(parametro);
if critico == nil then
	escrever("Golpe crítico? Se sim digite 1.5, se não digite apenas 1: ");
	return;
end;

local other = tonumber(parametro);
if other == nil then
	escrever("Alguma vantagem extra?: ");
	return;
end;

damage = ((2 * level + 10) / 250) * (seu_ataque / defesa_alvo) * (base_power + 2);
modifier = stab * critico * other * type;

final_damage = damage * modifier;

function enviar("O dano do Tackle de Tyrunt foi: " .. final_damage);