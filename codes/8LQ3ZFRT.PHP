<?php 
    /*
     * @Route("/api/users/my",name="mylist_user")
     * @Method({"GET"})
     */
    public function mylistUser()
    {

       
        $em = $this->getDoctrine()->getManager();
		$user = $this->get('security.token_storage')->getToken()->getUser();
		$userId = $user->getId();
    
        $dql = "SELECT u FROM AppBundle:User u WHERE u.id != '".$userId."' ORDER BY u.id DESC";
        $result = $em->createQuery($dql)->execute();
        $friends=$user->getFriendList()->getValues();


        $formatted = [];
        foreach ($friends as $user) {
            $formatted[] = [
               'id' => $user->getId(),
               'username' => $user->getUsername(),
               'email' => $user->getEmail(),
            ];
        }

        return new JsonResponse($formatted);

    }