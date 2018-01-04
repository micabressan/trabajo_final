function insertTournoi($nom, $idSaison, $inscrits) {

    $db = getDbInstance(null,null);
    $sql = 'insert into tournoi(nom, idSaison, inscrits)';
    $sql .= 'values(:nom_du_tournoi, :id_saison, :inscrits);';


    $saisonexists = selectFromWhereIdIs('saison','id',$idSaison);
    if(!$saisonexists || empty($saisonexists)){
        echo "Cette saison n'existe pas";
        return false;
    }


    $st = $db->prepare($sql);

    $ret = $st->execute(
        array(
            ":nom_du_tournoi" => $nom,
            ":id_saison" => $idSaison,
            ":inscrits" => $inscrits
        ));
    return $ret ;
}