$aaa=$aa[1];
                                    $abb=explode("?CAT",$aaa);
                                    $ac=parse_url($abb[0], PHP_URL_HOST);
                                    //Verificacion Urls Filtro 1, Si la url existe.
                                    if (($status[1] == 200)||($status[1] == 302))
                                    {
                                        //Verificación Urls Filtro 2, Si la url esta bloqueada
                                        if($ac<>"200.29.104.82")
                                            {
                                        $url22=parse_url($url);
										//var_dump($url22);
										$url3=$url22["host"];
										$hosts2 = dns_get_record($url3);
										//print_r($hosts2);
										$url4=$hosts2[0];
										$url4=$url4[ip];
										if($url4=="200.29.96.82") {
										$ns[]=$url;
                              $ns1++;
                              echo nl2br("La URL: ".$url." -> Esta Bloqueada por DNS");
                              ?>
                                  <html><img src="images/get_info_ssss.png" alt="loading..."></html>
                              <?php
                              echo nl2br(" \n");
										}
										else {
											$urldns=$url;
											$url5=parse_url($urldns);
										//var_dump($url5);
										$url7=$url5["path"];
										$hosts2 = dns_get_record($url7);
										//print_r($hosts2);
										$url8=$hosts2[0];
										$url8=$url8[ip];
										if($url8=="200.29.96.82") {
										$ns[]=$url;
                              $ns1++;
                              echo nl2br("La URL: ".$url." -> Esta Bloqueada por DNS");
                              ?>
                                  <html><img src="images/get_info_ssss.png" alt="loading..."></html>
                              <?php
                              echo nl2br(" \n");
										}
										else {
											$urldns1='http://'.$url;
											$url9=parse_url($urldns1);
											//var_dump($url5);
											$url10=$url9["host"];
											$hosts2 = dns_get_record($url10);
											//print_r($hosts2);
											$url11=$hosts2[0];
											$url11=$url11[ip];
											if($url11=="200.29.96.82") {
												//Creando Archivo de Urls DNS
												$ns[]=$url;
		                              $ns1++;
		                              echo nl2br("La URL: ".$url." -> Esta Bloqueada por DNS");
		                              ?>
		                                  <html><img src="images/get_info_ssss.png" alt="loading..."></html>
		                              <?php
		                              echo nl2br(" \n");
											}
											else {
	
		                              $nf[]=$url;
		                              $nf1++;
		                              echo nl2br("La URL: ".$url." -> No tiene Filtro de Emcali ");
		                              ?>
		                                  <html><img src="images/RemoveIcon.gif" alt="loading..."></html>
		                              <?php
		                              echo nl2br(" \n");
										}
										}
										}

                                            }
                                        else
                                            {
                                                //Creando Archivo de Urls ya Bloqueadas
                                                $eb[]=$url;
                                                $eb1++; 
                                                echo nl2br("La URL: ".$url." -> Ya se Encuentra Bloqueada ");
                                                ?>
                                                    <html><img src="images/icon_ok.png" alt="loading..."></html>
                                                <?php
                                                echo nl2br(" \n");
                                            }