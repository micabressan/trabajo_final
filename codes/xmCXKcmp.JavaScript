var link_rais_url = window.location.protocol + "//" + window.location.hostname + "/";
var globalCanvasCropImageData = 0;
var globalCanvasCropImageDataOriginal = 0;
var globalCanvasImageDataEfeitoBarras = 0;
var permissoesFacebook = ['publish_actions', 'user_photos', 'email', 'publish_pages', 'user_about_me', 'user_likes', 'user_location', 'user_posts', 'instagram_basic', 'instagram_manage_comments', 'instagram_manage_insights'];
var tentativaBuscaAlbum = 0;
var tentativaPublicacao = 0;
var listaDeFotos = [];
var paginaIndiceGoogleFotos = 1;
var token = 0;
/** desativamos o botão de confirmar fotos caso  o array listaDeFotos esteja vazio **/
if(listaDeFotos.length == 0)
    $(".btnConfirmar").addClass("disabled");
else
    $(".btnConfirmar").removeClass("disabled");  

$("#modalConfirmacao").on("click", "#voltarAoCarrinho", function(e) {
    $("#loadOverlay").fadeIn();
    $("#proximaEtapa").closest("form").submit()
});0

function aplicaZoom(valZoom) {
    var valorScala = valZoom.split(",");
    var valorScalaUM = (parseFloat(valorScala[0])).toFixed(2);
    var valorScalaDois = (parseFloat(valorScala[1])).toFixed(2);
    var canvasPhotobook = $("#cropPhotobook")[0];
    var contextPhotobook = canvasPhotobook.getContext("2d");
    if (valorScalaUM > 0.05) {
        $("#cropPhotobook").attr("data-scala", valorScalaUM + "," + valorScalaDois);
        var canvasTemp = document.createElement('canvas');
        var ctxTemp = canvasTemp.getContext('2d');
        canvasTemp.width = globalCanvasImageDataEfeitoBarras.width;
        canvasTemp.height = globalCanvasImageDataEfeitoBarras.height;
        ctxTemp.putImageData(globalCanvasImageDataEfeitoBarras, 0, 0);
        contextPhotobook.clearRect(0, 0, canvasPhotobook.width, canvasPhotobook.height);
        contextPhotobook.save();
        contextPhotobook.scale(valorScalaUM, valorScalaDois);
        var zoomfactor = valorScalaUM;
        contextPhotobook.setTransform(zoomfactor, 0, 0, zoomfactor, -(zoomfactor - 1) * canvasPhotobook.width / 2, -(zoomfactor - 1) * (canvasPhotobook.height / 2));
        contextPhotobook.drawImage(canvasTemp, 0, 0);
        contextPhotobook.restore()
    }
}

$(".boxBotoesFinais").on("click", "#removeTodasImg", function(e) {
    $("#modalConfirmacao").modal('show');
    var pergunta = $("#modalConfirmacao").find("#perguntaAlerta");
    pergunta.html("Gostaria realmente de remover todas as imagens?");
    var botoes = $("#modalConfirmacao").find(".modal-footer-photobook");
    botoes.html('<button type="button" id="excluirTodasImgs" class="btn btn-warning btAnexarFotos" data-dismiss="modal" id="btn-close" >Sim</button>');
    botoes.append('<button type="button" class="btn btn-success btContinuarModal" data-dismiss="modal" id="btn-close" >Não</button>')
});

$(".modal-footer-photobook").on("click", "#excluirTodasImgs", function(e) {
    $("#loadOverlay").fadeIn();
    $.ajax({
        type: "POST",
        url: "/loja/fotoprodutos/excluirTodasImagens/",
        data: {
            dataPasta: $(".fileupload").attr("data-date"),
            idPasta: $(".fileupload").attr("data-idguid"),
            origem: $("#origem").val()
        }
    }).done(function(e) {
        $("#loadOverlay").fadeOut();
        $("#template-download").contents().remove();
        $("#valEnviados").text(0);
        $("#alertasArq").html("");
        $("#alertasArq").css("display", "none");
        $("#removeTodasImg").css("display", "none");
        $("#removeTodosEfeitos").css("display", "none")
    })
});

$(".boxBotoesFinais").on("click", "#removeTodosEfeitos", function(e) {
    $("#modalConfirmacao").modal('show');
    var pergunta = $("#modalConfirmacao").find("#perguntaAlerta");
    pergunta.html("Gostaria realmente de remover todos os efeitos?");
    var botoes = $("#modalConfirmacao").find(".modal-footer-photobook");
    botoes.html('<button type="button" id="excluirTodosEfeitos" class="btn btn-warning btAnexarFotos" data-dismiss="modal" id="btn-close" >Sim</button>');
    botoes.append('<button type="button" class="btn btn-success btContinuarModal" data-dismiss="modal" id="btn-close" >Não</button>')
});

$(".modal-footer-photobook").on("click", "#excluirTodosEfeitos", function(e) {
    $("#loadOverlay").fadeIn();
    $.ajax({
        type: "POST",
        url: "/loja/fotoprodutos/excluirTodosEfeitos/",
        data: {
            dataPasta: $(".fileupload").attr("data-date"),
            idPasta: $(".fileupload").attr("data-idguid")
        }
    }).done(function(e) {
        var obj = [];
        $(".imgsPhotobook").each(function() {
            obj.push({
                dataUrl: $(this).attr("data-url")
            });
            var rotateAtual = parseInt($(this).attr("rotate"));
            if (rotateAtual > 0) {
                $.ajax({
                    type: "POST",
                    url: "/loja/fotoprodutos/rotatefoto/",
                    data: {
                        caminho: $(this).attr("data-url"),
                        anguloRotate: (360 - rotateAtual)
                    }
                }).done(function(dados) {})
            }
            $(this).closest(".boxMasterImg").remove()
        });
        $("#canvasSerializado").val("");
        setTimeout(function() {
            var count = obj.length;
            $.each(obj, function(index, file) {
                var urls = this.dataUrl.replace(".jpeg", ".png");
                var img = new Image();
                img.addEventListener('load', function() {
                    if (img.complete) {
                        GerarImagemCropBase(this, urls);
                        if (!--count) {
                            $("#loadOverlay").fadeOut();
                            $("#removeTodosEfeitos").css("display", "none")
                        }
                        $(img).remove()
                    }
                }, !1);
                img.src = urls + "?_=" + (new Date().getTime())
            })
        }, 2000)
    })
});

$("#boxBotaoFinalizar").on("click", "#proximaEtapa", function(e) {
    var enviados = $(".imgsPhotobook").length;
    var comprados = parseInt($("#valComprados").text());
    if (enviados > 0) {
        if (comprados == enviados) {
            $("#loadOverlay").fadeIn();
            $(this).closest("form").submit()
        } else if (comprados > enviados) {
            $("#modalConfirmacao").modal('show');
            var pergunta = $("#modalConfirmacao").find("#perguntaAlerta");
            pergunta.html("Você comprou " + comprados + " arquivos e enviou apenas " + enviados + ", gostaria de:");
            var botoes = $("#modalConfirmacao").find(".modal-footer-photobook");
            botoes.html('<button type="button" id="continuarEnviando" class="btn btn-warning btAnexarFotos" data-dismiss="modal" id="btn-close" >Anexar Fotos</button>');
            botoes.append('<button type="button" id="voltarAoCarrinho" class="btn btn-success btContinuarModal" data-dismiss="modal" id="btn-close" ><i class="fa fa-check" aria-hidden="true"></i> Continuar</button>')
        } else {
            $("#modalConfirmacao").modal('show');
            var pergunta = $("#modalConfirmacao").find("#perguntaAlerta");
            pergunta.html("Você comprou " + comprados + " arquivos e enviou " + enviados + ", por favor remova " + (enviados - comprados) + " arquivo(s).");
            var botoes = $("#modalConfirmacao").find(".modal-footer-photobook");
            botoes.html('<button type="button" class="btn btn-default" data-dismiss="modal" id="btn-close" data-toggle="tooltip" title="Não"><i class="fa fa-remove"></i>&nbsp;Fechar</button>')
        }
    } else {
        $("#modalConfirmacao").modal('show');
        var pergunta = $("#modalConfirmacao").find("#perguntaAlerta");
        pergunta.html("Você ainda não enviou nenhum arquivo.");
        var botoes = $("#modalConfirmacao").find(".modal-footer-photobook");
        botoes.html('<a href="/loja/carrinho/" > <button type="button" class="btn btn-warning"><i class="fa fa-backward"></i>&nbsp;Enviar depois</button> </a>');
        botoes.append('<button type="button" class="btn btn-success" id="envAgora"><i class="fa fa-cloud-upload"></i>&nbsp;Enviar agora</button>')
    }
});

$("#modalConfirmacao").on("click", "#envAgora", function(e) {
    $("#modalConfirmacao").modal('hide');
    $("#meucomputador").trigger('click')
});

$("#template-download").on("click", ".openImgsPhotobook", function(e) {
    var divCanvas = $(this).closest(".boxMasterImg").find(".imgsPhotobook");
    $(divCanvas).trigger('click')
});

$("#template-download").on("click", ".duplicarImgsPhotobook", function(e) {
    var urlImg = $(this).closest(".boxMasterImg").find(".imgsPhotobook").attr("data-url");
    var boxImg = $(this).closest(".boxMasterImg");
    var conteudoBoxImg = $(boxImg).clone();
    var canvasASerClonado = $(this).closest(".boxMasterImg").find(".imgsPhotobook")[0];
    var contextASerClonado = canvasASerClonado.getContext("2d");
    var imageDataClonado = contextASerClonado.getImageData(0, 0, canvasASerClonado.width, canvasASerClonado.height);
    $.ajax({
        type: "POST",
        url: "/loja/fotoprodutos/duplicarfoto/",
        data: {
            caminho: urlImg
        }
    }).done(function(caminhoNovo) {
        $(conteudoBoxImg).find(".imgsPhotobook").attr("data-url", caminhoNovo);
        $(boxImg).after(conteudoBoxImg);
        var canvasClonado = $(conteudoBoxImg).find(".imgsPhotobook")[0];
        var contextClonado = canvasClonado.getContext("2d");
        contextClonado.putImageData(imageDataClonado, 0, 0);
        $("#valEnviados").text($(".imgsPhotobook").length);
        var totExclusao = (parseInt($(".imgsPhotobook").length) - parseInt($("#valComprados").text()));
        if (totExclusao > 0) {
            $("#alertasArq").html("Por favor, exclua " + (parseInt($(".imgsPhotobook").length) - parseInt($("#valComprados").text())) + " arquivos.");
            $("#alertasArq").css("display", "block")
        } else {
            $("#alertasArq").html("");
            $("#alertasArq").css("display", "none")
        }
        preencheSerializado(1)
    })
});

$("#template-download").on("click", ".rotateImgsPhotobook", function(e) {
    var urlImg = $(this).closest(".boxMasterImg").find(".imgsPhotobook").attr("data-url");
    var divCanvas = $(this).closest(".boxMasterImg").find(".imgsPhotobook");
    var canvasASerRodado = $(this).closest(".boxMasterImg").find(".imgsPhotobook")[0];
    var contextASerRodado = canvasASerRodado.getContext("2d");
    $("#loadOverlay").fadeIn();
    $.ajax({
        type: "POST",
        url: "/loja/fotoprodutos/rotatefoto/",
        data: {
            caminho: urlImg
        }
    }).done(function(dados) {
        var dados = $.parseJSON(dados);
        var img = new Image();
        img.addEventListener('load', function() {
            var oWidth = this.width;
            var oHeight = this.height;
            if (oWidth < oHeight) {
                var mWidth = 94;
                var mHeight = 132;
                $(divCanvas).addClass("imgsPhotobookHeight");
                $(divCanvas).removeClass("imgsPhotobookWidth")
            } else {
                var mWidth = 132;
                var mHeight = 94;
                $(divCanvas).addClass("imgsPhotobookWidth");
                $(divCanvas).removeClass("imgsPhotobookHeight")
            }
            if (!$(divCanvas).attr("rotate")) {
                $(divCanvas).attr("rotate", 0)
            }
            $(divCanvas).attr("rotate", (parseInt($(divCanvas).attr("rotate")) + 90));
            var w = $(divCanvas).attr("h");
            var h = $(divCanvas).attr("w");
            var canvasW = $(divCanvas).attr("canvasw");
            var canvasH = $(divCanvas).attr("canvash");
            if (canvasW < canvasH) {
                switch ($(divCanvas).attr("rotate")) {
                    case '90':
                    case '270':
                        var x2 = $(divCanvas).attr("y2");
                        var y2 = $(divCanvas).attr("x2");
                        var x1 = $(divCanvas).attr("y1");
                        var y1 = $(divCanvas).attr("x1");
                        break;
                    case '180':
                        if (w <= 0) {
                            canvasW = 0;
                            canvasH = 0
                        }
                        var x2 = canvasW - $(divCanvas).attr("y1");
                        var y2 = canvasH - $(divCanvas).attr("x1");
                        var x1 = (x2 - w);
                        var y1 = (y2 - h);
                        break;
                    case '360':
                        if (w <= 0) {
                            canvasW = 0;
                            canvasH = 0
                        }
                        $(divCanvas).attr("rotate", 0);
                        var x2 = canvasW - $(divCanvas).attr("y1");
                        var y2 = canvasH - $(divCanvas).attr("x1");
                        var x1 = (x2 - w);
                        var y1 = (y2 - h);
                        break
                }
            } else {
                switch ($(divCanvas).attr("rotate")) {
                    case '90':
                    case '270':
                        if (w <= 0) {
                            canvasW = 0;
                            canvasH = 0
                        }
                        var x2 = canvasH - $(divCanvas).attr("y1");
                        var y2 = canvasW - $(divCanvas).attr("x1");
                        var x1 = (x2 - w);
                        var y1 = (y2 - h);
                        break;
                    case '180':
                        var x2 = $(divCanvas).attr("y2");
                        var y2 = $(divCanvas).attr("x2");
                        var x1 = $(divCanvas).attr("y1");
                        var y1 = $(divCanvas).attr("x1");
                        break;
                    case '360':
                        $(divCanvas).attr("rotate", 0);
                        var x2 = $(divCanvas).attr("y2");
                        var y2 = $(divCanvas).attr("x2");
                        var x1 = $(divCanvas).attr("y1");
                        var y1 = $(divCanvas).attr("x1");
                        break
                }
            }
            $(divCanvas).attr("x1", x1);
            $(divCanvas).attr("y1", y1);
            $(divCanvas).attr("x2", x2);
            $(divCanvas).attr("y2", y2);
            $(divCanvas).attr("w", w);
            $(divCanvas).attr("h", h);
            contextASerRodado.clearRect(0, 0, canvasASerRodado.width, canvasASerRodado.height);
            $(divCanvas).attr("width", mWidth);
            $(divCanvas).attr("height", mHeight);
            contextASerRodado.drawImage(this, 0, 0, mWidth, mHeight);
            preencheSerializado(1);
            $("#loadOverlay").fadeOut()
        }, !0);
        img.src = dados.caminho + "?_=" + (new Date().getTime())
    })
});

