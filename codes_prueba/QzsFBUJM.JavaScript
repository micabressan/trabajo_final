var mainCharMenu = null;

var faceMenu = null;
var faceMenuSelection = 0;
var faceFeatureScale = 0;

var hairMenu = null;
var hairModelSelection = 0; 
var hairTextureSelection1 = 0;
var hairTextureSelection2 = 0;
var facialHairModelSelection = 0;
var facialHairTextureSelection1 = 0;
var facialHairTextureSelection2 = 0;

var hatMenu = null;
var hatModelSelection = 0;
var hatTextureSelection = 0;

var maskMenu = null;
var maskModelSelection = 0;
var maskTextureSelection = 0;

var glassesMenu = null;
var glassesModelSelection = 0;
var glassesTextureSelection = 0;

var accessoryMenu = null;
var accessoryModelSelect = 0;
var accessoryTextureSelect = 0;

var earringsMenu = null;
var earringsModelSelect = 0;
var earringsTextureSelect = 0;

var undershirtMenu = null;
var undershirtModelSelect = 0;
var undershirtTextureSelect = 0;

var charName = null;
API.setPlayerSkin(1885233650);
var face1 = 0;
var face2 = 21;
var faceShapeMix = 0;
var faceSkinMix = 0;
API.callNative("SET_PED_HEAD_BLEND_DATA", API.getLocalPlayer(), face1, face2, 0, face1, face2, 0, API.f(faceShapeMix), API.f(faceSkinMix), 0, false);

var genderMenu = null;
var playerGender = "M";

var char_data = null;

API.onServerEventTrigger.connect(function (eventName, args) {

    switch (eventName) {
        case 'char_creation':
            char_data = JSON.parse(args[0]);
            CreateGenderMenu();
            genderMenu.Visible = true; 
            break;
    }
});

function CreateGenderMenu() {
    genderMenu = API.createMenu("", 0, 0, 6);
    API.setMenuTitle(genderMenu, "Sesso");
    API.setMenuBannerRectangle(genderMenu, 200, 66, 131, 244);

    genderMenu.AddItem(API.createMenuItem("Maschio", ""));
    genderMenu.AddItem(API.createMenuItem("Femmina", ""));

    genderMenu.OnIndexChange.connect(function (sender, index) {
        if (index == 0) {
            API.setPlayerSkin(1885233650);
            API.callNative("SET_PED_HEAD_BLEND_DATA", API.getLocalPlayer(), face1, face2, 0, face1, face2, 0, API.f(faceShapeMix), API.f(faceSkinMix), 0, false);
            playerGender = "M";
        } else {
            API.setPlayerSkin(-1667301416);
            API.callNative("SET_PED_HEAD_BLEND_DATA", API.getLocalPlayer(), face1, face2, 0, face1, face2, 0, API.f(faceShapeMix), API.f(faceSkinMix), 0, false);
            playerGender = "F";
        }
    });

    genderMenu.OnItemSelect.connect(function (sender, item, index) {

        createMainCharMenu();
        createFaceMenu();
        createHairMenu();
        createHatMenu();
        createMaskMenu();
        createGlassesMenu();
        createAccessoryMenu();
        createEarringsMenu();
        createUndershirtMenu();
       /* createShirtMenu();
        createPantsMenu();
        createShoesMenu();*/

        genderMenu.Visible = false;
        mainCharMenu.Visible = true;

    });

    genderMenu.ParentMenu = genderMenu;
}

