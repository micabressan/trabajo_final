router.get('/:lang/:menu', (req, res, next) => {
    let lang = req.params.lang;

    let menu = menu_list.menu_list_get((result) => result);

    console.log(menu);

    res.render('index', {
        title: 'O Mnie',
        body_classes: ['about'],
        admin: false,
        menu: menu,
        langs: lang,
    });

    console.log(menu);
});