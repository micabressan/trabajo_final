//список полей
fields.dump()
//список свойств объекта
obj.metaObject.getProperties()
//список методов по объекту
fields['SumSeviceList'].metaClass.methods*.name.sort().unique()