function createMainCharMenu() {
    mainCharMenu = API.createMenu("", 0, 0, 6);
    API.setMenuTitle(mainCharMenu, "Personaggio");
    API.setMenuBannerRectangle(mainCharMenu, 200, 66, 131, 244);

    var nameMenuItem = API.createMenuItem("Nome", "");
    nameMenuItem.SetRightLabel(charName);

    nameMenuItem.Activated.connect(function (menu, item) {
        charName = API.getUserInput(charName, 32);
        item.SetRightLabel(charName);
    });

    mainCharMenu.AddItem(nameMenuItem);

    var faceMenuItem = API.createMenuItem("Faccia", "");

    faceMenuItem.Activated.connect(function (menu, item) {
        showFaceMenu();
    });

    mainCharMenu.AddItem(faceMenuItem);

    var hairMenuItem = API.createMenuItem("Capelli", "");

    hairMenuItem.Activated.connect(function (menu, item) {
        showHairMenu();
    });

    mainCharMenu.AddItem(hairMenuItem);

    var hatMenuItem = API.createMenuItem("Cappelli", "");

    hatMenuItem.Activated.connect(function (menu, item) {
        showHatMenu();
    });

    mainCharMenu.AddItem(hatMenuItem);

    var maskMenuItem = API.createMenuItem("Maschere", "");

    maskMenuItem.Activated.connect(function (menu, item) {
        showMaskMenu();
    });

    mainCharMenu.AddItem(maskMenuItem);

    var glassesMenuItem = API.createMenuItem("Occhiali", "");

    glassesMenuItem.Activated.connect(function (menu, item) {
        showGlassesMenu();
    });

    mainCharMenu.AddItem(glassesMenuItem);

    var accessoryMenuItem = API.createMenuItem("Accessori", "");

    accessoryMenuItem.Activated.connect(function (menu, item) {
        showAccessoryMenu();
    });

    mainCharMenu.AddItem(accessoryMenuItem);

    var earringsMenuItem = API.createMenuItem("Orecchini", "");

    earringsMenuItem.Activated.connect(function (menu, item) {
        showEarringsMenu();
    });

    mainCharMenu.AddItem(earringsMenuItem);

    var undershirtMenuItem = API.createMenuItem("Magliette", "");

    undershirtMenuItem.Activated.connect(function (menu, item) {
        showUndershirtMenu();
    });

    mainCharMenu.AddItem(undershirtMenuItem);

    var shirtMenuItem = API.createMenuItem("Maglie", "");

    shirtMenuItem.Activated.connect(function (menu, item) {
        showShirtMenu();
    });

    mainCharMenu.AddItem(shirtMenuItem); 

    var pantsMenuItem = API.createMenuItem("Pantaloni", "");

    pantsMenuItem.Activated.connect(function (menu, item) {
        showPantsMenu();
    });

    mainCharMenu.AddItem(pantsMenuItem);

    var shoesMenuItem = API.createMenuItem("Scarpe", "");

    shoesMenuItem.Activated.connect(function (menu, item) {
        showShoesMenu();
    });

    mainCharMenu.AddItem(shoesMenuItem);

    mainCharMenu.ParentMenu = genderMenu;

    mainCharMenu.Visible = false;
}

function createFaceMenu() {
    faceMenu = API.createMenu("", 0, 0, 6);
    API.setMenuTitle(faceMenu, "Faccia");
    API.setMenuBannerRectangle(faceMenu, 200, 66, 131, 244);

    var face1List = new List(String);
    var face2List = new List(String);
    for (var i = 0; i < 46; i++) {
        face1List.Add(i.toString());
        face2List.Add(i.toString());
    }

    var face1ListItem = API.createListItem("Faccia 1", "", face1List, face1);
    var face2ListItem = API.createListItem("Faccia 2", "", face2List, face2);

    var faceShapeMixList = new List(String);
    faceShapeMixList.Add("0.0");
    faceShapeMixList.Add("0.1");
    faceShapeMixList.Add("0.2");
    faceShapeMixList.Add("0.3");
    faceShapeMixList.Add("0.4");
    faceShapeMixList.Add("0.5");
    faceShapeMixList.Add("0.6");
    faceShapeMixList.Add("0.7");
    faceShapeMixList.Add("0.8");
    faceShapeMixList.Add("0.9");
    faceShapeMixList.Add("1.0");

    var faceSkinMixList = new List(String);
    faceSkinMixList.Add("0.0");
    faceSkinMixList.Add("0.1");
    faceSkinMixList.Add("0.2");
    faceSkinMixList.Add("0.3");
    faceSkinMixList.Add("0.4");
    faceSkinMixList.Add("0.5");
    faceSkinMixList.Add("0.6");
    faceSkinMixList.Add("0.7");
    faceSkinMixList.Add("0.8");
    faceSkinMixList.Add("0.9");
    faceSkinMixList.Add("1.0");

    var faceShapeMixListItem = API.createListItem("Mix Forma", "Numeri da 0 a 1 per indicare la forma.", faceShapeMixList, faceShapeMix);
    var faceSkinMixListItem = API.createListItem("Mix Skin", "Numeri da 0 a 1 per indicare la forma.", faceSkinMixList, faceSkinMix);

    faceMenu.AddItem(face1ListItem);
    faceMenu.AddItem(face2ListItem);
    faceMenu.AddItem(faceShapeMixListItem);
    faceMenu.AddItem(faceSkinMixListItem);

    faceMenu.CurrentSelection = 0;

    faceMenu.OnListChange.connect(function (menu, item, index) {
        switch (item) {
            case face1ListItem:
                face1 = index;
                break;
            case face2ListItem:
                face2 = index;
                break;
            case faceShapeMixListItem:
                if (index != 0) {
                    faceShapeMix = index / 10;
                } else {
                    faceShapeMix = 0;
                }
            case faceSkinMixListItem:
                if (index != 0) {
                    faceShapeMix = index / 10;
                } else {
                    faceShapeMix = 0;
                }
                break;
        }
        API.callNative("SET_PED_HEAD_BLEND_DATA", API.getLocalPlayer(), face1, face2, 0, face1, face2, 0, API.f(faceShapeMix), API.f(faceSkinMix), 0, false);
    });

    faceMenu.ParentMenu = mainCharMenu;
    faceMenu.Visible = false;
}

