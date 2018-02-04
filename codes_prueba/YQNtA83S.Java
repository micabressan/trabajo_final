base.widthProperty().addListener(new ChangeListener<Number>() {

			@Override
			public void changed(ObservableValue<? extends Number> observable, Number oldValue, Number newValue) {
				menuBar.setPrefWidth((double) newValue);
				browser.setPrefWidth((double) newValue);
				darkOverlay.setPrefWidth(browser.getPrefWidth());

			}
		});
		base.heightProperty().addListener(new ChangeListener<Number>() {

			@Override
			public void changed(ObservableValue<? extends Number> observable, Number oldValue, Number newValue) {
				browser.setPrefHeight(((double) newValue) - 80);
				darkOverlay.setPrefHeight(browser.getPrefHeight());
				darkOverlay.setLayoutY(browser.getLayoutY());
				bookInfo.setLayoutY(((double) newValue) - 20);
			}
		});