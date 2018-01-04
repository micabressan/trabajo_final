  def trees() {
    val attrHeaders: List[String] =
      List("businessUnit", "subBU", "applicationSuite", "application")
    val structure = getStructure

    var tree = TreeBuilder("TR_Tree", "001", "01", attrHeaders, structure)

    var dictionary: Map[String, MutableList[String]] = Map()
    structure.records.foreach(record => {
      record.Properties.foreach(property => {
        if (!dictionary.contains(property._1)) {
          dictionary = dictionary + (property._1 -> MutableList(property._2))
        } else {
          if (!dictionary(property._1).contains(property._2)) dictionary(property._1) += property._2
        }
      })
    })

    //    dictionary.foreach(atrib => {
    //      println(atrib._1 + ":  ")
    //      atrib._2.foreach(value => {
    //        println("   " + value)
    //      })
    //    })
    //    tree.printDictionary()

    println("\n\n")

    //    tree.print() //false)

    println("\n\n\n")

    var rules = TreeRulesGenerator(structure)
    //var ruleDao = RedisRuleDao(RedisRuleDaoConf())
    //ruleDao.addRulesToKey(rules, "spark2-apps.oshipitcin.tree_rules")
    //    val rulesFromKey = ruleDao.getAllRulesFromKey("spark2-apps.oshipitcin.tree_rules")
    //    rulesFromKey.foreach(rule => {
    //      println(rule)
    //    })

    val status = TreeDTO.fromJson(tree.toString()).toString

    val expected = """Some({"name":"TR_Tree","treeId":"001","organizationId":"01","struct":["businessUnit","subBU","applicationSuite","application"],"dictionary":[{"Legal":"2","Not Set":"1","Reuters":"5","Financial & Risk":"4","Corporate":"3","GGO":"6"},{"Serengeti":"7","Legal":"2","Not Set":"1","Reuters":"8","Large Law Firms":"6","PME Product Development":"5","Corporate":"11","DCO":"3","F&R":"4","CMS":"10","GGO":"9"},{"Not Set":"1","Clear Suite":"6","Elite Applications":"4","C-enterpriseClientIdACK":"7","ConenterpriseClientIdact Express":"3","Project X":"2","THOMSON REUTERS LEGAL enterpriseClientIdACKER US INSTANCE (Formerly Serengeti enterpriseClientIdacker)":"5"},{"Not Set":"1","C-enterpriseClientIdACK":"9","ELITE 3E":"6","ConenterpriseClientIdact Express (Managed Service)":"3","Elite-Business Development Premier":"5","Project X":"2","E-BILLING HUB":"4","THOMSON REUTERS LEGAL enterpriseClientIdACKER US INSTANCE (Formerly Serengeti enterpriseClientIdacker)":"7","CLEAR":"8"}],"root":{"children":[{"children":[{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"Project X","code":1020020202,"nextCode":1020020203}],"level":3,"propertyName":"applicationSuite","value":"Project X","code":1020020200,"nextCode":1020020300},{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1020020101,"nextCode":1020020102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1020020100,"nextCode":1020020200},{"children":[{"children":[],"level":4,"propertyName":"application","value":"CLEAR","code":1020020608,"nextCode":1020020609}],"level":3,"propertyName":"applicationSuite","value":"Clear Suite","code":1020020600,"nextCode":1020020700}],"level":2,"propertyName":"subBU","value":"Legal","code":1020020000,"nextCode":1020030000},{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"ConenterpriseClientIdact Express (Managed Service)","code":1020050303,"nextCode":1020050304}],"level":3,"propertyName":"applicationSuite","value":"ConenterpriseClientIdact Express","code":1020050300,"nextCode":1020050400},{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1020050101,"nextCode":1020050102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1020050100,"nextCode":1020050200}],"level":2,"propertyName":"subBU","value":"PME Product Development","code":1020050000,"nextCode":1020060000},{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"E-BILLING HUB","code":1020060404,"nextCode":1020060405},{"children":[],"level":4,"propertyName":"application","value":"Elite-Business Development Premier","code":1020060405,"nextCode":1020060406},{"children":[],"level":4,"propertyName":"application","value":"ELITE 3E","code":1020060406,"nextCode":1020060407}],"level":3,"propertyName":"applicationSuite","value":"Elite Applications","code":1020060400,"nextCode":1020060500},{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1020060101,"nextCode":1020060102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1020060100,"nextCode":1020060200}],"level":2,"propertyName":"subBU","value":"Large Law Firms","code":1020060000,"nextCode":1020070000},{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"THOMSON REUTERS LEGAL enterpriseClientIdACKER US INSTANCE (Formerly Serengeti enterpriseClientIdacker)","code":1020070507,"nextCode":1020070508}],"level":3,"propertyName":"applicationSuite","value":"THOMSON REUTERS LEGAL enterpriseClientIdACKER US INSTANCE (Formerly Serengeti enterpriseClientIdacker)","code":1020070500,"nextCode":1020070600},{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1020070101,"nextCode":1020070102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1020070100,"nextCode":1020070200}],"level":2,"propertyName":"subBU","value":"Serengeti","code":1020070000,"nextCode":1020080000},{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"C-enterpriseClientIdACK","code":1020100709,"nextCode":1020100710}],"level":3,"propertyName":"applicationSuite","value":"C-enterpriseClientIdACK","code":1020100700,"nextCode":1020100800}],"level":2,"propertyName":"subBU","value":"CMS","code":1020100000,"nextCode":1020110000}],"level":1,"propertyName":"businessUnit","value":"Legal","code":1020000000,"nextCode":1030000000},{"children":[{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1030030101,"nextCode":1030030102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1030030100,"nextCode":1030030200}],"level":2,"propertyName":"subBU","value":"DCO","code":1030030000,"nextCode":1030040000},{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1030110101,"nextCode":1030110102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1030110100,"nextCode":1030110200}],"level":2,"propertyName":"subBU","value":"Corporate","code":1030110000,"nextCode":1030120000}],"level":1,"propertyName":"businessUnit","value":"Corporate","code":1030000000,"nextCode":1040000000},{"children":[{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1040040101,"nextCode":1040040102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1040040100,"nextCode":1040040200}],"level":2,"propertyName":"subBU","value":"F&R","code":1040040000,"nextCode":1040050000}],"level":1,"propertyName":"businessUnit","value":"Financial & Risk","code":1040000000,"nextCode":1050000000},{"children":[{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1050080101,"nextCode":1050080102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1050080100,"nextCode":1050080200}],"level":2,"propertyName":"subBU","value":"Reuters","code":1050080000,"nextCode":1050090000}],"level":1,"propertyName":"businessUnit","value":"Reuters","code":1050000000,"nextCode":1060000000},{"children":[{"children":[{"children":[{"children":[],"level":4,"propertyName":"application","value":"Not Set","code":1060090101,"nextCode":1060090102}],"level":3,"propertyName":"applicationSuite","value":"Not Set","code":1060090100,"nextCode":1060090200}],"level":2,"propertyName":"subBU","value":"GGO","code":1060090000,"nextCode":1060100000}],"level":1,"propertyName":"businessUnit","value":"GGO","code":1060000000,"nextCode":1070000000}],"level":0,"propertyName":"Root","value":"root","code":-1,"nextCode":-1},"ranks":[2,3,2,2]})"""

    println(status == expected)
    println(status)
    println(expected)

    val dao = RedisTreeDao()

    dao.deleteTreeByName(tree.name)
    dao.addTree(tree)

    val treeFromDao = dao.getTreeByName(tree.name)

    println(treeFromDao.toString)
    println(treeFromDao.toString == expected)

  }