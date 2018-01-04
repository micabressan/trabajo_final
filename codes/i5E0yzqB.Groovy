void initUI() {
        builder.with {
            builder.application(name: mainWindowId,
                    title: getMessage('main.title'),
                    sizeToScene: true,
                    centerOnScreen: true) {
                def mainScene = scene(width: model.windowWidth,
                        height: model.windowHeight) {
                    stylesheets([javafxCSS])

                    borderPane {
                        top { // Main menu
                            menuBar(useSystemMenuBar: true) {
                                menu(getMessage('main.menu.File.text')) { // File
                                    menuItem(preferencesAction)
                                    menuItem(exitAction)
                                }
                                menu(getMessage('main.menu.Edit.text')) { // Edit
                                }
                            }
                        }

                        center {
                            borderPane {
                                top {
                                    toolBar {
                                        toggleButton(id: editModeTglId, modeEditAction)
                                        toggleButton(id: runModeTglId, modeRunAction)
                                        noparent { // modeToggleGroup configuration
                                            def toggleGroup = new ToggleGroup()
                                            toggleGroup.toggles.addAll([
                                                    builder[editModeTglId],
                                                    builder[runModeTglId]])
                                            toggleGroup.selectedToggleProperty().addListener({ ov, prevTgl, newTgl ->
                                                if (!newTgl) {
                                                    runInsideUIAsync { toggleGroup.selectToggle(prevTgl) }
                                                }
                                            } as ChangeListener)
                                            model.modeProperty().addListener({ ov, prevMode, newMode ->
                                                toggleGroup.selectToggle(toggleOf(newMode))
                                            } as ChangeListener)
                                            toggleGroup.selectToggle(toggleOf(model.mode))
                                        }
                                        separator(orientation: VERTICAL)
                                    }
                                }
                                center {
                                    scrollPane(id: 'nodesPane') {
                                        borderPane {
                                            top {
                                                node(createMVCGroup('node-source').rootNode)
                                            }
                                            center {
                                                vbox(id: nodesId) {
                                                    button('transformer1')
                                                    button('element2')
                                                    button('filter3')
                                                }
                                            }
                                            bottom {
                                                node(createMVCGroup('node-result').rootNode)
                                            }
                                        }
                                    }
                                }
                                bottom {
                                    node(createMVCGroup('status-bar').rootNode)
                                }
                            }
                        }
                    }
                }
                noparent { // bind window size to model
                    mainScene.widthProperty().addListener({ ov, prevValue, newValue ->
                        runOutsideUIAsync { model.windowWidth = newValue }
                    } as ChangeListener)
                    mainScene.heightProperty().addListener({ ov, prevValue, newValue ->
                        runOutsideUIAsync { model.windowHeight = newValue }
                    } as ChangeListener)
                }
            }
        }
    }