$("#template-download").on("click", ".closeImgsPhotobook", function(e) {
    var urlImg = $(this).closest(".boxMasterImg").find(".imgsPhotobook").attr("data-url");
    var boxImg = $(this).closest(".boxMasterImg");
    $.ajax({
        type: "POST",
        url: "/loja/fotoprodutos/excluirfoto/",
        data: {
            caminho: urlImg
        }
    }).done(function(o) {
        boxImg.remove();
        $("#valEnviados").text($(".imgsPhotobook").length);
        var totExclusao = (parseInt($(".imgsPhotobook").length) - parseInt($("#valComprados").text()));
        if (totExclusao > 0) {
            $("#alertasArq").html("Por favor, exclua " + (parseInt($(".imgsPhotobook").length) - parseInt($("#valComprados").text())) + " arquivos.");
            $("#alertasArq").css("display", "block")
        } else {
            $("#alertasArq").html("");
            $("#alertasArq").css("display", "none")
        }
        preencheSerializado(1);
        if (($(".imgsPhotobook").length) == 0) {
            $("#removeTodasImg").css("display", "none");
            $("#removeTodosEfeitos").css("display", "none")
        }
    })
});

$(".boxRanger").on("input", ".efeitosBarrasBCSM", function(e) {
    var spanValor = $(this).closest(".boxRanger").find(".valueRanger");
    $(spanValor).html($(this).val());
    if (parseInt($(this).attr("max")) == 99) {
        var mais = 22
    } else {
        var mais = -15
    }
    var max = parseInt($(this).attr("max")) + mais;
    var value = $(this).val();
    var percent = value / max;
    var width = $(this).width();
    var left = ((percent * width) + 1 - value) + 129;
    $(spanValor).parent().css("display", "block");
    $(spanValor).parent().css("left", left);
    $(spanValor).parent().css("top", "-25px")
});

$(".efeitosBarrasBCSM").mouseout(function() {
    var spanValor = $(this).closest(".boxRanger").find(".valueRanger");
    $(spanValor).parent().css("display", "none")
});

$("#boxEfeitosBarras").on("click", "#limparAjuste", function(e) {
    $("#rangerZoom").val(0);
    $("#rangerBrilho").val(0);
    $("#rangerContraste").val(0);
    $("#rangerSaturacao").val(0);
    $("#rangerMatiz").val(0);
    $(".efeitosBarrasBCSM").trigger('change')
});

$("#barrasEfeito").on("change", ".efeitosBarrasBCSM", function(e) {
    var canvasPhotobook = $("#cropPhotobook")[0];
    var contextPhotobook = canvasPhotobook.getContext("2d");
    if ($(this).attr('id') == "rangerZoom") {
        var valRanger = parseInt($("#rangerZoom").val());
        if (valRanger > 0)
            var ranger = parseFloat(1 + (valRanger * 0.05)).toFixed(2);
        else if (valRanger == 0)
            var ranger = parseFloat(1.00).toFixed(2);
        else {
            if (valRanger < -90)
                var ranger = parseFloat(0.10).toFixed(2);
            else var ranger = parseFloat(1 - ((valRanger * -1) * 0.01)).toFixed(2)
        }
        $("#cropPhotobook").attr("data-scala", ranger + "," + ranger)
    }
    var rangerZoom = $("#cropPhotobook").attr("data-scala");
    var rangerBrilho = $("#rangerBrilho").val();
    var rangerContraste = $("#rangerContraste").val();
    var rangerSaturacao = $("#rangerSaturacao").val();
    var rangerMatiz = $("#rangerMatiz").val();
    contextPhotobook.putImageData(globalCanvasImageDataEfeitoBarras, 0, 0);
    gerarEfeitosBarras(canvasPhotobook, rangerZoom, rangerBrilho, rangerContraste, rangerSaturacao, rangerMatiz)
});

function aplicarBorda(canvasBorda) {
    var contextBorda = canvasBorda.getContext("2d");
    contextBorda.lineWidth = $("#bordaImg").attr("data-tamanho");
    contextBorda.strokeStyle = "#ffffff";
    contextBorda.strokeRect(0, 0, canvasBorda.width, canvasBorda.height)
}

$("#boxEfeitosBorda").on("click", "#aplicarBorda", function(e) {
    if (!parseInt($(this).val())) {
        var filtro = '[data-url="' + $("#cropPhotobook").attr("data-url") + '"]';
        var canvasPequeno = $('.imgsPhotobook').filter(filtro);
        canvasPequeno.attr("data-borda", 1);
        $(this).val(1);
        $(this).html("Remover borda");
        $("#bordaImg").val(1);
        aplicarBorda($("#canvasBorda")[0])
    } else {
        var filtro = '[data-url="' + $("#cropPhotobook").attr("data-url") + '"]';
        var canvasPequeno = $('.imgsPhotobook').filter(filtro);
        canvasPequeno.attr("data-borda", 0);
        $(this).val(0);
        $("#bordaImg").val(0);
        $(this).html("Aplicar borda");
        $("#boxBorda").html("");
        $("#boxBorda").append(canvasCropado())
    }
});

function canvasCropado() {
    var canvasPhotobook = $("#cropPhotobook")[0];
    var contextPhotobook = canvasPhotobook.getContext("2d");
    var imageData = contextPhotobook.getImageData($("#x1").val(), $("#y1").val(), canvasPhotobook.width, canvasPhotobook.height);
    var canvas = document.createElement('canvas');
    canvas.setAttribute("id", "canvasBorda");
    var ctx = canvas.getContext('2d');
    var tamanhoImg = ($("#tamanhoImg").val()).split(",");
    if ($("#w").val() > $("#h").val()) {
        var dwidth = parseInt(tamanhoImg[1]);
        var dheight = parseInt(tamanhoImg[0])
    } else {
        var dwidth = parseInt(tamanhoImg[0]);
        var dheight = parseInt(tamanhoImg[1])
    }
    canvas.width = dwidth;
    canvas.height = dheight;
    ctx.putImageData(imageData, 0, 0);
    return canvas
}

function abas(aba) {
    switch (aba) {
        case "efeitosProntos":
            $(".boxsEfeitos").css("display", "none");
            $("#boxEfeitosCanvas").css("display", "block");
            $(".boxAbasCrop").find(".iativo").removeClass("iativo");
            $("#magicCrop").addClass("iativo");
            $("#boxBorda").remove();
            $("#box_crop").css("display", "block");
            break;
        case "efeitosBarras":
            $(".boxsEfeitos").css("display", "none");
            $("#boxEfeitosBarras").css("display", "block");
            $(".boxAbasCrop").find(".iativo").removeClass("iativo");
            $("#slidersCrop").addClass("iativo");
            $("#boxBorda").remove();
            $("#box_crop").css("display", "block");
            break;
        case "efeitosBorda":
            $(".boxsEfeitos").css("display", "none");
            $("#boxEfeitosBorda").css("display", "block");
            $(".boxAbasCrop").find(".iativo").removeClass("iativo");
            $("#bordaCrop").addClass("iativo");
            $("#box_crop").css("display", "none");
            $("#boxBorda").remove();
            var div = document.createElement('div');
            div.setAttribute("id", "boxBorda");
            $(div).append(canvasCropado());
            $("#areaCropPhootobook").append(div);
            if (parseInt($("#bordaImg").val())) {
                aplicarBorda($("#canvasBorda")[0]);
                $("#aplicarBorda").val(1);
                $("#aplicarBorda").html("Remover borda")
            } else {
                $("#aplicarBorda").val(0);
                $("#aplicarBorda").html("Aplicar borda")
            }
            $("#boxBorda").css("width", $("#canvasBorda").css("width"));
            break;
        default:
            ''
    }
}

$(".boxAbasCrop").on("click", ".abasCrop", function(e) {
    abas($(this).attr("data-aba"))
});

function gerarEfeitosBarras(canvasEB, rangerZoom, rangerBrilho, rangerContraste, rangerSaturacao, rangerMatiz) {
    aplicaZoom(rangerZoom);
    var contextP = canvasEB.getContext("2d");
    var imgData = contextP.getImageData(0, 0, canvasEB.width, canvasEB.height);
    var colorCorrected = colorMatrix(imgData, {
        contrast: rangerBrilho,
        brightness: rangerContraste,
        saturation: rangerSaturacao,
        hue: rangerMatiz
    });
    contextP.putImageData(colorCorrected, 0, 0)
}

