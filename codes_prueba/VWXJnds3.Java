        Context ct = new InitialContext();
        fourierBean = (ILab6) ct.lookup("java:global/ztpLab6EJB/FourierBean!Fourierpackage.ILab6");
        int n = Integer.parseInt("8");
        Complex[] x = new Complex[n];
        int j = 0;
        // original data
        
//        for (double i = -3.14; i < 3.14 && j<n; i+=0.4, j++) {
//            x[j] = new Complex(Math.sin(i), 0);
//        }
           
           
//        for (double i = - (2* Math.PI); i <= (Math.PI * 2) && j<n; i+=(Math.PI/2.0), j++) {
//            x[j] = new Complex(Math.cos(i), 0);
//        }
        for ( double i =-Math.PI; i <= 0 && j < n; i+=(Math.PI / 8.0), j++){
            x[j] = new Complex(Math.cos(Math.PI), 0);
        }
        fourierBean.show(x, "x");

        // FFT of original data
        Complex[] y = fourierBean.fft(x);
        fourierBean.show(y, "y = fft(x)");

        // take inverse FFT
        Complex[] z = fourierBean.ifft(y);
        fourierBean.show(z, "z = ifft(y)");

        // circular convolution of x with itself
        Complex[] c = fourierBean.cconvolve(x, x);
        fourierBean.show(c, "c = cconvolve(x, x)");

        // linear convolution of x with itself
        Complex[] d = fourierBean.convolve(x, x);
        fourierBean.show(d, "d = convolve(x, x)");

        final XYSeries FFTreal = new XYSeries("FFT Real");
        for( int h = 0; h < n; h++){
            System.out.println("RE " + x[h].re());
            FFTreal.add(x[h].re(), y[h].re());
        }


        final XYSeries FFTim = new XYSeries("FFT IMG");
        for( int k = 0; k < n; k++){
            FFTim.add(x[k].re(), y[k].im());
            System.out.println("im " + y[k].im());
        }


        final XYSeriesCollection dataset = new XYSeriesCollection();
        dataset.addSeries(FFTreal);
        dataset.addSeries(FFTim);

        JFreeChart xylineChart = ChartFactory.createXYLineChart(
                "FFT Real and FFT Im plots",
                "X",
                "Y",
                dataset,
                PlotOrientation.VERTICAL,
                true, true, false);
        
        
//        final XYLineAndShapeRenderer renderer = new XYLineAndShapeRenderer();
//        renderer.setSeriesLinesVisible(0, false);
//        renderer.setSeriesLinesVisible(1, false);
//        XYPlot plot = (XYPlot) xylineChart.getPlot();
//        plot.setRenderer(renderer);
        int width = 640;
        /* Width of the image */
        int height = 480;
        /* Height of the image */
        //save as file
//        File XYChart = new File("XYLineChartCos.jpeg");
//        ChartUtilities.saveChartAsJPEG(XYChart, xylineChart, width, height);
        
          ChartPanel cp = new ChartPanel(xylineChart) {

            @Override
            public Dimension getPreferredSize() {
                return new Dimension(320, 240);
            }
        };
        cp.setMouseWheelEnabled(true);
        JFrame frame = new JFrame("ImageApp");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(1200, 1200);
        frame.setVisible(true);
        frame.add(cp);
    }