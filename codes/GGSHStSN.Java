final Image VPNIcon = new Image(getClass().getResourceAsStream("/view/images/treeview_24x24/DeviceStatusOk_VPN.png"));
			final Image leftArrow = new Image(getClass().getResourceAsStream("/view/images/Toolbar_32x32/ArrowLeft.png"));
			final Image rightArrow = new Image(getClass().getResourceAsStream("/view/images/Toolbar_32x32/ArrowRight.png"));
			
			ImageView leftArrowView = new ImageView(leftArrow);
			leftArrowView.setFitWidth(14.0);
			leftArrowView.setFitHeight(14.0);
			
			ImageView rightArrowView = new ImageView(rightArrow);
			rightArrowView.setFitWidth(14.0);
			rightArrowView.setFitHeight(14.0);

			Label lbl1 = new Label("Hello");
			Label lbl2 = new Label("Hello");

			lbl1.setFont(new Font("Segoe UI", 14));
			lbl2.setFont(new Font("Segoe UI", 14));

			HBox buttonBox = new HBox();
			buttonBox.setSpacing(5);
			buttonBox.setAlignment(Pos.CENTER);

			Button editBtn = new Button("Edit");
			Button viewBtn = new Button("Details");
			Button deleteBtn = new Button("Delete");

			editBtn.setFont(new Font("Segoe UI", 13));
			viewBtn.setFont(new Font("Segoe UI", 13));
			deleteBtn.setFont(new Font("Segoe UI", 13));

			buttonBox.getChildren().addAll(editBtn, viewBtn, deleteBtn);

			gridPaneNet1.addRow(n, lbl1, new ImageView(VPNIcon), leftArrowView, rightArrowView, new ImageView(VPNIcon), lbl2,
					buttonBox);

			n++;