function gerarEfeitos(imgData, contextEfeitos, efeito) {
    switch (efeito) {
        case 1:
            retornaCanvasCrop(contextEfeitos);
            break;
        case 2:
            if (imgData != "") {
                for (y = 0; y < imgData.height; y++) {
                    for (x = 0; x < imgData.width; x++) {
                        var i = ((y * 4) * imgData.width) + (x * 4);
                        var aveColor = parseInt((imgData.data[i] + imgData.data[i + 1] + imgData.data[i + 2]) / 3);
                        imgData.data[i] = aveColor;
                        imgData.data[i + 1] = aveColor;
                        imgData.data[i + 2] = aveColor
                    }
                }
                contextEfeitos.putImageData(imgData, 0, 0)
            }
            $("#txtEfeitos" + efeito).text("Preto e branco");
            break;
        case 3:
            makeTint(contextEfeitos, imgData, 30, 25, 0);
            $("#txtEfeitos" + efeito).text("Sepia");
            break;
        case 4:
            makeTint(contextEfeitos, imgData, 220, 40, 10);
            $("#txtEfeitos" + efeito).text("cyanotype");
            break;
        case 5:
            if (imgData != "") {
                for (y = 0; y < imgData.height; y++) {
                    for (x = 0; x < imgData.width; x++) {
                        var i = ((y * 4) * imgData.width) + (x * 4);
                        var aveColor = parseInt((imgData.data[i] + imgData.data[i + 1] + imgData.data[i + 2]) / 3);
                        imgData.data[i] = 255 - imgData.data[i];
                        imgData.data[i + 1] = 255 - imgData.data[i + 1];
                        imgData.data[i + 2] = 255 - imgData.data[i + 2]
                    }
                }
                contextEfeitos.putImageData(imgData, 0, 0)
            }
            $("#txtEfeitos" + efeito).text("Inverter");
            break;
        case 6:
            var pixelSize = Math.ceil(1.5),
                width = imgData.width,
                height = imgData.height,
                x, y, i, red, green, blue, alpha, nBinsX = Math.ceil(width / pixelSize),
                nBinsY = Math.ceil(height / pixelSize),
                xBinStart, xBinEnd, yBinStart, yBinEnd, xBin, yBin, pixelsInBin;
            imgData.data;
            for (xBin = 0; xBin < nBinsX; xBin += 1) {
                for (yBin = 0; yBin < nBinsY; yBin += 1) {
                    red = 0;
                    green = 0;
                    blue = 0;
                    alpha = 0;
                    xBinStart = xBin * pixelSize;
                    xBinEnd = xBinStart + pixelSize;
                    yBinStart = yBin * pixelSize;
                    yBinEnd = yBinStart + pixelSize;
                    pixelsInBin = 0;
                    for (x = xBinStart; x < xBinEnd; x += 1) {
                        if (x >= width) {
                            continue
                        }
                        for (y = yBinStart; y < yBinEnd; y += 1) {
                            if (y >= height) {
                                continue
                            }
                            i = (width * y + x) * 4;
                            red += imgData.data[i + 0];
                            green += imgData.data[i + 1];
                            blue += imgData.data[i + 2];
                            alpha += imgData.data[i + 3];
                            pixelsInBin += 1
                        }
                    }
                    red = red / pixelsInBin;
                    green = green / pixelsInBin;
                    blue = blue / pixelsInBin;
                    for (x = xBinStart; x < xBinEnd; x += 1) {
                        if (x >= width) {
                            continue
                        }
                        for (y = yBinStart; y < yBinEnd; y += 1) {
                            if (y >= height) {
                                continue
                            }
                            i = (width * y + x) * 4;
                            imgData.data[i + 0] = red;
                            imgData.data[i + 1] = green;
                            imgData.data[i + 2] = blue;
                            imgData.data[i + 3] = alpha
                        }
                    }
                }
            }
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Pixelate");
            break;
        case 7:
            var
                w = imgData.width,
                h = imgData.height,
                w4 = w * 4,
                y = h;
            do {
                var offsetY = (y - 1) * w4;
                var x = w;
                do {
                    var offset = offsetY + (x - 1) * 4;
                    var r = imgData.data[offset];
                    var g = imgData.data[offset + 1];
                    var b = imgData.data[offset + 2];
                    if (r > 127) {
                        r = 255 - r
                    }
                    if (g > 127) {
                        g = 255 - g
                    }
                    if (b > 127) {
                        b = 255 - b
                    }
                    imgData.data[offset] = r;
                    imgData.data[offset + 1] = g;
                    imgData.data[offset + 2] = b
                } while (--x)
            } while (--y);
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Solarize");
            break;
        case 8:
            var total = 0.4;
            var brightness = total * 255,
                len = imgData.data.length,
                i;
            for (y = 0; y < imgData.height; y++) {
                for (x = 0; x < imgData.width; x++) {
                    var i = ((y * 4) * imgData.width) + (x * 4);
                    imgData.data[i] += brightness;
                    imgData.data[i + 1] += brightness;
                    imgData.data[i + 2] += brightness
                }
            }
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Brighten");
            break;
        case 9:
            var embossStrength = 0.1;
            var embossWhiteLevel = 0.2;
            var embossDirection = "top-left";
            var embossBlend = "true";
            var strength = embossStrength * 10,
                greyLevel = embossWhiteLevel * 255,
                direction = embossDirection,
                blend = embossBlend,
                dirY = 0,
                dirX = 0,
                w = imgData.width,
                h = imgData.height,
                w4 = w * 4,
                y = h;
            switch (direction) {
                case 'top-left':
                    dirY = -1;
                    dirX = -1;
                    break;
                case 'top':
                    dirY = -1;
                    dirX = 0;
                    break;
                case 'top-right':
                    dirY = -1;
                    dirX = 1;
                    break;
                case 'right':
                    dirY = 0;
                    dirX = 1;
                    break;
                case 'bottom-right':
                    dirY = 1;
                    dirX = 1;
                    break;
                case 'bottom':
                    dirY = 1;
                    dirX = 0;
                    break;
                case 'bottom-left':
                    dirY = 1;
                    dirX = -1;
                    break;
                case 'left':
                    dirY = 0;
                    dirX = -1;
                    break;
                default:
                    ''
            }
            do {
                var offsetY = (y - 1) * w4;
                var otherY = dirY;
                if (y + otherY < 1) {
                    otherY = 0
                }
                if (y + otherY > h) {
                    otherY = 0
                }
                var offsetYOther = (y - 1 + otherY) * w * 4;
                var x = w;
                do {
                    var offset = offsetY + (x - 1) * 4;
                    var otherX = dirX;
                    if (x + otherX < 1) {
                        otherX = 0
                    }
                    if (x + otherX > w) {
                        otherX = 0
                    }
                    var offsetOther = offsetYOther + (x - 1 + otherX) * 4;
                    var dR = imgData.data[offset] - imgData.data[offsetOther];
                    var dG = imgData.data[offset + 1] - imgData.data[offsetOther + 1];
                    var dB = imgData.data[offset + 2] - imgData.data[offsetOther + 2];
                    var dif = dR;
                    var absDif = dif > 0 ? dif : -dif;
                    var absG = dG > 0 ? dG : -dG;
                    var absB = dB > 0 ? dB : -dB;
                    if (absG > absDif) {
                        dif = dG
                    }
                    if (absB > absDif) {
                        dif = dB
                    }
                    dif *= strength;
                    if (blend) {
                        var r = imgData.data[offset] + dif;
                        var g = imgData.data[offset + 1] + dif;
                        var b = imgData.data[offset + 2] + dif;
                        imgData.data[offset] = r > 255 ? 255 : r < 0 ? 0 : r;
                        imgData.data[offset + 1] = g > 255 ? 255 : g < 0 ? 0 : g;
                        imgData.data[offset + 2] = b > 255 ? 255 : b < 0 ? 0 : b
                    } else {
                        var grey = greyLevel - dif;
                        if (grey < 0) {
                            grey = 0
                        } else if (grey > 255) {
                            grey = 255
                        }
                        imgData.data[offset] = imgData.data[offset + 1] = imgData.data[offset + 2] = grey
                    }
                } while (--x)
            } while (--y);
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Emboss");
            break;
        case 10:
            function remap(fromValue, fromMin, fromMax, toMin, toMax) {
                var fromRange = fromMax - fromMin,
                    toRange = toMax - toMin,
                    toValue;
                if (fromRange === 0) {
                    return toMin + toRange / 2
                }
                if (toRange === 0) {
                    return toMin
                }
                toValue = (fromValue - fromMin) / fromRange;
                toValue = toRange * toValue + toMin;
                return toValue
            }
            var nSubPixels = imgData.data.length,
                rMin = imgData.data[0],
                rMax = rMin,
                r, gMin = imgData.data[1],
                gMax = gMin,
                g, bMin = imgData.data[2],
                bMax = bMin,
                b, i;
            var enhanceAmount = 0.8;
            for (i = 0; i < nSubPixels; i += 4) {
                r = imgData.data[i + 0];
                if (r < rMin) {
                    rMin = r
                } else if (r > rMax) {
                    rMax = r
                }
                g = imgData.data[i + 1];
                if (g < gMin) {
                    gMin = g
                } else if (g > gMax) {
                    gMax = g
                }
                b = imgData.data[i + 2];
                if (b < bMin) {
                    bMin = b
                } else if (b > bMax) {
                    bMax = b
                }
            }
            if (rMax === rMin) {
                rMax = 255;
                rMin = 0
            }
            if (gMax === gMin) {
                gMax = 255;
                gMin = 0
            }
            if (bMax === bMin) {
                bMax = 255;
                bMin = 0
            }
            var rMid, rGoalMax, rGoalMin, gMid, gGoalMax, gGoalMin, bMid, bGoalMax, bGoalMin;
            if (enhanceAmount > 0) {
                rGoalMax = rMax + enhanceAmount * (255 - rMax);
                rGoalMin = rMin - enhanceAmount * (rMin - 0);
                gGoalMax = gMax + enhanceAmount * (255 - gMax);
                gGoalMin = gMin - enhanceAmount * (gMin - 0);
                bGoalMax = bMax + enhanceAmount * (255 - bMax);
                bGoalMin = bMin - enhanceAmount * (bMin - 0)
            } else {
                rMid = (rMax + rMin) * 0.5;
                rGoalMax = rMax + enhanceAmount * (rMax - rMid);
                rGoalMin = rMin + enhanceAmount * (rMin - rMid);
                gMid = (gMax + gMin) * 0.5;
                gGoalMax = gMax + enhanceAmount * (gMax - gMid);
                gGoalMin = gMin + enhanceAmount * (gMin - gMid);
                bMid = (bMax + bMin) * 0.5;
                bGoalMax = bMax + enhanceAmount * (bMax - bMid);
                bGoalMin = bMin + enhanceAmount * (bMin - bMid)
            }
            for (i = 0; i < nSubPixels; i += 4) {
                imgData.data[i + 0] = remap(imgData.data[i + 0], rMin, rMax, rGoalMin, rGoalMax);
                imgData.data[i + 1] = remap(imgData.data[i + 1], gMin, gMax, gGoalMin, gGoalMax);
                imgData.data[i + 2] = remap(imgData.data[i + 2], bMin, bMax, bGoalMin, bGoalMax)
            }
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Enhance");
            break;
        case 11:
            var len = imgData.data.length,
                i, brightness;
            for (i = 0; i < len; i += 4) {
                brightness = 0.34 * imgData.data[i] + 0.5 * imgData.data[i + 1] + 0.16 * imgData.data[i + 2];
                imgData.data[i] = brightness;
                imgData.data[i + 1] = brightness;
                imgData.data[i + 2] = brightness
            }
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Grayscale");
            break;
        case 12:
            var threshold = 0.5;
            var level = threshold * 255,
                len = imgData.data.length,
                i;
            for (i = 0; i < len; i += 1) {
                imgData.data[i] = imgData.data[i] < level ? 0 : 255
            }
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Threshold");
            break;
        case 13:
            var levelsPotencia = 0.8;
            var levels = Math.round(levelsPotencia * 254) + 1,
                len = imgData.data.length,
                scale = 255 / levels,
                i;
            for (i = 0; i < len; i += 1) {
                imgData.data[i] = Math.floor(imgData.data[i] / scale) * scale
            }
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Posterize");
            break;
        case 14:
            function BlurStack() {
                this.r = 0;
                this.g = 0;
                this.b = 0;
                this.a = 0;
                this.next = null
            }
            var radius = Math.round(1);
            var mul_table = [512, 512, 456, 512, 328, 456, 335, 512, 405, 328, 271, 456, 388, 335, 292, 512, 454, 405, 364, 328, 298, 271, 496, 456, 420, 388, 360, 335, 312, 292, 273, 512, 482, 454, 428, 405, 383, 364, 345, 328, 312, 298, 284, 271, 259, 496, 475, 456, 437, 420, 404, 388, 374, 360, 347, 335, 323, 312, 302, 292, 282, 273, 265, 512, 497, 482, 468, 454, 441, 428, 417, 405, 394, 383, 373, 364, 354, 345, 337, 328, 320, 312, 305, 298, 291, 284, 278, 271, 265, 259, 507, 496, 485, 475, 465, 456, 446, 437, 428, 420, 412, 404, 396, 388, 381, 374, 367, 360, 354, 347, 341, 335, 329, 323, 318, 312, 307, 302, 297, 292, 287, 282, 278, 273, 269, 265, 261, 512, 505, 497, 489, 482, 475, 468, 461, 454, 447, 441, 435, 428, 422, 417, 411, 405, 399, 394, 389, 383, 378, 373, 368, 364, 359, 354, 350, 345, 341, 337, 332, 328, 324, 320, 316, 312, 309, 305, 301, 298, 294, 291, 287, 284, 281, 278, 274, 271, 268, 265, 262, 259, 257, 507, 501, 496, 491, 485, 480, 475, 470, 465, 460, 456, 451, 446, 442, 437, 433, 428, 424, 420, 416, 412, 408, 404, 400, 396, 392, 388, 385, 381, 377, 374, 370, 367, 363, 360, 357, 354, 350, 347, 344, 341, 338, 335, 332, 329, 326, 323, 320, 318, 315, 312, 310, 307, 304, 302, 299, 297, 294, 292, 289, 287, 285, 282, 280, 278, 275, 273, 271, 269, 267, 265, 263, 261, 259];
            var shg_table = [9, 11, 12, 13, 13, 14, 14, 15, 15, 15, 15, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24, 24];
            var width = imgData.width,
                height = imgData.height;
            var x, y, i, p, yp, yi, yw, r_sum, g_sum, b_sum, a_sum, r_out_sum, g_out_sum, b_out_sum, a_out_sum, r_in_sum, g_in_sum, b_in_sum, a_in_sum, pr, pg, pb, pa, rbs;
            var div = radius + radius + 1,
                widthMinus1 = width - 1,
                heightMinus1 = height - 1,
                radiusPlus1 = radius + 1,
                sumFactor = radiusPlus1 * (radiusPlus1 + 1) / 2,
                stackStart = new BlurStack(),
                stackEnd = null,
                stack = stackStart,
                stackIn = null,
                stackOut = null,
                mul_sum = mul_table[radius],
                shg_sum = shg_table[radius];
            for (i = 1; i < div; i++) {
                stack = stack.next = new BlurStack();
                if (i === radiusPlus1) {
                    stackEnd = stack
                }
            }
            stack.next = stackStart;
            yw = yi = 0;
            for (y = 0; y < height; y++) {
                r_in_sum = g_in_sum = b_in_sum = a_in_sum = r_sum = g_sum = b_sum = a_sum = 0;
                r_out_sum = radiusPlus1 * (pr = imgData.data[yi]);
                g_out_sum = radiusPlus1 * (pg = imgData.data[yi + 1]);
                b_out_sum = radiusPlus1 * (pb = imgData.data[yi + 2]);
                a_out_sum = radiusPlus1 * (pa = imgData.data[yi + 3]);
                r_sum += sumFactor * pr;
                g_sum += sumFactor * pg;
                b_sum += sumFactor * pb;
                a_sum += sumFactor * pa;
                stack = stackStart;
                for (i = 0; i < radiusPlus1; i++) {
                    stack.r = pr;
                    stack.g = pg;
                    stack.b = pb;
                    stack.a = pa;
                    stack = stack.next
                }
                for (i = 1; i < radiusPlus1; i++) {
                    p = yi + ((widthMinus1 < i ? widthMinus1 : i) << 2);
                    r_sum += (stack.r = pr = imgData.data[p]) * (rbs = radiusPlus1 - i);
                    g_sum += (stack.g = pg = imgData.data[p + 1]) * rbs;
                    b_sum += (stack.b = pb = imgData.data[p + 2]) * rbs;
                    a_sum += (stack.a = pa = imgData.data[p + 3]) * rbs;
                    r_in_sum += pr;
                    g_in_sum += pg;
                    b_in_sum += pb;
                    a_in_sum += pa;
                    stack = stack.next
                }
                stackIn = stackStart;
                stackOut = stackEnd;
                for (x = 0; x < width; x++) {
                    imgData.data[yi + 3] = pa = (a_sum * mul_sum) >> shg_sum;
                    if (pa !== 0) {
                        pa = 255 / pa;
                        imgData.data[yi] = ((r_sum * mul_sum) >> shg_sum) * pa;
                        imgData.data[yi + 1] = ((g_sum * mul_sum) >> shg_sum) * pa;
                        imgData.data[yi + 2] = ((b_sum * mul_sum) >> shg_sum) * pa
                    } else {
                        imgData.data[yi] = imgData.data[yi + 1] = imgData.data[yi + 2] = 0
                    }
                    r_sum -= r_out_sum;
                    g_sum -= g_out_sum;
                    b_sum -= b_out_sum;
                    a_sum -= a_out_sum;
                    r_out_sum -= stackIn.r;
                    g_out_sum -= stackIn.g;
                    b_out_sum -= stackIn.b;
                    a_out_sum -= stackIn.a;
                    p = (yw + ((p = x + radius + 1) < widthMinus1 ? p : widthMinus1)) << 2;
                    r_in_sum += stackIn.r = imgData.data[p];
                    g_in_sum += stackIn.g = imgData.data[p + 1];
                    b_in_sum += stackIn.b = imgData.data[p + 2];
                    a_in_sum += stackIn.a = imgData.data[p + 3];
                    r_sum += r_in_sum;
                    g_sum += g_in_sum;
                    b_sum += b_in_sum;
                    a_sum += a_in_sum;
                    stackIn = stackIn.next;
                    r_out_sum += pr = stackOut.r;
                    g_out_sum += pg = stackOut.g;
                    b_out_sum += pb = stackOut.b;
                    a_out_sum += pa = stackOut.a;
                    r_in_sum -= pr;
                    g_in_sum -= pg;
                    b_in_sum -= pb;
                    a_in_sum -= pa;
                    stackOut = stackOut.next;
                    yi += 4
                }
                yw += width
            }
            for (x = 0; x < width; x++) {
                g_in_sum = b_in_sum = a_in_sum = r_in_sum = g_sum = b_sum = a_sum = r_sum = 0;
                yi = x << 2;
                r_out_sum = radiusPlus1 * (pr = imgData.data[yi]);
                g_out_sum = radiusPlus1 * (pg = imgData.data[yi + 1]);
                b_out_sum = radiusPlus1 * (pb = imgData.data[yi + 2]);
                a_out_sum = radiusPlus1 * (pa = imgData.data[yi + 3]);
                r_sum += sumFactor * pr;
                g_sum += sumFactor * pg;
                b_sum += sumFactor * pb;
                a_sum += sumFactor * pa;
                stack = stackStart;
                for (i = 0; i < radiusPlus1; i++) {
                    stack.r = pr;
                    stack.g = pg;
                    stack.b = pb;
                    stack.a = pa;
                    stack = stack.next
                }
                yp = width;
                for (i = 1; i <= radius; i++) {
                    yi = (yp + x) << 2;
                    r_sum += (stack.r = pr = imgData.data[yi]) * (rbs = radiusPlus1 - i);
                    g_sum += (stack.g = pg = imgData.data[yi + 1]) * rbs;
                    b_sum += (stack.b = pb = imgData.data[yi + 2]) * rbs;
                    a_sum += (stack.a = pa = imgData.data[yi + 3]) * rbs;
                    r_in_sum += pr;
                    g_in_sum += pg;
                    b_in_sum += pb;
                    a_in_sum += pa;
                    stack = stack.next;
                    if (i < heightMinus1) {
                        yp += width
                    }
                }
                yi = x;
                stackIn = stackStart;
                stackOut = stackEnd;
                for (y = 0; y < height; y++) {
                    p = yi << 2;
                    imgData.data[p + 3] = pa = (a_sum * mul_sum) >> shg_sum;
                    if (pa > 0) {
                        pa = 255 / pa;
                        imgData.data[p] = ((r_sum * mul_sum) >> shg_sum) * pa;
                        imgData.data[p + 1] = ((g_sum * mul_sum) >> shg_sum) * pa;
                        imgData.data[p + 2] = ((b_sum * mul_sum) >> shg_sum) * pa
                    } else {
                        imgData.data[p] = imgData.data[p + 1] = imgData.data[p + 2] = 0
                    }
                    r_sum -= r_out_sum;
                    g_sum -= g_out_sum;
                    b_sum -= b_out_sum;
                    a_sum -= a_out_sum;
                    r_out_sum -= stackIn.r;
                    g_out_sum -= stackIn.g;
                    b_out_sum -= stackIn.b;
                    a_out_sum -= stackIn.a;
                    p = (x + ((p = y + radiusPlus1) < heightMinus1 ? p : heightMinus1) * width) << 2;
                    r_sum += r_in_sum += stackIn.r = imgData.data[p];
                    g_sum += g_in_sum += stackIn.g = imgData.data[p + 1];
                    b_sum += b_in_sum += stackIn.b = imgData.data[p + 2];
                    a_sum += a_in_sum += stackIn.a = imgData.data[p + 3];
                    stackIn = stackIn.next;
                    r_out_sum += pr = stackOut.r;
                    g_out_sum += pg = stackOut.g;
                    b_out_sum += pb = stackOut.b;
                    a_out_sum += pa = stackOut.a;
                    r_in_sum -= pr;
                    g_in_sum -= pg;
                    b_in_sum -= pb;
                    a_in_sum -= pa;
                    stackOut = stackOut.next;
                    yi += width
                }
            }
            contextEfeitos.putImageData(imgData, 0, 0);
            $("#txtEfeitos" + efeito).text("Blur");
            break;
        case 15:
            claretonGradient(contextEfeitos, imgData.width, imgData.height);
            var dataEfeitos = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(dataEfeitos, {
                contrast: 30,
                brightness: -30
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Clarendon");
            break;
        case 16:
            moonGradient(contextEfeitos, imgData.width, imgData.height);
            var dataEfeitos = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            dataEfeitos = grayscale(contextEfeitos, dataEfeitos);
            var colorCorrected = colorMatrix(dataEfeitos, {
                contrast: 70,
                brightness: -46
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Moon");
            break;
        case 17:
            contextEfeitos.putImageData(imgData, 0, 0);
            var gradient = toasterGradient(imgData.width, imgData.height);
            var screen = blends(contextEfeitos, gradient, imgData.width, imgData.height, function(bottomPixel, topPixel) {
                return 255 - (255 - topPixel) * (255 - bottomPixel) / 255
            })
            var colorCorrected = colorMatrix(screen, {
                contrast: 30,
                brightness: -30
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Toaster");
            break;
        case 18:
            contextEfeitos.putImageData(imgData, 0, 0);
            var gradient = gradientSimples(imgData.width, imgData.height, '#21253f');
            var screen = blends(contextEfeitos, gradient, imgData.width, imgData.height, function(bottomPixel, topPixel) {
                return 255 - (255 - topPixel) * (255 - bottomPixel) / 255
            })
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: -5
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Lark");
            break;
        case 19:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#efcdad', 0.2);
            $("#txtEfeitos" + efeito).text("Reyes");
            break;
        case 20:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#a8dfc1', 0.2);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: 0
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Brooklyn");
            break;
        case 21:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#f36abc', 0.3);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: -5
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("1997");
            break;
        case 22:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#420a0e', 0.1);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: 20
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Adan");
            break;
        case 23:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#9b1c9b', 0.2);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 30,
                brightness: -10
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Brannan");
            break;
        case 24:
            contextEfeitos.putImageData(imgData, 0, 0);
            var cors = [];
            cors = ["#d0ba8e", "#360309", "#1d0210"];
            threeColorGradient(contextEfeitos, imgData.width, imgData.height, 0.3, cors);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 30,
                brightness: -10
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Earlybird");
            break;
        case 25:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#e6e6fa', 0.2);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 30,
                brightness: 0
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Gingham");
            break;
        case 26:
            contextEfeitos.putImageData(imgData, 0, 0);
            var cors = [];
            cors = ["#a6b1ff", "#342134"];
            twoColorGradient(contextEfeitos, imgData.width, imgData.height, 0.2, cors);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 30,
                brightness: 10
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Hudson");
            break;
        case 27:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#b77d21', 0.3);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 45,
                brightness: -15
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("kelvin");
            break;
        case 28:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, "#222222", 0.1);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 50,
                brightness: -12
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Lo-Fi");
            break;
        case 29:
            contextEfeitos.putImageData(imgData, 0, 0);
            var cors = [];
            cors = ["#ffc8c8", "#111111", "#111111"];
            threeColorGradient(contextEfeitos, imgData.width, imgData.height, 0.1, cors);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 5,
                brightness: -10
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Mayfair");
            break;
        case 30:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, "#004696", 0.3);
            fillSimple(contextEfeitos, imgData.width, imgData.height, "#f7b099", 0.1);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 25,
                brightness: -15
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Nashville");
            break;
        case 31:
            contextEfeitos.putImageData(imgData, 0, 0);
            var cors = [];
            cors = ["#005b9a", "#e6c13d"];
            twoColorGradientLinear(contextEfeitos, imgData.width, imgData.height, 0.2, cors);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 0,
                brightness: -10
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Perpetua");
            break;
        case 32:
            contextEfeitos.putImageData(imgData, 0, 0);
            var cors = [];
            cors = ["#eccda9", "#321e07"];
            twoColorGradient(contextEfeitos, imgData.width, imgData.height, 0.2, cors);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: 0
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Rise");
            break;
        case 33:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, "#45290c", 0.2);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 0,
                brightness: 0
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Slumber");
            break;
        case 34:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#efcdad', 0.2);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: -5,
                brightness: 0
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Stinson");
            break;
        case 35:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#3a0339', 0.2);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: 10
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Valencia");
            break;
        case 36:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#0044cc', 0.15);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: 20
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Walden");
            break;
        case 37:
            contextEfeitos.putImageData(imgData, 0, 0);
            fillSimple(contextEfeitos, imgData.width, imgData.height, '#d8cdcb', 0.2);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 10,
                brightness: -35
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("Willow");
            break;
        case 38:
            contextEfeitos.putImageData(imgData, 0, 0);
            var cors = [];
            cors = ["#e6e7e0", "#2b2aa1"];
            twoColorGradient(contextEfeitos, imgData.width, imgData.height, 0.3, cors);
            var screen = contextEfeitos.getImageData(0, 0, imgData.width, imgData.height);
            var colorCorrected = colorMatrix(screen, {
                contrast: 50,
                brightness: -50
            });
            contextEfeitos.putImageData(colorCorrected, 0, 0);
            $("#txtEfeitos" + efeito).text("X-pro II");
            break;
        default:
    }
}

function gradientSimples(width, height, cor) {
    var texture = document.createElement('canvas');
    var ctx = texture.getContext('2d');
    texture.width = width;
    texture.height = height;
    var gradient = ctx.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, width * 0.6);
    gradient.addColorStop(0, cor);
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, width, height);
    return ctx
}

function fillSimple(contexto, width, height, cor, porcentagem) {
    contexto.save();
    contexto.globalAlpha = porcentagem;
    contexto.fillStyle = cor;
    contexto.fillRect(0, 0, width, height);
    contexto.restore();
    return contexto
}

function twoColorGradientLinear(contexto, width, height, porcentagem, cors) {
    contexto.save();
    contexto.globalAlpha = porcentagem;
    var gradient = contexto.createLinearGradient(0, height / 4, 0, height);
    gradient.addColorStop(0, cors[0]);
    gradient.addColorStop(1, cors[1]);
    contexto.fillStyle = gradient;
    contexto.fillRect(0, 0, width, height);
    contexto.restore()
}

function twoColorGradient(contexto, width, height, porcentagem, cors) {
    contexto.save();
    contexto.globalAlpha = porcentagem;
    var gradient = contexto.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, width * 0.6);
    gradient.addColorStop(0, cors[0]);
    gradient.addColorStop(1, cors[1]);
    contexto.fillStyle = gradient;
    contexto.fillRect(0, 0, width, height);
    contexto.restore()
}

