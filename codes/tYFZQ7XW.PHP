    $req = $dbgame->prepare('SELECT COUNT(id) AS nb_votes, vote FROM cms_player_vote WHERE account_id = :account_id AND player_id = :post_id OR player_hero_oder = :post_hero');
    $req->execute(array('account_id' => $_SESSION['id'],
                        'post_id' => $_GET['post_id'],
                        'post_hero' => $_GET['post_hero']));
						
    $vote = $req->fetch();
    if($vote['nb_votes'] > 0) {
        //L'utilisateur a d?j? vot? (on supprime le vote)
        $req = $dbgame->prepare('DELETE FROM cms_player_vote WHERE player_id = :post_id AND player_hero_oder = :post_hero OR account_id = :account_id');
        $req->execute(array('post_id' => $_GET['post_id'],
							'post_hero' => $_GET['post_hero'],
                            'account_id' => $_SESSION['id']));
    }
    if($_GET['vote'] != $vote['vote']) {
    /*
        On prend en compte le vote si le vote pass? dans l'url n'est pas le m?me que celui pr?c?dement supprim?
        sinon la suppression n'aura servie ? rien.
    */
    $req = $dbgame->prepare('INSERT INTO cms_player_vote(vote, player_id, player_hero_oder, account_id) VALUES(:vote, :post_id, :post_hero, :account_id)');
    $req->execute(array('vote' => $_GET['vote'],
                        'post_id' => $_GET['post_id'],
						'post_hero' => $_GET['post_hero'],
                        'account_id' => $_SESSION['id']));