function showFaceMenu() {
    mainCharMenu.Visible = false;
    faceMenu.Visible = true;
}


function createHairMenu() {
    hairMenu = API.createMenu("", 0, 0, 6);
    API.setMenuTitle(hairMenu, "Capelli");
    API.setMenuBannerRectangle(hairMenu, 200, 66, 131, 244);

    var hairModelList = new List(String);
    if (playerGender == "M") {
        for (var i = 0; i < 37; i++) {
            if (i == 23) continue;
            hairModelList.Add(i.toString());
        }
    } else {
        for (var i = 0; i < 39; i++) {
            if (i == 24) continue;
            hairModelList.Add(i.toString());
        }
    } 

    var facialModelHairList = new List(String);
    for (var i = 0; i < 29; i++) {
        facialModelHairList.Add(i.toString());
    }

    var hairTexture1List = new List(String);
    var hairTexture2List = new List(String);
    for (var i = 0; i < 64; i++) {
        hairTexture1List.Add(i.toString());
        hairTexture2List.Add(i.toString());
    }

    var facialHairTextureList1 = new List(String);
    var facialHairTextureList2 = new List(String);
    for (var i = 0; i < 64; i++) {
        facialHairTextureList1.Add(i.toString());
        facialHairTextureList2.Add(i.toString());
    }


    var hairModelMenuItem = API.createListItem("Stile", "", hairModelList, 0);
    var hairTexture1MenuItem = API.createListItem("Colore", "", hairTexture1List, 0);
    var hairTexture2MenuItem = API.createListItem("Rilievo", "", hairTexture2List, 0);
    var facialHairModelMenuItem = API.createListItem("Stile", "", facialModelHairList, 0);
    var facialHairTexture1MenuItem = API.createListItem("Colore", "", facialHairTextureList1, 0);
    var facialHairTexture2MenuItem = API.createListItem("Rilievo", "", facialHairTextureList2, 0);

    hairMenu.AddItem(hairModelMenuItem);
    hairMenu.AddItem(hairTexture1MenuItem);
    hairMenu.AddItem(hairTexture2MenuItem);

    hairMenu.AddItem(facialHairModelMenuItem);
    hairMenu.AddItem(facialHairTexture1MenuItem);
    hairMenu.AddItem(facialHairTexture2MenuItem);

    hairMenu.CurrentSelection = 0;
    hairMenu.OnListChange.connect(function (sender, item, index) {
        if (item == hairModelMenuItem) {
            hairModelSelection = parseInt(item.IndexToItem(index));
            API.setPlayerClothes(API.getLocalPlayer(), 2, hairModelSelection, 0);
            API.callNative("_SET_PED_HAIR_COLOR", API.getLocalPlayer(), hairTextureSelection1, hairTextureSelection2);
        }
        if (item == hairTexture1MenuItem) {
            hairTextureSelection1 = parseInt(item.IndexToItem(index));
            API.callNative("_SET_PED_HAIR_COLOR", API.getLocalPlayer(), hairTextureSelection1, hairTextureSelection2);
        }
        if (item == hairTexture2MenuItem) {
            hairTextureSelection2 = parseInt(item.IndexToItem(index));
            API.callNative("_SET_PED_HAIR_COLOR", API.getLocalPlayer(), hairTextureSelection1, hairTextureSelection2);
        }
        if (item == facialHairModelMenuItem) {
            facialHairModelSelection = parseInt(item.IndexToItem(index));
            API.callNative("_SET_PED_HEAD_OVERLAY", API.getLocalPlayer(), 1, facialHairModelSelection, API.f(1));
        }
        if (item == facialHairTexture1MenuItem) {
            facialHairTextureSelection1 = parseInt(item.IndexToItem(index));
            API.callNative("_SET_PED_HEAD_OVERLAY_COLOR", API.getLocalPlayer(), 1, 2, facialHairTextureSelection1, facialHairTextureSelection2);
        }
        if (item == facialHairTexture2MenuItem) {
            facialHairTextureSelection2 = parseInt(item.IndexToItem(index));
            API.callNative("_SET_PED_HEAD_OVERLAY_COLOR", API.getLocalPlayer(), 1, 2, facialHairTextureSelection1, facialHairTextureSelection2);
        }
    });

    hairMenu.OnItemSelect.connect(function (sender, item, index) {
        hairMenu.Visible = false;
        mainCharMenu.Visible = true;
    });

    hairMenu.ParentMenu = mainCharMenu;

    hairMenu.Visible = false;
}