function threeColorGradient(contexto, width, height, porcentagem, cors) {
    contexto.save();
    contexto.globalAlpha = porcentagem;
    var gradient = contexto.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, width * 0.6);
    gradient.addColorStop(0, cors[0]);
    gradient.addColorStop(1, cors[1]);
    gradient.addColorStop(1, cors[2]);
    contexto.fillStyle = gradient;
    contexto.fillRect(0, 0, width, height);
    contexto.restore()
}

function grayscale(contextEfeitos, dataEfeitos) {
    var imgData = contextEfeitos.getImageData(0, 0, dataEfeitos.width, dataEfeitos.height);
    for (y = 0; y < imgData.height; y++) {
        for (x = 0; x < imgData.width; x++) {
            var i = ((y * 4) * imgData.width) + (x * 4);
            var aveColor = parseInt((imgData.data[i] + imgData.data[i + 1] + imgData.data[i + 2]) / 3);
            imgData.data[i] = aveColor;
            imgData.data[i + 1] = aveColor;
            imgData.data[i + 2] = aveColor
        }
    }
    contextEfeitos.putImageData(imgData, 0, 0);
    return imgData
};

function blends(background, foreground, width, height, transform) {
    var bottom = background.getImageData(0, 0, width, height);
    var top = foreground.getImageData(0, 0, width, height);
    for (var i = 0, size = top.data.length; i < size; i += 4) {
        top.data[i + 0] = transform(bottom.data[i + 0], top.data[i + 0]);
        top.data[i + 1] = transform(bottom.data[i + 1], top.data[i + 1]);
        top.data[i + 2] = transform(bottom.data[i + 2], top.data[i + 2])
    }
    return top
}

