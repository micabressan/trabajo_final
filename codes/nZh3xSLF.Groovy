package colaborar.pagamentos

import colaborar.domains.financeiro.CrDocumento
import colaborar.domains.financeiro.CrTaxa


class PagamentoService {
def getDocumentoInfo(CrDocumento documento) {
			
		def crTaxa = CrTaxa.findByCrDocumento(documento)
		if (crTaxa) {
               return true
		}
	}