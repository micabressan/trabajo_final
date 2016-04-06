it('POST Request: should call addContent and send object', inject(function() {

            var base64Image = 'aVZCT1J3MEtHZ29BQUFBTlNVaEVVZ0FBQUdRQUFBQmtDQUlBQUFE';

            var content = {
                id: '55d84d82edbe7e65bf271fb',
                mapIcon: base64Image,
                title: 'title',
                mainImage: base64Image,
                fullView: 'html',
                onMap: true
            },
                convertedContent = contentsFactory.convertFromBase64(content);

            $httpBackend.expectPOST('rest/contents', convertedContent)
                .respond(200, 'Done');

            var result = contentsFactory.addContent(convertedContent);

            $httpBackend.flush();

        }));