function moonGradient(contexto, width, height) {
    contexto.save();
    contexto.globalAlpha = 0.5;
    contexto.fillStyle = "#a0a080";
    contexto.fillRect(0, 0, width, height);
    contexto.restore();
    return contexto
}

function claretonGradient(contexto, width, height) {
    var texture = document.createElement('canvas');
    var ctx = texture.getContext('2d');
    texture.width = width;
    texture.height = height;
    contexto.save();
    contexto.globalAlpha = 0.2;
    contexto.fillStyle = "#7fbbe3";
    contexto.fillRect(0, 0, width, height);
    contexto.restore();
    return contexto
}

function toasterGradient(width, height) {
    var texture = document.createElement('canvas');
    var ctx = texture.getContext('2d');
    texture.width = width;
    texture.height = height;
    var gradient = ctx.createRadialGradient(width / 2, height / 2, 0, width / 2, height / 2, width * 0.6);
    gradient.addColorStop(0, "#804e0f");
    gradient.addColorStop(1, "#3b003b");
    ctx.fillStyle = gradient;
    ctx.fillRect(0, 0, width, height);
    return ctx
}

$.getScript($("#caminhoFileUpload").val() + "/js/colormatrix.js");

function rgb2hsv(r, g, b) {
    var Hue = 0;
    var Sat = 0;
    var Val = 0;
    r = r / 255;
    g = g / 255;
    b = b / 255;
    var minRGB = Math.min(r, g, b);
    var maxRGB = Math.max(r, g, b);
    if (minRGB == maxRGB) {
        Val = parseInt((minRGB * 100) + .5);
        return [Hue, Sat, Val]
    }
    var d = (r == minRGB) ? g - b : ((b == minRGB) ? r - g : b - r);
    var h = (r == minRGB) ? 3 : ((b == minRGB) ? 1 : 5);
    Hue = parseInt(60 * (h - d / (maxRGB - minRGB)));
    Sat = parseInt((((maxRGB - minRGB) / maxRGB) * 100) + .5);
    Val = parseInt((maxRGB * 100) + .5);
    return [Hue, Sat, Val]
}

function hsv2rgb(h, s, v) {
    var r;
    var g;
    var b;
    s /= 100;
    v /= 100;
    if (s == 0) {
        v = Math.round(v * 255);
        return [v, v, v]
    }
    h /= 60;
    var i = Math.floor(h);
    var f = h - i;
    var p = v * (1 - s);
    var q = v * (1 - s * f);
    var t = v * (1 - s * (1 - f));
    switch (i) {
        case 0:
            r = v;
            g = t;
            b = p;
            break;
        case 1:
            r = q;
            g = v;
            b = p;
            break;
        case 2:
            r = p;
            g = v;
            b = t;
            break;
        case 3:
            r = p;
            g = q;
            b = v;
            break;
        case 4:
            r = t;
            g = p;
            b = v;
            break;
        default:
            r = v;
            g = p;
            b = q;
            break
    }
    return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)]
}

function makeTint(contextEfeitos, imgData, h, s, v) {
    if (imgData != "") {
        for (y = 0; y < imgData.height; y++) {
            for (x = 0; x < imgData.width; x++) {
                var i = ((y * imgData.width) + x) * 4;
                var aveColor = parseInt((imgData.data[i] + imgData.data[i + 1] + imgData.data[i + 2]) / 3)
                var hsv = rgb2hsv(aveColor, aveColor, aveColor);
                var tint = hsv2rgb(hsv[0] + h, hsv[1] + s, hsv[2] + v);
                imgData.data[i] = tint[0];
                imgData.data[i + 1] = tint[1];
                imgData.data[i + 2] = tint[2]
            }
        }
        contextEfeitos.putImageData(imgData, 0, 0)
    }
}

function retornaCanvasCrop(context) {
    context.putImageData(globalCanvasCropImageData, 0, 0)
}

$("#boxEfeitosCanvas").on("click", ".efeitos", function(e) {
    $(".eativo").removeClass("eativo");
    var boxdiv = $(this).closest(".boxEfeitos").find(".txtEfeitos");
    $(boxdiv).addClass("eativo");
    var urlImagem = $("#cropPhotobook").attr("data-url");
    var efeito = parseInt($(this).attr("data-efeito"));
    var canvasCrop = $("#cropPhotobook")[0];
    var context = canvasCrop.getContext("2d");
    retornaCanvasCrop(context);
    $("#cropPhotobook").attr("data-efeito", efeito);
    var imgData = context.getImageData(0, 0, canvasCrop.width, canvasCrop.height);
    gerarEfeitos(imgData, context, efeito);
    globalCanvasImageDataEfeitoBarras = context.getImageData(0, 0, canvasCrop.width, canvasCrop.height);
    $(".efeitosBarrasBCSM").trigger('change')
});

function construtorCanvasCrop(urlImgem, distanciaLateral, distanciaTopo, largura, altura, efeito, efeitosBarra, zoom) {
    $("#box_crop").contents().remove();
    var img = new Image();
    img.addEventListener('load', function() {
        var oWidth = this.width;
        var oHeight = this.height;
        var tamanhoImg = ($("#tamanhoImg").val()).split(",");
        if (oWidth < oHeight) {
            var dWidth = parseInt(tamanhoImg[0]);
            var dHeight = parseInt(tamanhoImg[1]);
            var prop = ((100 * dHeight) / oHeight) / 100
        } else {
            var dWidth = parseInt(tamanhoImg[1]);
            var dHeight = parseInt(tamanhoImg[0]);
            var prop = ((100 * dWidth) / oWidth) / 100
        }
        var novaWidth = Math.ceil(prop * oWidth);
        var novaHeight = Math.ceil(prop * oHeight);
        if ((novaWidth < dWidth) || (novaHeight < dHeight)) {
            if (oWidth < oHeight) {
                var dWidth = parseInt(tamanhoImg[0]);
                var dHeight = parseInt(tamanhoImg[1]);
                var prop = ((100 * dWidth) / oWidth) / 100
            } else {
                var dWidth = parseInt(tamanhoImg[1]);
                var dHeight = parseInt(tamanhoImg[0]);
                var prop = ((100 * dHeight) / oHeight) / 100
            }
            var novaWidth = Math.ceil(prop * oWidth);
            var novaHeight = Math.ceil(prop * oHeight)
        }
        if (novaWidth < dWidth) {
            novaWidth = dWidth
        }
        if (novaHeight < dHeight) {
            novaHeight = dHeight
        }
        var meuY = Math.abs((novaHeight - dHeight) / 2);
        var meuW = Math.abs((novaWidth - dWidth) / 2);
        var canvas = document.createElement('canvas'),
            ctx = canvas.getContext('2d')
        canvas.width = novaWidth;
        canvas.height = novaHeight;
        canvas.setAttribute("id", "cropPhotobook");
        canvas.setAttribute("data-url", urlImgem);
        canvas.setAttribute("data-efeito", efeito);
        canvas.setAttribute("data-scala", zoom);
        ctx.drawImage(this, 0, 0, novaWidth, novaHeight);
        globalCanvasCropImageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
        setTimeout(function() {
            if (efeito > 0) {
                var dataImgE = ctx.getImageData(0, 0, canvas.width, canvas.height);
                gerarEfeitos(dataImgE, ctx, parseInt(efeito));
                if ($(".eativo").length) {
                    $(".eativo").removeClass("eativo")
                }
                $("#txtEfeitos" + efeito).addClass("eativo")
            }
            globalCanvasImageDataEfeitoBarras = ctx.getImageData(0, 0, canvas.width, canvas.height);
            var efeitosB = efeitosBarra.split(',');
            var rangerBrilho = efeitosB[1];
            var rangerContraste = efeitosB[2];
            var rangerSaturacao = efeitosB[3];
            var rangerMatiz = efeitosB[4];
            gerarEfeitosBarras(canvas, zoom, rangerBrilho, rangerContraste, rangerSaturacao, rangerMatiz)
        }, 100);
        $("#box_crop").html(canvas);
        $("#box_crop").css("width", $("#cropPhotobook").attr("width"));
        if (largura > 0 && altura > 0) {
            constroiCrop(distanciaLateral, distanciaTopo, largura, altura)
        } else {
            constroiCrop(meuW, meuY, dWidth + meuW, dHeight + meuY)
        }
        $("#loadOverlay").fadeOut()
    }, !1);
    img.src = urlImgem + "?_=" + (new Date().getTime());
    setTimeout(function() {
        var img = new Image();
        img.addEventListener('load', function() {
            var imageObj = $("#cropPhotobook")[0];
            for (var totalMineCanvasEfeito = 1; totalMineCanvasEfeito <= 38; totalMineCanvasEfeito++) {
                var arrayEfeitosNaoExibir = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];
                if ($.inArray(totalMineCanvasEfeito, arrayEfeitosNaoExibir) == -1) {
                    var canvasEfeitos = document.createElement('canvas'),
                        contextEfeitos = canvasEfeitos.getContext('2d');
                    var oWidth = this.width;
                    var oHeight = this.height;
                    if (oWidth < oHeight) {
                        var dWidth = 80;
                        var dHeight = 100;
                        var prop = ((100 * dHeight) / oHeight) / 100
                    } else {
                        var dWidth = 100;
                        var dHeight = 80;
                        var prop = ((100 * dWidth) / oWidth) / 100
                    }
                    var novaWidthCanvasEfeito = parseInt(prop * oWidth);
                    var novaHeightCanvasEfeito = parseInt(prop * oHeight);
                    canvasEfeitos.width = novaWidthCanvasEfeito;
                    canvasEfeitos.height = novaHeightCanvasEfeito;
                    canvasEfeitos.setAttribute("id", "canvasEfeito" + totalMineCanvasEfeito);
                    canvasEfeitos.setAttribute("data-efeito", totalMineCanvasEfeito);
                    canvasEfeitos.setAttribute("class", "efeitos");
                    contextEfeitos.drawImage(this, 0, 0, canvasEfeitos.width, canvasEfeitos.height);
                    $(".boxE" + totalMineCanvasEfeito).prepend(canvasEfeitos);
                    var imgData = contextEfeitos.getImageData(0, 0, canvasEfeitos.width, canvasEfeitos.height);
                    if (totalMineCanvasEfeito != 1) {
                        gerarEfeitos(imgData, contextEfeitos, totalMineCanvasEfeito)
                    } else {
                        $("#txtEfeitos1").text("Limpar Ajustes")
                    }
                } else {
                    $(".boxE" + totalMineCanvasEfeito).css("display", "none")
                }
            };
            if (!$('#boxEfeitosCanvas').hasClass("jspScrollable")) {
                setTimeout(function() {
                    $('#boxEfeitosCanvas').jScrollPane()
                }, 100)
            } else {
                setTimeout(function() {
                    var pane = $('#boxEfeitosCanvas');
                    pane.jScrollPane();
                    var api = pane.data('jsp');
                    api.reinitialise()
                }, 100)
            }
        }, !1);
        img.src = urlImgem + "?_=" + (new Date().getTime())
    }, 100)
}

