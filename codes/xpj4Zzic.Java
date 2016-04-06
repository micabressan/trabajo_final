package br.com.exemplo1.entidade;

public class Cliente {

    private int codigo;
    private String nome;
    private String telefone;

    public Cliente(int codigo, String nome, String telefone) {
        this.codigo = codigo;
        this.nome = nome;
        this.telefone = telefone;
    }
    
    
    /**
     * @return the codigo
     */
    public int getCodigo() {
        return codigo;
    }

    /**
     * @param codigo the codigo to set
     */
    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }

    /**
     * @return the nome
     */
    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * @return the telefone
     */
    public String getTelefone() {
        return telefone;
    }

    /**
     * @param telefone the telefone to set
     */
    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }
    
    public String getInformacao() {
        return "Código: "+ getCodigo() +"\n"+
                "Nome: "+getNome() +"\n" +
                "Telefone: "+getTelefone()+"\n";
    }

    
    @Override
    public boolean equals(Object obj) {
       
        if (obj != null && (obj instanceof Cliente)) {
            Cliente c = (Cliente) obj;
            return this.codigo == c.codigo;
        }
        
        return false;
    }
   
}