function showHairMenu() {
    mainCharMenu.Visible = false;
    hairMenu.Visible = true;
}

function createHatMenu() {
    hatMenu = API.createMenu("Cappello", 0, 0, 6);
    API.setMenuTitle(hatMenu, "Personaggio");
    API.setMenuBannerRectangle(hatMenu, 200, 66, 131, 244);


    var hatData = null;
    if (playerGender == "M") {
        hatData = char_data.male.hat;
    } else {
        hatData = char_data.female.hat;
    }

    var hatModelList = new List(String);
    for (var i = 0; i < hatData.length; i++) {
        hatModelList.Add(hatData[i].m.toString());
    }

    var hatModelTextureList = new List(String);
    for (var i = 0; i < hatData[0].t.length; i++) {
        var a = hatData[0].t;
        hatModelTextureList.Add(a[i].toString());
    }

    var hatModelListItem = API.createListItem("Cappelli", "", hatModelList, 0);
    var hatModelTextureListItem = API.createListItem("Colore", "", hatModelTextureList, 0);

    hatMenu.AddItem(hatModelListItem);
    hatMenu.AddItem(hatModelTextureListItem);

    hatMenu.OnListChange.connect(function (sender, item, index) {
        if (item == hatModelListItem) {

            hatModelSelection = parseInt(item.IndexToItem(index));

            hatModelTextureList = new List(String);
            for (var i = 0; i < hatData[index].t.length; i++) {
                var a = hatData[index].t;
                hatModelTextureList.Add(a[i].toString());
            }

            hatTextureSelection = parseInt(hatModelTextureList[0]);

            hatMenu.RemoveItemAt(1);
            hatModelTextureListItem = API.createListItem("Colore", "", hatModelTextureList, 0);
            hatMenu.AddItem(hatModelTextureListItem);

            API.setPlayerAccessory(API.getLocalPlayer(), 0, hatModelSelection, hatTextureSelection);

        }
        if (item = hatModelTextureListItem) {
            hatTextureSelection = parseInt(item.IndextoItem(index));
            API.setPlayerAccessory(API.getLocalPlayer(), 0, hatModelSelection, hatTextureSelection);
        }

    });

    hatMenu.OnItemSelect.connect(function (sender, item, index) {
        hatMenu.Visible = false;
        mainCharMenu.Visible = true;
    });

    hatMenu.ParentMenu = mainCharMenu;
    hatMenu.Visible = false;

}