function GerarImagemCropBase(img, urlImgem) 
{
    var oWidth = img.width;
    var oHeight = img.height;
    var prop = 1;
    var tamanhoImg = ($("#tamanhoImg").val()).split(",");
    if (oWidth < oHeight) {
        var dWidth = parseInt(tamanhoImg[0]);
        var dHeight = parseInt(tamanhoImg[1]);
        var prop = ((100 * dHeight) / oHeight) / 100
    } else {
        var dWidth = parseInt(tamanhoImg[1]);
        var dHeight = parseInt(tamanhoImg[0]);
        var prop = ((100 * dWidth) / oWidth) / 100
    }
    var novaWidth = Math.ceil(prop * oWidth);
    var novaHeight = Math.ceil(prop * oHeight);
    if ((novaWidth < dWidth) || (novaHeight < dHeight)) {
        if (oWidth < oHeight) {
            var dWidth = parseInt(tamanhoImg[0]);
            var dHeight = parseInt(tamanhoImg[1]);
            var prop = ((100 * dWidth) / oWidth) / 100
        } else {
            var dWidth = parseInt(tamanhoImg[1]);
            var dHeight = parseInt(tamanhoImg[0]);
            var prop = ((100 * dHeight) / oHeight) / 100
        }
        var novaWidth = Math.ceil(prop * oWidth);
        var novaHeight = Math.ceil(prop * oHeight)
    }
    if (novaWidth < dWidth) {
        novaWidth = dWidth
    }
    if (novaHeight < dHeight) {
        novaHeight = dHeight
    }
    var meuY = Math.abs((novaHeight - dHeight) / 2);
    var meuW = Math.abs((novaWidth - dWidth) / 2);
    var canvas = document.createElement('canvas');
    var ctx = canvas.getContext('2d');
    canvas.width = dWidth;
    canvas.height = dHeight;
    canvas.className = "imgsPhotobook";
    canvas.setAttribute("id", "cropPhotobook");
    canvas.setAttribute("data-url", urlImgem);
    canvas.setAttribute("data-efeito", 0);
    ctx.drawImage(img, -(meuW), -(meuY), novaWidth, novaHeight);
    var dataURL = canvas.toDataURL("image/png");
    var largura = novaWidth;
    var altura = novaHeight;
    var oWidth = img.width;
    var oHeight = img.height;
    if (oWidth < oHeight) {
        var mWidth = 94;
        var mHeight = 132;
        var classe = "imgsPhotobookHeight imgsPhotobook"
    } else {
        var mWidth = 132;
        var mHeight = 94;
        var classe = "imgsPhotobookWidth imgsPhotobook"
    }
    var div1 = document.createElement('div');
    div1.className = "boxMasterImg";
    var div2 = document.createElement('div');
    div2.className = "boxImgs";
    var canvasMine = document.createElement('canvas');
    var ctxMine = canvasMine.getContext('2d');
    canvasMine.width = mWidth;
    canvasMine.height = mHeight;
    canvasMine.className = classe;
    canvasMine.setAttribute("data-url", decodeURIComponent(decodeURI(urlImgem)));
    canvasMine.setAttribute("canvasW", largura);
    canvasMine.setAttribute("canvasH", altura);
    canvasMine.setAttribute("x1", 0);
    canvasMine.setAttribute("x2", 0);
    canvasMine.setAttribute("y1", 0);
    canvasMine.setAttribute("y2", 0);
    canvasMine.setAttribute("w", 0);
    canvasMine.setAttribute("h", 0);
    canvasMine.setAttribute("id", "cv" + ($(".imgsPhotobook").length + 1));
    canvasMine.setAttribute("data-barraEfeitos", "0,0,0,0,0");
    canvasMine.setAttribute("data-borda", 0);
    canvasMine.setAttribute("data-zoom", 1.00 + "," + 1.00);
    ctxMine.drawImage(canvas, 0, 0, mWidth, mHeight);
    $("#template-download").append(div1);
    $(div2).append(canvasMine);
    $(div1).append(div2);
    $(div1).append("<div class='btnAcoes'><i class='fa fa-pencil-square-o rg openImgsPhotobook' aria-hidden='true'></i><i class='fa fa-files-o rg duplicarImgsPhotobook' aria-hidden='true'></i><i class='fa fa-repeat rg rotateImgsPhotobook' aria-hidden='true'></i><i class='fa fa-trash-o rf closeImgsPhotobook' aria-hidden='true'></i></div>");
    $(canvasMine).fadeIn('slow');
    $("#proximaEtapa").attr("disabled", !0);
    $.ajax({
        type: "POST",
        url: "/loja/fotoprodutos/salvarfoto/",
        async: !1,
        data: {
            imgBase64: dataURL,
            caminho: decodeURIComponent(decodeURI(urlImgem)),
            x1: 0,
            x2: (dWidth + meuW),
            y1: 0,
            y2: (dHeight + meuY),
            w: dWidth,
            h: dHeight
        }
    }).done(function(o) {
        $("#proximaEtapa").removeAttr("disabled")
    });
    $(canvas).remove();
    $(ctx).remove();
    $(img).remove();
    return !0
}

function GerarCanvasBaseEfeitos(urlImgem, ObjEfeitos, contador) 
{
    var urlImg = urlImgem.replace("originais/", "");
    var img = new Image();
    img.addEventListener('load', function() {
        var oWidth = this.width;
        var oHeight = this.height;
        if (oWidth < oHeight) {
            var mWidth = 94;
            var mHeight = 132;
            var classe = "imgsPhotobookHeight imgsPhotobook"
        } else {
            var mWidth = 132;
            var mHeight = 94;
            var classe = "imgsPhotobookWidth imgsPhotobook"
        }
        var div1 = document.createElement('div');
        div1.className = "boxMasterImg";
        var div2 = document.createElement('div');
        div2.className = "boxImgs";
        var canvasMine = document.createElement('canvas');
        var ctxMine = canvasMine.getContext('2d');
        canvasMine.width = mWidth;
        canvasMine.height = mHeight;
        canvasMine.className = classe;
        canvasMine.setAttribute("data-url", ObjEfeitos[0].dataUrl);
        canvasMine.setAttribute("canvasW", ObjEfeitos[0].canvasw);
        canvasMine.setAttribute("canvasH", ObjEfeitos[0].canvash);
        canvasMine.setAttribute("x1", ObjEfeitos[0].x1);
        canvasMine.setAttribute("x2", ObjEfeitos[0].x2);
        canvasMine.setAttribute("y1", ObjEfeitos[0].y1);
        canvasMine.setAttribute("y2", ObjEfeitos[0].y2);
        canvasMine.setAttribute("w", ObjEfeitos[0].w);
        canvasMine.setAttribute("h", ObjEfeitos[0].h);
        canvasMine.setAttribute("data-barraEfeitos", ObjEfeitos[0].dataBarraefeitos);
        canvasMine.setAttribute("data-borda", ObjEfeitos[0].dataBorda);
        canvasMine.setAttribute("data-zoom", ObjEfeitos[0].zoom);
        if (ObjEfeitos[0].rotate > 0) {
            canvasMine.setAttribute("rotate", ObjEfeitos[0].rotate)
        }
        if (ObjEfeitos[0].dataEfeito != undefined) {
            canvasMine.setAttribute("data-efeito", ObjEfeitos[0].dataEfeito)
        }
        ctxMine.drawImage(this, 0, 0, mWidth, mHeight);
        $("#template-download").append(div1);
        $(div1).append(div2);
        $(div2).append(canvasMine);
        $(div1).append("<div class='btnAcoes'><i class='fa fa-pencil-square-o rg openImgsPhotobook' aria-hidden='true'></i><i class='fa fa-files-o rg duplicarImgsPhotobook' aria-hidden='true'></i><i class='fa fa-repeat rg rotateImgsPhotobook' aria-hidden='true'></i><i class='fa fa-trash-o rf closeImgsPhotobook' aria-hidden='true'></i></div>");
        $(canvasMine).fadeIn('slow');
        if (!contador) {
            $("#loadOverlay").fadeOut()
        }
    }, !1);
    img.src = urlImg + "?_=" + (new Date().getTime());
    return !0
}

function constroiCrop(distanciaLateral, distanciaTopo, largura, altura) 
{
    setTimeout(function() {
        $('#cropPhotobook').Jcrop({
            onChange: updatePreview,
            onSelect: updatePreview,
            allowSelect: !1,
            allowMove: !0,
            setSelect: [distanciaLateral, altura, largura, distanciaTopo],
            allowResize: !1,
            aspectRatio: 0
        })
    }, 200)
}

function updatePreview(coords) 
{
    $('#x1').val(coords.x);
    $('#y1').val(coords.y);
    $('#x2').val(coords.x2);
    $('#y2').val(coords.y2);
    $('#w').val(coords.w);
    $('#h').val(coords.h)
}

function preencheSerializado(salvar) 
{
    $("#removeTodosEfeitos").css("display", "block");
    var obj = [];
    $(".imgsPhotobook").each(function() {
        obj.push({
            dataUrl: $(this).attr("data-url"),
            canvasw: $(this).attr("canvasw"),
            canvash: $(this).attr("canvash"),
            x1: $(this).attr("x1"),
            x2: $(this).attr("x2"),
            y1: $(this).attr("y1"),
            y2: $(this).attr("y2"),
            w: $(this).attr("w"),
            h: $(this).attr("h"),
            dataBarraefeitos: $(this).attr("data-barraefeitos"),
            dataBorda: $(this).attr("data-borda"),
            dataEfeito: $(this).attr("data-efeito"),
            rotate: $(this).attr("rotate"),
            zoom: $(this).attr("data-zoom")
        })
    });
    $("#canvasSerializado").val(JSON.stringify(obj));
    if (parseInt(salvar)) {
        $.ajax({
            type: "POST",
            url: "/loja/fotoprodutos/salvarEfeitos/",
            data: {
                efeitos: JSON.stringify(obj),
                dataPasta: $(".fileupload").attr("data-date"),
                idPasta: $(".fileupload").attr("data-idguid")
            }
        }).done(function(e) {})
    }
}

function buscaAlbunsFacebook(paginaAlbuns, paginaFotos) 
{
    $('#container-fb-imagem').html("");
    $('#paginacao').hide();
    $('#myModalFBImagem').modal('show');
    $("#loadOverlay").fadeIn();
    var url = "/loja/apiFacebook/buscarAlbunsFotosJson";
    var totalAlbuns = localStorage.getItem("totalAlbuns");
    if (totalAlbuns == null) {
        totalAlbuns = 0
    }
    if (paginaAlbuns == 'undefined' || paginaAlbuns == '' || paginaAlbuns == null) {
        paginaAlbuns = 0
    }
    if (paginaFotos == 'undefined' || paginaFotos == '' || paginaFotos == null) {
        paginaFotos = 0
    }
    $.ajax({
        url: url,
        type: "POST",
        async: !0,
        dataType: 'json',
        data: {
            paginaAlbuns: paginaAlbuns,
            paginaFotos: paginaFotos,
            totalAlbuns: totalAlbuns
        },
        success: function(data) {
            if (data != "") {
                if (data.code != 190 && data.code != 2500) {
                    $("#loadOverlay").fadeOut();
                    var fotosAlbuns = JSON.stringify(data.fotosAlbuns);
                    localStorage.setItem("fotosAlbuns", fotosAlbuns);
                    var paginacaoFotos = JSON.stringify(data.paginacaoFotos);
                    localStorage.setItem("paginacaoFotos", paginacaoFotos);
                    localStorage.setItem("totalAlbuns", data.totalAlbuns);
                    if (data.paginacao != "" && data.paginacao != undefined) {
                        $('#paginacao').html(data.paginacao);
                        $('#paginacao').show()
                    }
                    $('[data-toggle="tooltip"]').tooltip();
                    $('body').attr('style', '');
                    var imagens = ArtesImgFacebook(data)
                } else {
                    $("#myModalFBImagem").modal('hide');
                    tentativaPublicacao++;
                    if (tentativaPublicacao < 10) {
                        FB.getLoginStatus(function(response) {
                            if (response.status !== 'connected') {
                                FB.login(function(response2) {
                                    RegistraTokenUsuario(response2.authResponse)
                                }, {
                                    scope: permissoesFacebook
                                })
                            } else {
                                FB.logout(function(response3) {});
                                FB.login(function(response2) {
                                    RegistraTokenUsuario(response2.authResponse);
                                    listAlbunsFacebook()
                                }, {
                                    scope: permissoesFacebook
                                })
                            }
                        })
                    }
                }
            }
        },
        error: function() {
            $('#myModalFBImagem').unblock();
            alert('Ocorreu um erro ao buscar os albuns do Facebook.')
        }
    })
}

function RegistraTokenUsuario(response) 
{
    $.post("/loja/ApiFacebook/RegistraTokenUsuario", {
        dataUserFB: response
    }, function(data) {}, 'json').fail(function() {})
}

function inicializaLocalStorageFacebook() 
{
    localStorage.setItem("fotosAlbuns", null);
    localStorage.setItem("totalAlbuns", 0);
    localStorage.setItem("paginacaoFotos", null)
}

function ArtesImgFacebook(dados) 
{
    $.post(link_rais_url + "loja/templates/templateImagesFacebook.php", {
        albuns: dados.capasAlbuns
    }, function(data) {
        $('#container-fb-imagem').html(data)
    })
}

function listAlbunsGoogle()
{
    $.ajax({
        url : "/loja/apiGoogle/oAuth",
        type: "POST",
        async: !0,
        dataType : 'json',
        data : {},
        success : function(token) {
            alert(token);
        }
    })
}



function listAlbunsFacebook() 
{
    inicializaLocalStorageFacebook();
    $.ajax({
        url: "/loja/apiFacebook/buscarAppIdJson",
        type: "POST",
        async: !0,
        dataType: 'json',
        data: {},
        success: function(appId) {
            if (appId != "") 
            {
                FB.init({
                    appId: appId,
                    cookie: !0,
                    xfbml: !0,
                    oauth: !0,
                    version: 'v2.10'
                });
                FB.getLoginStatus(function(response) {
                    if (response.status !== 'connected') {
                        FB.login(function(response2) {
                            RegistraTokenUsuario(response2.authResponse);
                            buscaAlbunsFacebook(0, 0)
                        }, {
                            scope: permissoesFacebook
                        })
                    } else {
                        buscaAlbunsFacebook(0, 0)
                    }
                })
            }
        },
        error: function() {
            alert('Ocorreu um erro ao buscar o App ID.')
        }
    })
}

