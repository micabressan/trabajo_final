package colaborar.domains.financeiro

import colaborar.domains.Empresa
import colaborar.domains.Inscricao
import colaborar.domains.Matricula

class CrDocumento {

	String tipoDocumento
	Matricula matricula
	Inscricao inscricao
	Cliente cliente
	Empresa empresa
	
	static constraints = {
    }

	static mapping = {
        version false
		id generator: 'sequence', params: [sequence:'sequence_documento'], comment: "Identificador da XXXXXXXXXXXXXXXXXXXXXXXXXX"
	}
}