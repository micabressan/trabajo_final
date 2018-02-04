import colaborar.domains.financeiro.CrDocumento
import colaborar.domains.financeiro.CrParcela
import colaborar.domains.financeiro.CrRegistroTitulo
import colaborar.domains.financeiro.CrTaxa
import colaborar.domains.financeiro.ViewBoletoRegistro
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification



@TestFor(PagamentoService)
@Mock([CrDocumento,CrTaxa,ViewBoletoRegistro,Matricula,Inscricao,Cliente,Empresa])
class PagamentoServiceSpec extends Specification {

        void 'test taxa'(){
        when:
        def documento=new CrDocumento()
        documento.id=123456
        documento.save()
        def crTaxa=new CrTaxa()
        crTaxa.id=123458
        crTaxa.crDocumento=documento
        crTaxa.save()
        def documentoInfo=service.getDocumentoInfo(documento)
        then:
        documentoInfo

    }

}