function carregaFotosAlbumFacebook(idAlbum, nome) 
{
    var dados = localStorage.getItem("fotosAlbuns");
    var fotosAlbuns = JSON.parse(dados);
    var dadosPaginacao = localStorage.getItem("paginacaoFotos");
    var paginacaoFotos = JSON.parse(dadosPaginacao);
    fotosAlbuns = fotosAlbuns[idAlbum];
    divFoto = '';
    for (var i = 0; i < fotosAlbuns.length; i++) {
        var idFoto = fotosAlbuns[i].idFoto;
        var urlImagem = fotosAlbuns[i].imagem;
        var urlThumbnail = fotosAlbuns[i].thumbnail;
        divFoto += '<div class="container-image-fb">';
        divFoto += '    <a id="' + idFoto + '" class="img-thumbnail thumb-instagram" onclick="adicionaFotoNaLista(\'' + urlImagem + '\');" data-toggle="tooltip" title="Usar esta imagem!" >';
        divFoto += '        <img class="img_thumb" src="' + urlThumbnail + '" alt="Foto" width="80%" />';
        divFoto += '    </a>';
        divFoto += '</div>'
    };
    $('#fotosAlbunsFB').html(divFoto);
    $('#albunsFB').hide();
    $('#paginacao').hide();
    $('#tituloModalFotosFB').html('Albúm: ' + nome);
    $('#idAlbum').val(idAlbum);
    $('#btnVoltarAlbuns').show();
    $('#fotosAlbunsFB').show();
    $('#paginacaoFotos').html(paginacaoFotos[idAlbum].paginacao);
    $('#paginacaoFotos').show()
}

function voltarAlbuns() 
{
    $('#paginacaoFotos').hide();
    $('#paginacaoFotos').html('');
    $('#fotosAlbunsFB').hide();
    $('#btnVoltarAlbuns').hide();
    $('#idAlbum').val('');
    $('#tituloModalFotosFB').html('Escolha um albúm e defina a imagem.');
    $('#paginacao').show();
    $('#albunsFB').show();
    $('#fotosAlbunsFB').html('')
}

/*
 * ATENÇÃO!!! : qualquer erro gerado nesta função, impacta no arquivo criado no diretório. 
 * Sempre que der erro, validar se não foi criado um arquivo no diretório com 0 kb;
 **/
function gravarFotoGoogle(urlImagem) 
{

 
    var dataArquivo = $('.fileupload').attr('data-date');
    var idCliente = $('.fileupload').attr('data-id');
    var idGuid = $('.fileupload').attr('data-idguid');

    $.post('/loja/apiGoogle/salvarImagemGoogle', {
            'urlImagem': urlImagem,
            'idGuid': idGuid,
            'dataArquivo': dataArquivo
        },
        function(data) {

            listaDeFotos = [];
            $("#template-download").contents().remove();

                $("#myModalINSTAImagem").modal('hide');
                $("#myModalFBImagem").modal('hide');
                $("#modal-google").modal('hide');
        },
        function(error) {
            alert("Falha ao subir imagens");
            listaDeFotos = [];
        },
        'json');
}

/*
 * ATENÇÃO!!! : qualquer erro gerado nesta função, impacta no arquivo criado no diretório. 
 * Sempre que der erro, validar se não foi criado um arquivo no diretório com 0 kb;
 **/
function gravarFotoFacebook(urlImagem, instagram) {

    if (instagram == undefined) instagram = !1;

    var dataArquivo = $('.fileupload').attr('data-date');
    var idCliente = $('.fileupload').attr('data-id');
    var idGuid = $('.fileupload').attr('data-idguid');

    $.post('/loja/apiFacebook/enviarImagemFacebook', {
            'urlImagem': urlImagem,
            'idGuid': idGuid,
            'dataArquivo': dataArquivo
        },
        function(data) {

            listaDeFotos = [];
            $("#template-download").contents().remove();

                $("#myModalINSTAImagem").modal('hide');
                $("#myModalFBImagem").modal('hide');
                $("#modal-google").modal('hide');
        },
        function(error) {
            alert("Falha ao subir imagens");
            listaDeFotos = [];
        },
        'json');
}

/**
 * Author: Adão Dias - 01/12/2017
 * email : adahox@gmail.com
 **/
function adicionaFotoNaLista(url, instagram) {
    /** transformo em string pra ser identificado pelo indexOf()
    * inicialmente, a URL vem com parametros maxResults&spaces. então remover
    **/
    url = url.split("&spaces");

    obj = JSON.stringify({
        "image": url[0],
        "insta": instagram
    });

    result = listaDeFotos.indexOf(obj);
    if (result > -1)
        listaDeFotos.splice(listaDeFotos.indexOf(obj), 1)
    else
        listaDeFotos.push(obj);

    /** Caso a lista de fotos esteja vazia, então desativamos o botão enviar.
        motivo: estava causando erros se clicasse no botão com array vazio **/
    if(listaDeFotos.length == 0)
        $(".btnConfirmar").addClass("disabled");
    else
        $(".btnConfirmar").removeClass("disabled"); 


    /*
     *  a modal por padrão retorna o evento 'CLICK' 2X. (algum bug do jquery ou bootstrap);
     *  o método one() evita isso. 
     */
    $(document).one('click', '.thumb-instagram', function(e) {

        var i = document.createElement('i');

        i.classList.add("fa");
        i.classList.add("fa-check-circle");
        i.classList.add("fa-3x");
        i.classList.add("photo-checked");
        i.classList.add("instagram_id_check");

        i.style.cssText = "z-index:900; height: 38px; width: 36px; padding: 0px; color: green; position: absolute; float:left; background-color: white; border-radius: 189px; margin: -14px; border: 0px;";

        if ($(this).hasClass("photo-checked")) {
            $(this).find("i.instagram_id_check").remove();
            $(this).removeClass("photo-checked");
            $(this).css('border', '1px solid white');
            $(this).find('img.img_thumb').css('opacity', '100');
        } else {
            $(this).addClass("photo-checked");
            $(this).prepend(i);
            $(this).css('border', '1px solid green');
            $(this).find('img.img_thumb').css('opacity', '0.5');
        }
    });
}



/**
 * Author: Adão Dias - 01/12/2017
 * email : adahox@gmail.com
 **/
function confirmarFotos(redeSocial) {
    $("#loadOverlay").fadeIn();
    /*
     * Criamos uma promessa porque devemos esperar todas as imagens serem enviadas para só depois aplicar o resetInit();
     **/
    var envio = new Promise(function(resolve, reject) {

        /* caso o upload da foto seja pelo instagram ou facebook*/
            listaDeFotos.forEach(function(item, index, arr) {
                var item = JSON.parse(item);

                if(redeSocial == "Facebook" || redeSocial == "Instagram")
                {
                    gravarFotoFacebook(item.image, item.insta);
                    if (index === arr.length - 1) {
                        resolve(true);
                    }                    
                }
                
                if(redeSocial == "Google")
                {
                    gravarFotoGoogle(item.image);
                    if (index === arr.length - 1) {
                        resolve(true);
                    }                       
                }

            });            

        listaDeFotos = [];
        /** desativamos o botão para não clicar com o array vazio e dar erros. **/
        $(".btnConfirmar").addClass("disabled");
        /** limpamos para não poder ficar salvando e guardando lixo. **/
        localStorage.removeItem('listBackTo');

    });

    envio.then(function(value) {
        if (value) //true 
        {
            $("#template-download").empty();
            $('#myModalFBImagem').modal('hide');
            $('#myModalINSTAImagem').modal('hide');
            $('#modal-google').modal('hide');
            resetInit();
        }
    });
}

function ArtesImgInstagram(code) {
    $("#loadOverlay").fadeIn();
    $('#container-insta-imagem').html("");
    $('#myModalINSTAImagem').modal('show');
    $.post(link_rais_url + "loja/templates/templateImagesInstagram.php", {
        code: code
    }, function(data) {
        $('#container-insta-imagem').html(data);
        $("#loadOverlay").fadeOut()
    })
}
/**
* author: Adão Dias . adao.pereira@zapgrafica.com.br
* Ao percorrer pela paginação do google fotos, ele pode selecionar imagens e ir percorrendo as paginas,
* então preciso validar se essa imagens já estão marcadas e aplicar o estilo css de já selecionadas para não haver confusão.
**/
function validaImagensSelecionadas(obj)
{
    listaDeFotos.forEach(function(item, indice, arr){
        var item = JSON.parse(item);
        dataValidaClick = $(obj).attr("dataValidaClick");
        
        imagem = item.image.split("?");
 
       
        if(imagem[0] == dataValidaClick)
        {
            var i = document.createElement('i');
            i.classList.add("fa");
            i.classList.add("fa-check-circle");
            i.classList.add("fa-3x");
            i.classList.add("photo-checked");
            i.classList.add("instagram_id_check");
            i.style.cssText = "z-index:900; height: 38px; width: 36px; padding: 0px; color: green; position: absolute; float:left; background-color: white; border-radius: 189px; margin: -14px; border: 0px;";
            
            var div = $(obj).closest(); // busca o elemento pai da imagem para aplicar o icon
            $(div.context.parentNode).addClass("photo-checked");
            $(div.context.parentNode).prepend(i);
            $(obj).css('border', '1px solid green');
            $(obj).css('opacity', '0.5');           
        }
    });
}
/**
 *  DEPRECAATED - DOES NOT USE IT MORE 
 * author: Adão Dias . adao.pereira@zapgrafica.com.br
**/
function GoogleVoltarFoto() 
{

    var url = null, inicial = 'true';

    listaDePaginas = localStorage.getItem('listaPaginacaoGoogleFotos');
    listaDePaginas = JSON.parse(listaDePaginas);
    paginaIndiceGoogleFotos--;

    url = (paginaIndiceGoogleFotos > 1) ? listaDePaginas[ paginaIndiceGoogleFotos - 1 ] : listaDePaginas[0];

    /**  verificamos se estamos na pagina inicial para decidir se ocultamos ou não o obtão "VOLTAR" **/
    inicial = (paginaIndiceGoogleFotos == 1) ? 'true' : 'false';


    $('#container-google-imagem').html("");
    $("#loadOverlay").fadeIn();
    $.post(link_rais_url + "loja/templates/templateImagesGoogle.php", {
        pagina: url,
        inicial : inicial,
        paginaIndiceGoogleFotos : paginaIndiceGoogleFotos
    }, function(data) {
        $('#container-google-imagem').html(data);
        $("#loadOverlay").fadeOut();
    }); 
}


/**
* DEPRECAATED - DOES NOT USE IT MORE 
* author: Adão Dias . adao.pereira@zapgrafica.com.br
* param proximaPagina -> URL para a próxima lista de fotos.
* param paginaAnterior ->  URL para a pagina de fotos anterior.
* return : void
**/
function GoogleProximaFoto(proximaPagina, paginaAnterior)
{
  
    var url = null;
    var listaDePaginas = localStorage.getItem('listaPaginacaoGoogleFotos');

    paginaIndiceGoogleFotos++;

    if (listaDePaginas != undefined) 
        /** se a lista já estiver com dados, então acrescentamos mais uma URL **/
        listaDePaginas = JSON.parse(listaDePaginas);
    else
        /** criamos a lista e adicionamos o primeiro link **/
        listaDePaginas = Array();
    
    listaDePaginas.push(paginaAnterior);
    listaDePaginas = JSON.stringify(listaDePaginas);
    localStorage.setItem('listaPaginacaoGoogleFotos', listaDePaginas);

    url = proximaPagina;

    $('#container-google-imagem').html("");
    $("#loadOverlay").fadeIn();
    $.post(link_rais_url + "loja/templates/templateImagesGoogle.php", {
        pagina: url,
        inicial : 'false',
        paginaIndiceGoogleFotos : paginaIndiceGoogleFotos
    }, function(data) {
        $('#container-google-imagem').html(data);
        $("#loadOverlay").fadeOut();
    })  
}