function showHatMenu() {
    mainCharMenu.Visible = false;
    hatMenu.Visible = true;
}

function createMaskMenu() {
    maskMenu = API.createMenu("Maschere", 0, 0, 6);
    API.setMenuTitle(maskMenu, "Personaggio");
    API.setMenuBannerRectangle(maskMenu, 200, 66, 131, 244);


    var maskData = char_data.masks;

    var maskModelList = new List(String);
    for (var i = 0; i < maskData.length; i++) {
        maskModelList.Add(maskData[i].m.toString());
    }

    var maskModelTextures = new List(String);
    for (var i = 0; i < maskData[0].t.length; i++) {
        var a = maskData[0].t;
        maskModelTextures.Add(a[i].toString());
    }

    var maskModelListItem = API.createListItem("Stile", "", maskModelList, 0);
    var maskTextureListItem = API.createListItem("Colore", "", maskModelTextures, 0);
 
    maskMenu.AddItem(maskModelListItem);
    maskMenu.AddItem(maskTextureListItem);

    maskMenu.OnListChange.connect(function (sender, item, index) {
        if (item == maskModelListItem) {
            maskModelSelection = parseInt(item.IndexToItem(index));

            maskModelTextures = new List(String);
            for (var i = 0; i < maskData[index].t.length; i++) {
                var a = maskData[index].t;
                maskModelTextures.Add(a[i].toString());
            }

            maskTextureSelection = parseInt(maskModelTextures[0]);

            maskMenu.RemoveItemAt(1);
            maskTextureListItem = API.createListItem("Colore", "", maskModelTextures, 0);
            maskMenu.AddItem(maskTextureListItem);

            API.setPlayerClothes(API.getLocalPlayer(), 1, maskModelSelection, maskTextureSelection);
        }
        if (item == maskTextureListItem) {
            maskTextureSelection = parseInt(item.IndexToItem(index));
            API.setPlayerClothes(API.getLocalPlayer(), 1, maskModelSelection, maskTextureSelection);
        }
    });

    maskMenu.OnItemSelect.connect(function (sender, item, index) {
        maskMenu.Visible = false;
        mainCharMenu.Visible = true;
    });

    maskMenu.ParentMenu = mainCharMenu;
    maskMenu.Visible = false;
}

function showMaskMenu() {
    mainCharMenu.Visible = false;
    maskMenu.Visible = true;
}

function createGlassesMenu() {
    glassesMenu = API.createMenu("Personaggio", 0, 0, 6);
    API.setMenuTitle(glassesMenu, "Occhiali");

    var glassesData;
    if (playerGender == "M") {
        glassesData = char_data.male.glasses;
    } else {
        glassesData = char_data.female.glasses;
    }

    var glassesModelList = new List(String);
    for (var i = 0; i < glassesData.length; i++) {
        glassesModelList.Add(glassesData[i].m.toString());
    }

    var glassesTextureList = new List(String);
    for (var i = 0; i < glassesData[0].t.length; i++) {
        var a = glassesData[0].t;
        glassesTextureList.Add(a[i].toString());
    }

    var glassesModelListItem = API.createListItem("Stile", "", glassesModelList, 0);
    var glassesTextureListItem = API.createListItem("Colore", "", glassesTextureList, 0);

    glassesMenu.AddItem(glassesModelListItem);
    glassesMenu.AddItem(glassesTextureListItem);

    glassesMenu.OnListChange.connect(function (sender, item, index) {
        if (item == glassesModelListItem) {

            glassesModelSelection = parseInt(item.IndexToItem(index));

            glassesTextureList = new List(String);
            for (var i = 0; i < glassesData[index].t.length; i++) {
                var a = glassesData[index].t;
                glassesTextureList.Add(a[i].toString());
            }

            glassesTextureSelection = parseInt(glassesTextureList[0]);

            maskMenu.RemoveItemAt(1);
            glassesTextureListItem = API.createListItem("Colore", "", glassesTextureList, 0);
            maskMenu.AddItem(glassesTextureListItem);

            API.setPlayerAccessory(API.getLocalPlayer(), 1, glassesModelSelection, glassesTextureSelection);
        }

        if (item == glassesTextureListItem) {
            glassesTextureSelection = parseInt(item.IndexToItem(index));
            API.setPlayerAccessory(API.getLocalPlayer(), 1, glassesModelSelection, glassesTextureSelection);
        }
    });

    glassesMenu.OnItemSelect.connect(function (sender, item, index) {
        glassesMenu.Visible = false;
        mainCharMenu.Visible = true;
    });

    glassesMenu.ParentMenu = mainCharMenu;
    glassesMenu.Visible = false;
}

