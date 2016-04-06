$("a.farm_icon_c, a.farm_icon_b, a.farm_icon_a").click(a)
function a()
{
	if ($("td#axe").text() > 0){
		$("th.fm_unit input")[0].checked=false;
		$("th.fm_unit input")[1].checked=false;
		$("th.fm_unit input")[2].checked=true;
		$("th.fm_unit input")[3].checked=false;
		$("th.fm_unit input")[4].checked=false;
		$("th.fm_unit input")[5].checked=false;
		$("th.fm_unit input")[6].checked=false;
		$("th.fm_unit input")[7].checked=false;
	}
	else{
		$("th.fm_unit input")[0].checked=false;
		$("th.fm_unit input")[1].checked=false;
		$("th.fm_unit input")[2].checked=false;
		$("th.fm_unit input")[3].checked=false;
		$("th.fm_unit input")[4].checked=true;
		$("th.fm_unit input")[5].checked=true;
		$("th.fm_unit input")[6].checked=true;
		$("th.fm_unit input")[7].checked=false;
	}
}