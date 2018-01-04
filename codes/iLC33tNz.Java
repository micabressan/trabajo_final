public void visualilzarGuest(Local local){
        int count = 0;
        int nrGuest;

        if(local.tipo().equals("Bar")){
            nrGuest = local.getNrGuest();
        }
        else {
            return;
        }
        for (Inscricao k:inscricoes.getInscritos()){
            if (k.getLocal().equals(local)){
                if (k.getPessoa().tipo().equals("Boemio")){
                    if (count<nrGuest){
                        count++;
                        System.out.println(k.getPessoa().getNome());
                    }
                    else {
                        return;
                    }
                }
            }
        }
        if (count<nrGuest){
            for (Inscricao k:inscricoes.getInscritos()){
                if (k.getLocal().equals(local)){
                    if (!(k.getPessoa().tipo().equals("Boemio"))){
                        if (count<nrGuest){
                            count++;
                            System.out.println(k.getPessoa().getNome());
                        }
                        else {
                            return;
                        }
                    }
                }
            }
        }
    }