/**
* author: Adão Dias . adao.pereira@zapgrafica.com.br
* valida o token do usuário recebido pelo oauth do google
**/
function validaGoogleoAuthToken(url) {
    var link = url.split("&");
    token = null;

    link.forEach(function(item, indice, arr)
    {   
        if(item.split("=")[0] == "access_token")
            token = item.split("=")[1];
    });


    $.ajax({
        url: 'https://www.googleapis.com/oauth2/v3/tokeninfo',
        dataType: 'json',
        method: 'POST',
        data : {
            access_token : token            
        },
        success : function(response)
        {
            /** limpamos a paginação para ela ser criada novamente. **/
            $("#paginacaoGoogle").html("");
            /** autenticação com sucesso, buscamos todas as paginas de fotos **/
            $.get(link_rais_url + "loja/templates/templateImagesGoogle.php", 
            { 
                paginacaoGoogleFotos : "https://www.googleapis.com/drive/v2/files?access_token=" + token + "&spaces=photos&maxResults=20",
                acesso : token
            }
            ).done(function( data ) {
                $("#loadOverlay").fadeIn();
                
                lista = JSON.parse(data);
                listaPag = lista.pop();

                dataSource  = Array();
                console.log(lista.length);
                console.log(lista);
                lista.forEach(function(item, index, arr)
                {
                    var img = document.createElement("img");
                    img.src = item.thumbnailLink;
                    $(img).addClass("img_thumb");
                    src = img.src;
                    $(img).attr("width", 150);
                    $(img).attr("height", 150);
                    var a_img = document.createElement("a");
                    a_img.href = "javascript:";
                    $(a_img).addClass("img-thumbnail");
                    $(a_img).addClass("thumb-instagram");
                    $(a_img).attr("onClick", "adicionaFotoNaLista('"+ item.downloadUrl + "&data_code=" + token + "');");
     
                    $(a_img).append(img);
                    dataSource.push(a_img.outerHTML);

                });

   

                $('#container-google-imagem').html("");

                doc = $('#container-google-imagem');
                pag = $("#paginacaoGoogle");

                $('#paginacaoGoogle').pagination({
                    dataSource: dataSource,
                    pageSize: 20,
                    callback: function(i, pagination) {
                        
                        dataHtml = '';

                        $.each(i, function (index, item) {
                            dataHtml += item ;
                        });

                        doc.html(dataHtml);
                        $("#paginacaoGoogle ul").addClass("pagination");
                        $("#loadOverlay").fadeOut();
                        $('#modal-google').modal('show');  
                    }
                });

                 //$("#paginacaoGoogle").append(ul);
            }); 

            /** começamos a buscar as fotos e mostrar na modal **/           

            // 
            // $.post(link_rais_url + "loja/templates/templateImagesGoogle.php", {
            //     code: token,
            //     inicial : 'true',
            //     paginaIndiceGoogleFotos : paginaIndiceGoogleFotos
            // }, function(data) {
            //     $('#container-google-imagem').html(data);
            //     $("#loadOverlay").fadeOut()
            // });          
        }
    });
}


/**
* author: Adão Dias . adao.pereira@zapgrafica.com.br
* param URL : recebe a url para fazer o request JS
* Busca as fotos do google pela paginação no footer da modal
**/
function buscaFotosDoGoogle(url)
{
    $("#loadOverlay").fadeIn();
    $('#container-google-imagem').html("");
    $('#modal-google').modal('show');  
    $.post(link_rais_url + "loja/templates/templateImagesGoogle.php", {
        pagina : url,
    }, function(data) {
        $('#container-google-imagem').html(data);
        $("#loadOverlay").fadeOut()
    });     
}


function resetInit() {
    var count = $('.fileupload').length;
    $('.fileupload').each(function() {
        var dataArquivo = $(this).attr('data-date');
        var idCliente = $(this).attr('data-id');
        var idGuid = $(this).attr('data-idguid');
        var totalImagensUpadas = 0;
        $('#fileupload-' + idCliente).fileupload({
            url: window.location.protocol + "//" + window.location.hostname + $(this).attr("action"),
            add: function(e, data) {
                var uploadErrors = [];
                var acceptFileTypes = /^image\/(jpe?g|png|jpg)$/i;
                $.each(data.files, function(index, file) {
                    if ((file.type.length == 0) || (file.type.length && !acceptFileTypes.test(file.type))) {
                        uploadErrors.push('O arquivo "' + file.name + '" não foi aceito, pois não é jpg, jpeg nem png.\n')
                    }
                    if (file.type.length && (file.size > 104857600)) {
                        uploadErrors.push('O arquivo "' + file.name + '" não foi aceito, pois ultrapassou os 100mb.\n')
                    }
                    if (uploadErrors.length > 0) {
                        $("#modalConfirmacao").modal('show');
                        var pergunta = $("#modalConfirmacao").find("#perguntaAlerta");
                        if (pergunta.html().length) {
                            pergunta.append("<br>")
                        }
                        pergunta.append(uploadErrors.toString());
                        var botoes = $("#modalConfirmacao").find(".modal-footer-photobook");
                        botoes.html('<button type="button" class="btn btn-default" data-dismiss="modal" id="btn-close" data-toggle="tooltip" title="Não"><i class="fa fa-remove"></i>&nbsp;Fechar</button>');
                        if (!--totalImagensUpadas) {
                            $("#loadOverlay").fadeOut()
                        }
                    } else {
                        var jqXHR = data.submit();
                        jqXHR.done(function(data, textStatus, jqXHR) {
                            var totalEnviados = parseInt($("#valEnviados").text());
                            totalEnviados = parseInt(totalEnviados + count);
                            if (totalEnviados > parseInt($("#valComprados").text())) {
                                $("#alertasArq").css("display", "block");
                                $("#alertasArq").html("Por favor, exclua " + (totalEnviados - parseInt($("#valComprados").text())) + " arquivos.")
                            } else {
                                $("#alertasArq").css("display", "none")
                            }
                            $("#valEnviados").text(totalEnviados);
                            $.each(data.files, function(index, value) {
                                var img = new Image();
                                var urls = this.url.replace(".jpeg", ".png");
                                img.src = this.url;
                                img.addEventListener('load', function() {
                                    GerarImagemCropBase(img, urls);
                                    if (!--totalImagensUpadas) {
                                        $("#loadOverlay").fadeOut()
                                    }
                                }, !1)
                            });
                            $("#caminhopath").val(data.files[0].url.replace(".jpeg", ".png"))
                        })
                    }
                })
            },
            change: function(e, data) {
                totalImagensUpadas = data.files.length;
                var pergunta = $("#modalConfirmacao").find("#perguntaAlerta");
                pergunta.html("");
                $("#loadOverlay").fadeIn();
                if (totalImagensUpadas > 0) {
                    $("#removeTodasImg").css("display", "block")
                }
            },
            autoUpload: !0
        })
        $('#fileupload-' + idCliente).fileupload('option', 'redirect', window.location.href.replace(/\/[^\/]*$/, '/cors/result.html?%s'));
        $.ajax({
            url: $('#fileupload-' + idCliente).fileupload('option', 'url'),
            dataType: 'json',
            context: $('#fileupload-' + idCliente)[0],
            data: {
                dataArquivo: dataArquivo,
                idCliente: idCliente,
                idGuid: idGuid
            },
            error: function(request, status, error) {},
            beforeSend: function() {
                $("#loadOverlay").fadeIn()
            }
        }).done(function(result) {
            var count = result.files.length;
            if (!count) {
                $("#loadOverlay").fadeOut()
            }
            $("#boxEnvComp").css("display", "block");
            $("#valEnviados").html(count);
            if (count > parseInt($("#valComprados").text())) {
                $("#alertasArq").css("display", "block");
                $("#alertasArq").html("Por favor, exclua " + (count - parseInt($("#valComprados").text())) + " arquivos.")
            } else {
                $("#alertasArq").css("display", "none")
            }
            $.each(result.files, function(index, value) {
                $("#removeTodasImg").css("display", "block");
                var urls = this.url;
                var objetoEfeitos = $.parseJSON($("#canvasSerializado").val());
                if ((objetoEfeitos != null) && (objetoEfeitos.length > 0)) {
                    $("#removeTodosEfeitos").css("display", "block");
                    var filteredEfeito = objetoEfeitos.filter(function(item) {
                        return item.dataUrl == urls
                    });
                    if (filteredEfeito != '') {
                        count = count - 1;
                        GerarCanvasBaseEfeitos(urls, filteredEfeito, count)
                    } else {
                        var img = new Image();
                        img.addEventListener('load', function() {
                            if (img.complete) {
                                GerarImagemCropBase(img, urls);
                                if (!--count) {
                                    $("#loadOverlay").fadeOut()
                                }
                            }
                        }, !1);
                        img.src = urls + "?_=" + (new Date().getTime())
                    }
                } else {
                    var img = new Image();
                    img.addEventListener('load', function(e) {
                        if (img.complete) {
                            GerarImagemCropBase(img, urls);
                            if (!--count) {
                                $("#loadOverlay").fadeOut()
                            }
                        }
                    }, !1);
                    img.src = urls + "?_=" + (new Date().getTime())
                }
            });
            if ($.isPlainObject(result.files[0])) {
                $("#caminhopath").val(result.files[0].url.replace(".jpeg", ".png"))
            }
            $(this).fileupload('option', 'done').call(this, $.Event('done'), {
                result: result
            })
        })
    })
}
$("#modalPhotobook").on("click", ".anteriorCrop", function(e) {
    var filtro = '[data-url="' + $("#cropPhotobook").attr("data-url") + '"]';
    var canvasPequeno = $('.imgsPhotobook').filter(filtro);
    var objAterior = canvasPequeno.closest(".boxMasterImg").prev();
    if (objAterior.length) {
        objAterior.find(".imgsPhotobook").trigger('click')
    } else {
        var totalObj = (($(".imgsPhotobook").length) - 1);
        $(".imgsPhotobook").eq(totalObj).trigger('click')
    }
});
$("#modalPhotobook").on("click", ".salvarCrop", function(e) {
    $("#loadOverlay").fadeIn();
    var objThis = $(this);
    var canvas = canvasCropado();
    if (parseInt($("#bordaImg").val())) {
        aplicarBorda(canvas)
    }
    var dataURL = canvas.toDataURL("image/png");
    var filtro = '[data-url="' + $("#cropPhotobook").attr("data-url") + '"]';
    var canvasPequeno = $('.imgsPhotobook').filter(filtro);
    $.ajax({
        type: "POST",
        url: "/loja/fotoprodutos/salvarfoto/",
        data: {
            imgBase64: dataURL,
            caminho: $("#cropPhotobook").attr("data-url"),
            x1: 0,
            x2: $('#x2').val(),
            y1: 0,
            y2: $('#y2').val(),
            w: $('#w').val(),
            h: $('#h').val()
        }
    }).done(function(caminhoImage) {
        var img = new Image();
        img.addEventListener('load', function() {
            var canvas = canvasPequeno[0];
            var context = canvas.getContext("2d");
            context.clearRect(0, 0, canvas.width, canvas.height);
            context.drawImage(this, 0, 0, canvas.width, canvas.height)
        }, !1);
        img.src = caminhoImage + "?_=" + (new Date().getTime());
        $(canvasPequeno).attr("x1", $('#x1').val());
        $(canvasPequeno).attr("x2", $('#x2').val());
        $(canvasPequeno).attr("y1", $('#y1').val());
        $(canvasPequeno).attr("y2", $('#y2').val());
        $(canvasPequeno).attr("w", $('#w').val());
        $(canvasPequeno).attr("h", $('#h').val());
        $(canvasPequeno).attr("data-efeito", $("#cropPhotobook").attr("data-efeito"));
        $(canvasPequeno).attr("data-zoom", $("#cropPhotobook").attr("data-scala"));
        var efeitosB = $("#rangerZoom").val() + "," + $("#rangerBrilho").val() + "," + $("#rangerContraste").val() + "," + $("#rangerSaturacao").val() + "," + $("#rangerMatiz").val();
        $(canvasPequeno).attr("data-barraEfeitos", efeitosB);
        if (parseInt($("#bordaImg").val())) {
            aplicarBorda(canvas)
        }
        preencheSerializado(1);
        if (parseInt($(objThis).attr("data-opcao"))) {
            var proximoObj = canvasPequeno.closest(".boxMasterImg").next();
            if (proximoObj.length) {
                proximoObj.find(".imgsPhotobook").trigger('click')
            } else {
                $(".imgsPhotobook").eq(0).trigger('click')
            }
        } else {
            $('#modalPhotobook').modal('hide')
        }
        $("#loadOverlay").fadeOut()
    })
});
$("#template-download").on("click", ".imgsPhotobook", function(e) {
    if ($('.efeitos').length) {
        $('.efeitos').remove();
        $('.txtEfeitos').text("")
    }
    if ($(".eativo").length) {
        $(".eativo").removeClass("eativo")
    }
    $("#txtEfeitos1").addClass("eativo");
    var barraEfeitos = $(this).attr("data-barraefeitos");
    $("#loadOverlay").fadeIn();
    construtorCanvasCrop($(this).attr("data-url"), $(this).attr("x1"), $(this).attr("y1"), $(this).attr("x2"), $(this).attr("y2"), $(this).attr("data-efeito"), barraEfeitos, $(this).attr("data-zoom"));
    $('#modalPhotobook').modal('show');
    $("#bordaImg").val($(this).attr("data-borda"));
    var efeitosB = barraEfeitos.split(',');
    $("#rangerZoom").val(efeitosB[0]);
    $("#rangerBrilho").val(efeitosB[1]);
    $("#rangerContraste").val(efeitosB[2]);
    $("#rangerSaturacao").val(efeitosB[3]);
    $("#rangerMatiz").val(efeitosB[4]);
    abas("efeitosProntos")
});
$(document).on('click', "#paginacaoAlbunsFB", function(event) {
    var pagina = $(this).attr('datapage');
    buscaAlbunsFacebook(pagina, 0)
});



function checkLoginState() {
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response)
    })
}
$(document).ready(function() {
    'use strict';
    resetInit()
})


$('#modal-google').on('hidden.bs.modal', function () {
/** se fechar a modal sem selecionar nenhuma foto, apagamos a lista **/
   localStorage.removeItem('listaPaginacaoGoogleFotos');
})