public static int calcularModulo11(String numero){
        String pesos = '23456789';
        int dv = 0;
        int pos = 0;
        int soma = 0;
        int resto = 0;
        for(int i = numero.length(); i > 0; i--){
            soma += Integer.parseInt(numero[i]) * Integer.parseInt(pesos[pos]);
            pos = (pos < 9) ? pos++ : 0;
        }

        resto = soma % 11;

        if(resto == 10){
            dv = 1;
        } else if(resto == 0 || resto == 1){
            dv = 0;
        } else {
            dv = 11 - resto;
        }

        return dv
    }