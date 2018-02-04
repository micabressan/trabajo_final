import colaborar.domains.Inscricao
import colaborar.domains.Matricula
import colaborar.domains.financeiro.Cliente
import colaborar.domains.financeiro.CrDocumento
import colaborar.domains.financeiro.CrParcela
import colaborar.domains.financeiro.CrRegistroTitulo
import colaborar.domains.financeiro.CrTaxa
import colaborar.domains.financeiro.ViewBoletoRegistro
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification


@TestFor(PagamentoService)
@Mock([CrDocumento,CrTaxa,ViewBoletoRegistro,CrParcela,Matricula,Inscricao,Cliente,Empresa])
class PagamentoServiceSpec extends Specification {

    void 'test CrDocumento'(){
        when:
        def documento=new CrDocumento().save(flush:true)
        documento.setId(123456)

        then:
        println(documento.id)
    }

}