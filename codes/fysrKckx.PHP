<?php

use \Controllers\Admin\Controller;

if(!empty($args['id']) && !empty($args['order']) && !empty($args['token']) && $args['token'] === $app->getModule('Session\Session')->r('csrf')){
    $app->getDB()->query('SELECT * FROM d_articles WHERE hash_id = :id');

    $app->getDB()->bind(':id', $args['id']);

    $article = $app->getDB()->single();
    
    // Variables
    $newID = $article['orderID'];
    $direction = $args['order'];
    
    if($article){
        if($direction == 'up'){
            $newID++;
            
            $app->getDB()->query('SELECT id,orderID FROM d_articles WHERE orderID = :orderID');
            $app->getDB()->bind('orderID', $newID);
            $otherArticle = $app->getDB()->single();
        
            if($otherArticle){
                $otherArticle['orderID']--;
                
                //baisser l'id de $otherarticle
                $app->getDB()->query('UPDATE d_articles SET orderID = :neworderID WHERE id = :id');
                $app->getDB()->bind('neworderID', $otherArticle['orderID']);
                $app->getDB()->bind('id', $otherArticle['id']);
                $app->getDB()->execute();
                
                //augmenter l'id de $article
                $app->getDB()->query('UPDATE d_articles SET orderID = :neworderID WHERE id = :id');
                $app->getDB()->bind('neworderID', $newID);
                $app->getDB()->bind('id', $article['id']);
                $app->getDB()->execute();
            }
        }elseif($direction == 'down'){
            $newID--;
            
            $app->getDB()->query('SELECT id,orderID FROM d_articles WHERE orderID = :orderID');
            $app->getDB()->bind('orderID', $newID);
            $otherArticle = $app->getDB()->single();
        
            if($otherArticle){
                $otherArticle['orderID']++;
                
                //baisser l'id de $otherarticle
                $app->getDB()->query('UPDATE d_articles SET orderID = :neworderID WHERE id = :id');
                $app->getDB()->bind('neworderID', $otherArticle['orderID']);
                $app->getDB()->bind('id', $otherArticle['id']);
                $app->getDB()->execute();
                
                //augmenter l'id de $article
                $app->getDB()->query('UPDATE d_articles SET orderID = :neworderID WHERE id = :id');
                $app->getDB()->bind('neworderID', $newID);
                $app->getDB()->bind('id', $article['id']);
                $app->getDB()->execute();
            }
        }else{
            die('bad parameters or token');
        }
    }
    
    $app->getModule('Session\Advert')->setAdvert('success', 'L\'ordre des articles a été mis à jour');
    
    $app->redirect($app->config['paths']['admin'].'/manage/articles');
}else{
    die('bad parameters or token');
}