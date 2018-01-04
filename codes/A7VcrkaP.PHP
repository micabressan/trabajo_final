// Ajax
function get_comments(id) {
    $.ajax({
        url: path + 'User/get_comments',
        data: {recipient: id},
        success: function (response) {
			console.log(response);
            $('#tab-reviews').html(response);
        }
    });
}


// Controller
public function get_comments() {
    $data['comments'] = $this->helper->get_comments();
	$this->load->view('artist/partials/comments', $data);
}


// View
<div id="reviews">
    <div id="comments">
        <h2 class="fs-18"><?= ($total_comments > 1) ? $total_comments . ' ' . $this->lang->line('ratings') : $total_comments . ' ' .  $this->lang->line('ratings'); ?></h2>
        <ol class="commentlist">

            <?php
            if (!$comments):
                echo 'Esse artista não possui nenhuma avaliação!';
            else:
                foreach ($comments as $c):
                    ?>
                    <li class="comment even thread-even depth-1">
                        <div id="comment-13">
                            <div class="comment_container clearfix">
                                <img alt="" src="<?= get_image("users/{$c->user}", 'profile') ?>" class="avatar avatar-60 photo" style="width: 80px; height: 80px;">
                                <div class="comment-text">
                                    <p class="meta">
                                        <strong><?= $c->first_name . ' ' . $c->last_name; ?></strong> – <?= $this->helper->past_date($c->created_date); ?>  
                                        <img style="border: none;" src="<?= base_url("assets/_img/bigrating-{$c->stars}.png"); ?>" alt="">
                                       
                                    </p>
                                    <div class="description">
                                        <p><?= $c->comment; ?></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <?php
                endforeach;
            endif;
            ?>

        </ol>
    </div>

    <div class="clear">
    </div>
</div>