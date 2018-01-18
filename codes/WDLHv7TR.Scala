var strona = 1
var elementyZeWszystkichStron: List[Element] = Nil
while(true) {
	val s = StronaZElementami(strona)
	strona++
	if(s.elementy.isEmpty)
		break
	elementyZeWszystkichStron += s.elementy
}