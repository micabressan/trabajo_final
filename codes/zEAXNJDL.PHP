    public function Update()
    {
        /*
            1-get data into variables 

            2-validation

            3-Database
        */
        
        if(isset($_GET['id']) && (int)$_GET['id']>0)
        {
            $id = (int)$_GET['id'];
            if(isset($_POST['addVideo']))
            {
                
                if(isset($_POST['title']) && isset($_POST['desc']) && isset($_POST['ytl']))
                {
                    
                    $title = $_POST['title'];
                    $desc  = $_POST['desc'];
                    $url   = $_POST['ytl'];
                    
                    //Validation
                
                    $vid = $this->getVid($url); //video id -_-
                    
                    //db
                    $data = array(
                      'title' => $title,  
                      'desc' => $desc,  
                      'vid' => $vid  
                    );
                    if($this->videoModel->Update($id,$data))
                    {
                        
                        System::Get('tpl')->assign('message','Video Added');
                        System::Get('tpl')->draw('success'); 
                    }
                    else
                    {
                        System::Get('tpl')->assign('message','Error cannot add new video');
                        System::Get('tpl')->draw('error');   
                    }
        
                }
                else
                {
                    System::Get('tpl')->assign('message','Error don\'t leave any form blank');
                    System::Get('tpl')->draw('error');       
                }
                
            }
            else
            {
                echo
                '
                <!DOCTYPE html>
                    <html>
                    <head>
                    <title>Page Title</title>
                    </head>
                        <body>
     
                            <form action="updatevideo.php" method="post" role="form">
                                   
                               Title:      <input name="title" type="text" required> <br />
                               description:<input name="desc" type="text"  required> <br />
                               url:        <input name="ytl" type="text"  required> <br />
                                               <input type="submit" name="addVideo" value="Add New Video" />
                            </form>
                               
                        </body>
                    </html>
               ';            
            }
        }
        else
        {
            "bye";
        }
    }