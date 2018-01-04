'use strict';

var CotiacionPage = function (options) {
    var self  = this;
    var ui = {
        loader: $(".preloader"),
        tbcontratantes: $("#tbcontratantes"),
        tabla: '',
        resultadoContrante: $("#resultadoContrante")
    };

    self.restClient = new restClient(options.apiUrl, options.token);

    vueGetBuscar: new Vue({
        el: '#appContratante',
        data() {
            return {
                form: {
                    Identificador: '',
                    Nombres: '',
                    IdTipoIdentificador: 0,
                    __RequestVerificationToken: ''
                }
                //contrantes: [
                //{
                //    EmemNid: '',
                //    PnpnIdenti: '',
                //    PnpnNomraz: ''
                //}]
            }
        },
        methods: {
            verCotizaciones: function (idPropuesta) {
                console.log(idPropuesta);
            },
            createFiltro: function (e) {
                e.preventDefault();
                var model = this;
                model.form.__RequestVerificationToken = self.restClient.Token;
                if (model.form.Identificador === '' && model.form.Nombres === '') {
                    $.toast({
                        heading: 'Resultado Busqueda Contrante',
                        text: 'Debe ingresar un nombre o identificador',
                        position: 'top-right',
                        loaderBg: '#ffffff',
                        icon: 'error',
                        hideAfter: 4500,
                        stack: 6
                    });
                    return false;
                }
                //axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
                // console.log(configGlobal.URLAPP + 'Cotizacion/GetBuscaRutCliente');
                //axios.post(configGlobal.URLAPP + 'Cotizacion/GetBuscaRutCliente', this.form, { 'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8', common: { 'X-Requested-With': 'XMLHttpRequest' }, 'responseType': 'json' }).then(function (response) {
                //    resultElement.innerHTML = generateSuccessHTMLOutput(response);
                //    console.log(response);
                //}).catch(function (error) {
                //    resultElement.innerHTML = generateErrorHTMLOutput(error);
                //    console.log(error);
                //});

                ui.loader.fadeIn();
                self.restClient.post('Cotizacion/GetBuscaRutCliente', this.form, function (data) {
                    ui.loader.fadeOut();
                    if (data.length === 0) {
                        $("#resultadoContrante").hide();
                        model.form.Identificador = '';
                        model.form.Nombres = '';
                        $.toast({
                            heading: 'Resultado Busqueda Contrante',
                            text: 'Sin resultados, ingrese otro nombre o identificador',
                            position: 'top-right',
                            loaderBg: '#ffffff',
                            icon: 'warning',
                            hideAfter: 3500,
                            stack: 6
                        });
                        return false;
                    }
                    $("#resultadoContrante").show();
                    ui.tabla.clear();
                    ui.tabla.rows.add(data);
                    ui.tabla.draw();
                });
            }

        },
        mounted() {
            ui.tabla = $("#tbcontratantes").DataTable({
                "retrieve": false,
                "ordering": true,
                "info": true,
                "searching": false,
                "bLengthChange": false,
                //data: data,
                "columns": [
                    { "data": "EmemNid" },
                    { "data": "PnpnIdenti" },
                    { "data": "PnpnNomraz" }
                   // { "data": "PnpnNid" }
                ],
                'columnDefs': [
                    {
                        "targets": 3,
                        // 'className': 'dt-body-center',
                        "data": null,
                        'render': function (data, type, full, meta) {
                            return full.Existe ? '' : '<a href="' + configGlobal.URLAPP + "Cotizacion/ViewCotizaciones/" + data.PnpnNid + '" class="btn btn-xs btn-info"><i class="mdi mdi-magnify"></i> </a>';
                        }
                    }
                ],
                "language": {
                    //"lengthMenu": "Display _MENU_ records per page",
                    "zeroRecords": "Sin resultado",
                    "info": "Pagina _PAGE_ de _PAGES_, Total Resgitros _TOTAL_",
                    "infoEmpty": "0 Registros",
                    //"infoFiltered": "(filtered from _MAX_ total records)",
                    "paginate": {
                        "previous": "Anterior",
                        "next": "Siguiente"
                    }
                }

            });
        }
    });
};

var CotiacionPages = new CotiacionPage({
    apiUrl: configGlobal.URLAPP,
    token: $('[name=__RequestVerificationToken]').val()
});