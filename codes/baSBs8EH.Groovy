import org.springframework.stereotype.Component

@Component
class CompressXsltRouteBuilder extends BaseRouteBuilder{

    @Override
    void configureSpecial() throws Exception {

        from(getPath())
            .log(getPath())
            .startupOrder(1)
            .convertBodyTo(byte[].class, "iso-8859-1")
            .setBody(body().regexReplaceAll("\\r|\\n", ""))
            .log(body().toString())
            .to(getPath())
    }

    def getPath() {
        getClass().getResource("/xslt/SomeXsltWithLineBreaks.xsl").path
   }
}