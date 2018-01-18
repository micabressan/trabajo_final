var page = 1
var list: List[PFWebsite] = Nil
while(true) {
	val pfw = PFWebsite(page)
	page = page + 1
	if(pfw.items.isEmpty)
		break
	list = pfw :: list
}