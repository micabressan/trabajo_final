class PalyazoKivalasztoModul extends Module {
    static content = {
        palyazoUgyfel { module new Select(labelId: 'ugyfel_label', panelId: 'ugyfel_panel') }
        palyazoNev { $('input', id: contains(':nev')) }
        palyazoUtonev { $('input', id: contains('utonev')) }
        palyazoOrszag { $('input', id: contains('szekhelyOrszag')) }
        palyazoVaros { $('input', id: contains('szekhelyVaros')) }
        palyazoSzuletesiIdo { $('input', id: contains('szuletesiIdo')) }
    }


    def fillUgyfelAdatok(ugyfelAdatok) {
        palyazoNev = ugyfelAdatok.nev
        palyazoUtonev = ugyfelAdatok.utoNev
        palyazoOrszag = ugyfelAdatok.orszag
        palyazoVaros = ugyfelAdatok.varos
        palyazoSzuletesiIdo = ugyfelAdatok.szuletesiIdo
    }
}