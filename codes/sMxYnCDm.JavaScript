function zamowienieText() {
            var razem = 0;
            zamtext = "Lp." + " ".repeat(5 - "lp".length);
            zamtext = zamtext + "Nazwa" + " ".repeat(20 - "nazwa".length);
            zamtext = zamtext + "Cena" + " ".repeat(10 - "cena".length);
            zamtext = zamtext + "Ilość" + " ".repeat(7 - "ilosc".length);
            zamtext = zamtext + "Wartość" + " ".repeat(10 - "cena".length);
            zamtext = zamtext + String.fromCharCode(13);
            for (i = 0; i < koszyk.length; i++) {
                zamtext = zamtext + [i + 1].toString() + " ".repeat(6 - i.toString().length);
                zamtext = zamtext + koszyk[i].nazwa + " ".repeat(20 - koszyk[i].nazwa.length);
                zamtext = zamtext + koszyk[i].cena + " ".repeat(10 - koszyk[i].cena.toString().length);
                zamtext = zamtext + koszyk[i].ilosc + " ".repeat(7 - koszyk[i].ilosc.toString().length);
                zamtext = zamtext + koszyk[i].wartosc + " ".repeat(10 - koszyk[i].wartosc.toString().length);
                zamtext = zamtext + String.fromCharCode(13);
                razem += parseInt(koszyk[i].wartosc);
            }
            zamtext += "Razem: " + razem + "zł";

            return zamtext;
        };

        function zamowienieHTML(adres) {
            this.adres = adres;
            var html;
            html = "<div id='dostawaCont'>";
            html = html + "<form action='mailto:" + adres + "' method='post' enctype='text/plain'>";
            html = html + "<p>Wybierz dostawę: </p>" + "<select id='dostawaSelect' onchange='dostawa()'><option></option><option value='Kurier'>Kurier</option><option value='Poczta Polska'>Poczta Polska</option></select>";
            html = html + "<p>Forma płatności: </p>" + "<p><select id='platnoscSelect'  onchange='platnosc()'><option></option><option value='Przy odbiorze'>Przy odbiorze</option><option value='Przelew'>Przelew</option></select></p>"
            html = html + "<textarea name='zamowienia' id='zawartosc'>";
            html = html + zamowienieText();
            html = html + "</textarea>";
            html = html + "<input type='submit' value='Finalizuj zamówienie'>";
            html = html + "</div>";
            html = html + "</form>";
            return html;
        };

        function dostawa() {
            var razem = 0;
            var a = $("#dostawaSelect").val();
            var b = $("#platnoscSelect").val();
            var zawartosc = document.getElementById("zawartosc");
            zamtext = "Lp." + " ".repeat(5 - "lp".length);
            zamtext = zamtext + "Nazwa" + " ".repeat(20 - "nazwa".length);
            zamtext = zamtext + "Cena" + " ".repeat(10 - "cena".length);
            zamtext = zamtext + "Ilosc" + " ".repeat(7 - "ilosc".length);
            zamtext = zamtext + "Wartosc" + " ".repeat(10 - "cena".length);
            zamtext = zamtext + String.fromCharCode(13);
            for (i = 0; i < koszyk.length; i++) {
                zamtext = zamtext + [i + 1].toString() + " ".repeat(6 - i.toString().length);
                zamtext = zamtext + koszyk[i].nazwa + " ".repeat(20 - koszyk[i].nazwa.length);
                zamtext = zamtext + koszyk[i].cena + " ".repeat(10 - koszyk[i].cena.toString().length);
                zamtext = zamtext + koszyk[i].ilosc + " ".repeat(7 - koszyk[i].ilosc.toString().length);
                zamtext = zamtext + koszyk[i].wartosc + " ".repeat(10 - koszyk[i].wartosc.toString().length);
                zamtext = zamtext + String.fromCharCode(13);
                razem += parseInt(koszyk[i].wartosc);
            }
            zamtext += "Razem: " + razem + "zł";
            zamtext += String.fromCharCode(13);
            zamtext += "Metoda dostawy to: " + a;
            zamtext += String.fromCharCode(13);
            zamtext += "Metoda płatności to: " + b;
            zawartosc.innerHTML = zamtext;
        }

        function platnosc() {
            var razem = 0;
            var a = $("#dostawaSelect").val();
            var b = $("#platnoscSelect").val();
            var zawartosc = document.getElementById("zawartosc");
            zamtext = "Lp." + " ".repeat(5 - "lp".length);
            zamtext = zamtext + "Nazwa" + " ".repeat(20 - "nazwa".length);
            zamtext = zamtext + "Cena" + " ".repeat(10 - "cena".length);
            zamtext = zamtext + "Ilosc" + " ".repeat(7 - "ilosc".length);
            zamtext = zamtext + "Wartosc" + " ".repeat(10 - "cena".length);
            zamtext = zamtext + String.fromCharCode(13);
            for (i = 0; i < koszyk.length; i++) {
                zamtext = zamtext + [i + 1].toString() + " ".repeat(6 - i.toString().length);
                zamtext = zamtext + koszyk[i].nazwa + " ".repeat(20 - koszyk[i].nazwa.length);
                zamtext = zamtext + koszyk[i].cena + " ".repeat(10 - koszyk[i].cena.toString().length);
                zamtext = zamtext + koszyk[i].ilosc + " ".repeat(7 - koszyk[i].ilosc.toString().length);
                zamtext = zamtext + koszyk[i].wartosc + " ".repeat(10 - koszyk[i].wartosc.toString().length);
                zamtext = zamtext + String.fromCharCode(13);
                razem += parseInt(koszyk[i].wartosc);
            }
            zamtext += "Razem: " + razem + "zł";
            zamtext += String.fromCharCode(13);
            zamtext += "Metoda dostawy to: " + a;
            zamtext += String.fromCharCode(13);
            zamtext += "Metoda płatności to: " + b;
            zawartosc.innerHTML = zamtext;
        }

        function wstawZamowienie() {
            var mail;
            var email;
            var reg;
            do {
                email = prompt("Proszę podać adres e-mail:");
                reg = email.match(/^[0-9a-zA-Z_.-]+@[0-9a-zA-Z.-]+\.[a-zA-Z]{2,3}$/);
            } while (reg === null)
            if (email === null || email === "") {
                alert("Nie podano adresu e-mail");
            } else {
                mail = email;
                console.log(mail);
            }
            $("#content").html("");
            $("#content").html(zamowienieHTML(mail));
        };