function showGlassesMenu() {
    mainCharMenu.Visible = false;
    glassesMenu.Visible = true;
}

function createAccessoryMenu() {
    accessoryMenu = API.createMenu("Personaggio", 0, 0, 6);
    API.setMenuTitle(accessoryMenu, "Accessori");

    var accessoryData = null;
    if (playerGender == "M") {
        accessoryData = char_data.male.accessory;
    } else {
        accessoryData = char_data.female.accessory;
    }

    var accessoryModelList = new List(String);
    for (var i = 0; i < accessoryData.length; i++) {
        accessoryModelList.Add(accessoryData[i].m.toString());
    }

    var accessoryTextureList = new List(String);
    for (var i = 0; i < accessoryData[0].t.length; i++) {
        var a = accessoryData[0].t;
        accessoryTextureList.Add(a[i].toString());
    }

    var accessoryModelListItem = API.createListItem("Stile", "", accessoryModelList, 0);
    var accessoryTextureListItem = API.createListItem("Colore", "", accessoryTextureList, 0);

    accessoryMenu.AddItem(accessoryModelListItem);
    accessoryMenu.AddItem(accessoryTextureListItem);

    accessoryMenu.OnListChange.connect(function (sender, item, index) {

        if (item == accessoryModelListItem) {
            accessoryModelSelect = parseInt(item.IndexToItem(index));

            accessoryTextureList = new List(String);
            for (var i = 0; i < accessoryData[index].t.length; i++) {
                var a = accessoryData[index].t;
                accessoryTextureList.Add(a[i].toString());
            }

            accessoryTextureSelect = parseInt(accessoryTextureList[0]);

            accessoryMenu.RemoveItemAt(1);
            accessoryTextureListItem = API.createListItem("Colore", "", accessoryTextureList, 0);
            accessoryMenu.AddItem(accessoryTextureListItem);

            API.setPlayerClothes(API.getLocalPlayer(), 7, accessoryModelSelect, accessoryTextureSelect);
        }
        if (item == accessoryTextureListItem) {
            accessoryTextureSelect = parseInt(item.IndexToItem(index));
            API.setPlayerClothes(API.getLocalPlayer(), 7, accessoryModelSelect, accessoryTextureSelect);
        }
    });

    accessoryMenu.OnItemSelect.connect(function (sender, item, index) {
        accessoryMenu.Visible = false;
        mainCharMenu.Visible = true;
    });

    accessoryMenu.ParentMenu = mainCharMenu;
    accessoryMenu.Visible = false;
}

function showAccessoryMenu() {
    mainCharMenu.Visible = false;
    accessoryMenu.Visible = true;
}

