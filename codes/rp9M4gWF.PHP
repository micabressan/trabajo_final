<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type"text/css">
table, td {
    border: 1px solid black;
}

table {
    border-collapse: collapse;
 }

td {
    
	text-align: center;
	font-family:"Comic Sans MS", cursive, sans-serif;
	font-size: 20px;
}

h1 {
    color: #008000;
	text-align: center;
	font-family:"Comic Sans MS", cursive, sans-serif;
}

td:hover {background-color: #66ff66	;}

</style>

</head>

<body style="background-image:url('sfondo.jpg')">

<?php
	$numeri= array();

	for($i=0;$i<90;$i++){
	$numeri[$i]=$i+1;
	}

	shuffle($numeri);



echo 'vettore=['.implode(',',$numeri).'];';
?>
	
<script>

var i=0;

function estrazione(){
	var vettore=[i];
	if(i<90){
		alert('vettore[i]');
		i++;
	}else{
		alert("mannagghia chitemmuertu");
	}
	}
</script>
<h1 >TOMBOLA NATALIZIA</h1>

<table style="float:right">
	<tr>
    <td height="50px" width='55'>1</td>
    <td height="50px"width='55'>2</td> 
    <td height="50px"width='55'>3</td>
	<td height="50px"width='55'>4</td>
    <td height="50px"width='55'>5</td>
<td height="50px"width='50' bgcolor="#008000"></td> 	
    <td height="50px"width='55'>6</td>
	<td height="50px"width='55'>7</td>
    <td height="50px"width='55'>8</td> 
    <td height="50px"width='55'>9</td>
	<td height="50px"width='55'>10</td>
  </tr>
  <tr>
    <td height="50px"width='55'>11</td>
    <td height="50px"width='55'>12</td> 
    <td height="50px"width='55'>13</td>
	<td height="50px"width='55'>14</td>
    <td height="50px"width='55'>15</td> 
<td height="50px"width='50' bgcolor="#008000"></td> 	
    <td height="50px"width='55'>16</td>
	<td height="50px"width='55'>17</td>
    <td height="50px"width='55'>18</td> 
    <td height="50px"width='55'>19</td>
	<td height="50px"width='55'>20</td>
  </tr>
  <tr>
    <td height="50px"width='55'>21</td>
    <td height="50px"width='55'>22</td> 
    <td height="50px"width='55'>23</td>
	<td height="50px"width='55'>24</td>
    <td height="50px"width='55'>25</td>
<td height="50px"width='50' bgcolor="#008000"></td> 	
    <td height="50px"width='55'>26</td>
	<td height="50px"width='55'>27</td>
    <td height="50px"width='55'>28</td> 
    <td height="50px"width='55'>29</td>
	<td height="50px"width='55'>30</td>
  </tr>
  <tr><td  height="20px" colspan="20" bgcolor="#008000"></td></tr>
  <tr>
    <td height="50px"width='55'>31</td>
    <td height="50px"width='55'>32</td> 
    <td height="50px"width='55'>33</td>
	<td height="50px"width='55'>34</td>
    <td height="50px"width='55'>35</td>
<td height="50px"width='50' bgcolor="#008000"></td> 		
    <td height="50px"width='55'>36</td>
	<td height="50px"width='55'>37</td>
    <td height="50px"width='55'>38</td> 
    <td height="50px"width='55'>39</td>
	<td height="50px"width='55'>40</td>
  </tr>
  <tr>
    <td height="50px"width='55'>41</td>
    <td height="50px"width='55'>42</td> 
    <td height="50px"width='55'>43</td>
	<td height="50px"width='55'>44</td>
    <td height="50px"width='55'>45</td>
<td height="50px"width='50' bgcolor="#008000"></td> 	 	
    <td height="50px"width='55'>46</td>
	<td height="50px"width='55'>47</td>
    <td height="50px"width='55'>48</td> 
    <td height="50px"width='55'>49</td>
	<td height="50px"width='55'>50</td>
  </tr>
  <tr>
    <td height="50px"width='55'>51</td>
    <td height="50px"width='55'>52</td> 
    <td height="50px"width='55'>53</td>
	<td height="50px"width='55'>54</td>
    <td height="50px"width='55'>55</td>
<td height="50px"width='50' bgcolor="#008000"></td> 		
    <td height="50px"width='55'>56</td>
	<td height="50px"width='55'>57</td>
    <td height="50px"width='55'>58</td> 
    <td height="50px"width='55'>59</td>
	<td height="50px"width='55'>60</td>
  </tr>
  <tr><td height="20px"colspan="20" bgcolor="#008000"></td></tr>
  <tr>
    <td height="50px"width='55'>61</td>
    <td height="50px"width='55'>62</td> 
    <td height="50px"width='55'>63</td>
	<td height="50px"width='55'>64</td>
    <td height="50px"width='55'>65</td>
<td height="50px"width='50' bgcolor="#008000"></td> 		
    <td height="50px"width='55'>66</td>
	<td height="50px"width='55'>67</td>
    <td height="50px"width='55'>68</td> 
    <td height="50px"width='55'>69</td>
	<td height="50px"width='55'>70</td>
  </tr>
  <tr>
    <td height="50px"width='55'>71</td>
    <td height="50px"width='55'>72</td> 
    <td height="50px"width='55'>73</td>
	<td height="50px"width='55'>74</td>
    <td height="50px"width='55'>75</td>
<td height="50px"width='50' bgcolor="#008000"></td> 	
    <td height="50px"width='55'>76</td>
	<td height="50px"width='55'>77</td>
    <td height="50px"width='55'>78</td> 
    <td height="50px"width='55'>79</td>
	<td height="50px"width='55'>80</td>
  </tr>
  <tr>
    <td height="50px"width='55'>81</td>
    <td height="50px"width='55'>82</td> 
    <td height="50px"width='55'>83</td>
	<td height="50px"width='55'>84</td>
    <td height="50px"width='55'>85</td>
<td height="50px"width='50' bgcolor="#008000"></td> 		
    <td height="50px"width='55'>86</td>
	<td height="50px"width='55'>87</td>
    <td height="50px"width='55'>88</td> 
    <td height="50px"width='55'>89</td>
	<td height="50px"width='55'>90</td>
  </tr>
 </table>
 <br>

 <center>
<button type="button" onclick="estrazione()">Estrai numero!</button>
<button type="button" value="nuova_partita" >Nuova partita</button>
 </center>
 
 </body>
</html>