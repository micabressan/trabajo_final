HOW TO USE
1. Klik kanan di Halaman Kuisioner SIAM
2. Pilih Inpect Element
3. Pilih tab Console
4. Copy Paste kode di bawah
5. Enter

for(var i = 1; i <= 28; i++){
jQuery("#1_03").attr("checked",true);
jQuery("#1"+(i-1)+"_"+i+"3").attr("checked",true);
jQuery("#2_113").attr("checked",true);
jQuery("#2"+(i-1)+"_1"+(i+1)+"3").attr("checked",true);
jQuery("#28_203").attr("checked",true);
jQuery("#"+i+"_2"+(i-2)+"3").attr("checked",true);
}
document.getElementById('saran').value = '-';