function createEarringsMenu() {
    earringsMenu = API.createMenu("Personaggio", 0, 0, 6);
    API.setMenuTitle(earringsMenu, "Orecchini");

    var earringsData = null;
    if (playerGender == "M") {
        earringsData = char_data.male.earrings;
    } else {
        earringsData = char_data.female.earrings;
    }

    var earringsModelList = new List(String);
    for (var i = 0; i < earringsData.length; i++) {
        earringsModelList.Add(earringsData[i].m.toString());
    }

    var earringsTextureList = new List(String);
    for (var i = 0; i < earringsData[0].t.length; i++) {
        var a = earringsData[0].t;
        earringsTextureList.Add(a[i].toString());
    }

    var earringsModelListItem = API.createListItem("Stile", "", earringsModelList, 0);
    var earringsTextureListItem = API.createListItem("Colore", "", earringsTextureList, 0); 

    earringsMenu.AddItem(earringsModelListItem);
    earringsMenu.AddItem(earringsTextureListItem);

    earringsMenu.OnListChange.connect(function (sender, item, index) {
        if (item == earringsModelListItem) {
            earringsModelSelect = parseInt(item.IndexToItem(index));

            earringsTextureList = new List(String);
            for (var i = 0; i < earringsData[index].t.length; i++) {
                var a = earringsData[index].t;
                earringsTextureList.Add(a[i].toString());
            }

            earringsMenu.RemoveItemAt(1);
            earringsTextureListItem = API.createListItem("Colore", "", earringsTextureList, 0);
            earringsMenu.AddItem(earringsTextureListItem);

            earringsTextureSelect = parseInt(earringsTextureList[0]);

            API.setPlayerAccessory(API.getLocalPlayer(), 2, earringsModelSelect, earringsTextureSelect);
        }
        if (item == earringsTextureListItem) {
            earringsTextureSelect = parseInt(item.IndexToInt(index));
            API.setPlayerAccessory(API.getLocalPlayer(), 2, earringsModelSelect, earringsTextureSelect);
        }
    });

    earringsMenu.OnItemSelect.connect(function (sender, item, index) {
        earringsMenu.Visible = false;
        mainCharMenu.Visible = true;
    });

    earringsMenu.ParentMenu = mainCharMenu;
    earringsMenu.Visible = false;
}

function showEarringsMenu() {
    earringsMenu.Visible = true;
    mainCharMenu.Visible = false;
}

function createUndershirtMenu() {
    undershirtMenu = API.createMenu("Personaggio", 0, 0, 6);
    API.setMenuTitle(undershirtMenu, "Maglietta");

    var undershirtData = null;
    if (playerGender = "M") {
        undershirtData = char_data.male.undershirt;
    } else {
        undershirtData = char_data.female.undershit;
    }

    var undershirtModelList = new List(String);
    for (var i = 0; i < undershirtData.length; i++) {
        undershirtModelList.Add(undershirtData[i].m.toString());
    }

    var undershirtTextureList = new List(String);
    for (var i = 0; i < undershirtData[0].t.length; i++) {
        var a = undershirtData[0].t;
        undershirtTextureList.Add(a[i].t.toString());
    }

    var undershirtModelListItem = API.createListItem("Stile", "", undershirtModelList, 0);
    var undershirtTextureListItem = API.createListItem("Colore", "", undershirtTextureList, 0);

    undershirtMenu.AddItem(undershirtModelListItem);
    undershirtMenu.AddItem(undershirtTextureListItem);

    undershirtMenu.OnIndexChange.connect(function (sender, item, index) {
        if (item == undershirtModelListItem) {
            undershirtModelSelect = parseInt(item.IndexToItem(index));

            undershirtTextureList = new List(String);
            for (var i = 0; i < undershirtData[index].t.length; i++) {
                var a = undershirtData[index].t;
                undershirtTextureList.Add(a[i].t.toString());
            }

            undershirtMenu.RemoveItemAt(1);
            undershirtTextureListItem = API.createListItem("Colore", "", undershirtTextureList, 0);
            undershirtMenu.AddItem(undershirtTextureListItem);

            undershirtTextureSelect = parseInt(undershirtTextureList[0]);

            API.setPlayerClothes(API.getLocalPlayer(), 8, undershirtModelSelect, undershirtTextureSelect);
        }
        if (item == undershirtTextureListItem) {
            undershirtTextureSelect = parseInt(item.IndexToItem(index));
            API.setPlayerClothes(API.getLocalPlayer(), 8, undershirtModelSelect, undershirtTextureSelect);
        }
    });

    undershirtMenu.OnItemSelect.connect(function (sender, item, index) {
        undershirtMenu.Visible = false;
        mainCharMenu.Visible = true;
    });

    undershirtMenu.ParentMenu = mainCharMenu;

    undershirtMenu.Visible = false;
}

function showUndershirtMenu() {
    undershirtMenu.Visible = true;
    mainCharMenu.Visible = false;
}