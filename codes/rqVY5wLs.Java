//----------AP---------------------------------------------------------------------- 
            PdfStream nDict = new PdfStream();
            nDict.Put(PdfName.BBox, bbox);
            nDict.Put(PdfName.Matrix, new PdfArray(new[] {anno.I1, anno.I2, anno.I3, anno.I4, anno.I5, anno.I6}));
            nDict.Put(PdfName.Subtype, PdfName.Form);
            nDict.Put(PdfName.Type, PdfName.XObject);

            tempDict2.Clear();
            tempDict2.Add(PdfName.K, new PdfBoolean(false));
            tempDict2.Add(PdfName.S, new PdfName("Transparency"));
            tempDict2.Add(PdfName.Type, PdfName.Group);
            nDict.Put(PdfName.Group, new PdfDictionary(tempDict2));

            tempDict2.Clear();

            PdfDictionary resDictionary = new PdfDictionary();
            resDictionary.Put(new PdfName("Im0"), anno.Image.GetPdfObject());
            tempDict2.Add(PdfName.XObject, resDictionary);

            tempDict2.Add(PdfName.ProcSet, new PdfArray(new PdfObject[] {new PdfName("PDF"), new PdfName("ImageC")}));
            nDict.Put(PdfName.Resources, new PdfDictionary(tempDict2));

            tempDict.Clear();
            tempDict.Add(PdfName.N, nDict);
            annoDict.Put(PdfName.AP, new PdfDictionary(tempDict));