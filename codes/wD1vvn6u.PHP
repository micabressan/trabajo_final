Code de la page pour voter :
<a href="pageVotesP.php?vote=1&post_id=<?= htmlspecialchars($data_perso['id_idx']) ?>&post_hero=<?= htmlspecialchars($data_perso['hero_order']) ?>&token=<?=$_SESSION['token']?>"><input type="button" class="p_button up " title="Cliquer pour voter, recliquer pour annuler votre vote"></a>

pageVotesP.php
if(!empty($_GET['vote']) && !empty($_GET['token']) && $_GET['token'] == $_SESSION['token']
    && !empty($_GET['post_id']) && is_numeric($_GET['post_id']
    && !empty($_GET['post_hero']) && is_numeric($_GET['post_hero'] ))) {
    if(!in_array($_GET['vote'], array('1', '-1'))) {
        exit('Le vote n'est pas valide.');
    }