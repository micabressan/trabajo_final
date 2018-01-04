class A{
    B someObject
}

class B{
    C importantObject
}

class C{
    boolean interestingFlag
}

####
# LEFT JOIN
###

def result = A.withCriteria{
        createAlias('someObject', 'so', CriteriaSpecification.LEFT_JOIN)
        createAlias('so.importantObject', 'imp', CriteriaSpecification.LEFT_JOIN)
        or {
            isNull('so.importantObject')
            eq('imp.interestingFlag', false)
        } 

    }