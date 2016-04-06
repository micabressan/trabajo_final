<?php
define('FACEBOOK_SDK_V4_SRC_DIR',  __DIR__ .'/facebook-php-sdk-v4-4.0-dev/src/Facebook/');
require __DIR__ .'/facebook-php-sdk-v4-4.0-dev/autoload.php';


use Facebook\FacebookSession;
use Facebook\FacebookRequest;
use Facebook\GraphUser;
use Facebook\FacebookRequestException;

function fbe_validate_session($appID,$appSecret){

FacebookSession::setDefaultApplication($appID, $appSecret);

// If you already have a valid access token:
$session = new FacebookSession($appID.'|'.$appSecret);


// To validate the session:
try {
	  $session->validate();
	  echo '<div class="updated" style="color:#222222; font-weight:700; font-size:1em; padding:10px">Settings Saved</div>';	

	} 
		catch (FacebookRequestException $ex) {
		// Session not valid, Graph API returned an exception with the reason.
		echo '<div class="error" style="color:#222222; font-weight:700; font-size:1em; padding:10px">'.$ex->getMessage().'</div>';
	} 
	catch (\Exception $ex) {
		// Graph API returned info, but it may mismatch the current app or have expired.
		echo '<div class="error" style="color:#222222; font-weight:700; font-size:1em; padding:10px">'.$ex->getMessage().'</div>';
	}

}
set_time_limit(1000000);

function fbe_facebook_sdk($facebook_page,$appID,$appSecret){


		FacebookSession::setDefaultApplication($appID,$appSecret);

		$session = FacebookSession::newAppSession();

		try {
			  $session->validate();
		} 
			
		catch (FacebookRequestException $ex) {
			echo $ex->getMessage();
		} 
			
		catch (\Exception $ex) {
			echo $ex->getMessage();
		}


		$i=0;
		$u=0;


		try{

			$eventResponse = (new FacebookRequest($session, 'GET', '/'.$facebook_page.'/events?fields=place,cover,attending_count,description,end_time,id,name,owner,start_time,ticket_uri,timezone&limit=99'))->execute()->getResponse();
			$events = $eventResponse->data;

			foreach ($events as $e) {	
				$session = FacebookSession::newAppSession();
				$venue = (new FacebookRequest($session, 'GET', '/'.$facebook_page.'?fields=phone,photos,username,about,category,cover,emails,general_info,general_manager,location,website&limit=99'))->execute()->getResponse();

				$startDate = $e->start_time;
				$endDate = $e->end_time;
				$timezone = $e->timezone;

				// Convert time for myEventON
				$c_evcal_srow = date("U",strtotime($startDate));
				$c_evcal_erow = date("U",strtotime($endDate));
				$custom_year = date("U",strtotime($StartDate));
				$c_event_year = gmdate("Y", $custom_year);
				//
				
				$category = $e->owner->category;


				$event_id = $e->id;
				$eId = wp_strip_all_tags($e->id);	
				$city = $e->place->location->city;
				$state = $e->place->location->state;
				$zip = $e->place->location->zip;
				$street = $e->place->location->street;
				$region = $e->place->location->region;
				$country = $e->place->location->country;
				$ticket_uri = $e->ticket_uri;
				$eventImage = $e->cover->source;
				$name = $e->place->name;
				$fb_event_uri = 'https://www.facebook.com/events/'.$event_id;
				$lat = $e->place->location->latitude;
				$long = $e->place->location->longitude;

				$venue_name = $e->place->name;
				$venue_phone = $venue->phone;
				$venue_desc = $venue->about;
				$emails = $venue->emails;
				$username = $venue->username; 
				$emailAddress = $emails[0];
				$venue_website = $venue->website;	
				$event_tag = $venue->category;	

				////PRINT
				////$posts_array = get_posts('post_type=post_title');
				////print_r($posts_array);
				//print_r($e->place->name);
				////PRINT
	
				if($state){
					$state = $state.'&nbsp;';
				}
				if($street){
					$street = $street.',&nbsp;';
				}
				if($city){
					$city = $city.',&nbsp;';
				}
				if($country){
					$country = $country.'&nbsp;';
				}
				if($region){
					$region = $region.'&nbsp;';
				}
				 if($zip){
					$zip = $zip.'&nbsp;';
				}

				$location = $street.$city.$state.$zip.$country.$region ;
				$location = str_replace('<<not-applicable>>', '', $location);
				if($location == '&nbsp;' || $location == '' ){
				$location = getaddress(get_fbe_field($lat),get_fbe_field($long));
				}


				$args = array (
				'post_type' => 'facebook_events',
				'posts_per_page' => -1,
				'meta_key' => 'facebook_event_id',
				'meta_query' => array(
						'key'		=> 'facebook_event_id',
						'value'		=> $event_id,
					),
				);
				
				$loop = new WP_Query( $args );
			    if( $loop->have_posts() ){ 
					$u++;	
					while ( $loop->have_posts() ) : $loop->the_post();
						
					  $post_id = get_the_ID();
					  $curEventImage = get_post_meta( $post_id, 'image_url', true );
					  $post_information = array(
							'post_type' => 'facebook_events',
							'ID' => $post_id,
							'post_title' => wp_strip_all_tags($e->name),
							'post_content' => wp_strip_all_tags($e->description),
							'tags_input' => $event_tag,
						);
						 
						if($eventImage != $curEventImage ){insert_image($eventImage,$post_id); }
						 
						wp_update_post( $post_information );
						
					endwhile;
				}
				else
				{ 
				$post_information = array(
					'post_type' => 'facebook_events',
					'post_title' => wp_strip_all_tags($e->name),
					'post_content' => wp_strip_all_tags($e->description),
					'post_status' => 'publish',
					'tags_input' => $event_tag,
				);		
	        
			 $post_id = wp_insert_post( $post_information ); 
			 insert_image($eventImage,$post_id); 
	           

			}
			/*	$i++;

				update_post_meta($post_id,'event_timezone',$timezone);
				update_post_meta($post_id,'start_time',$startDate);
				update_post_meta($post_id,'event_starts',$startDate);
				update_post_meta($post_id,'event_starts_sort_field',$startDate);
				update_post_meta($post_id,'event_ends',$endDate);
				update_post_meta($post_id,'end_time', $endDate);
				update_post_meta($post_id,'facebook_event_id', $eId);
				update_post_meta($post_id,'location',$location);
				update_post_meta($post_id,'ticket_uri',$ticket_uri);
				update_post_meta($post_id,'fb_event_uri',$fb_event_uri);
				update_post_meta($post_id,'geo_latitude',$lat);
				update_post_meta($post_id,'geo_longitude',$long);			
				update_post_meta($post_id,'venue_email',$emailAddress);	
				update_post_meta($post_id,'venue_phone',$phone);	
				update_post_meta($post_id,'venue_website',$website);
				update_post_meta($post_id,'facebook','https://facebook.com/'.$username);
				update_post_meta($post_id,'venue_desc',$venue_desc);
				update_post_meta($post_id,'venue_name',$venue_name);
				*/
			
				/////////////////////////////////////
				// Get the Old Post
				$old_post = get_post( $post_id );

				//$my_post_meta = get_post_meta($post_id, 'image_url', true);
				
				
				$args = array(
					'numberposts' => 1,
					'order'=> 'DESC',
					'post_mime_type' => 'image',
					'post_parent' => $post->ID,
					'post_type' => 'attachment'
					);

				$get_children_array = get_children($args,ARRAY_A);  //returns Array ( [$image_ID]... 
				$rekeyed_array = array_values($get_children_array);
				$child_image = $rekeyed_array[0];  

				// Show Facebook Events ID & Title
				echo "FB_Id		-$post_id<br>";
				echo "FB_Title	-$old_post->post_title <br>";


				//print_r($child_image);  	//Show the contents of the $child_image array.
				//echo "Show the $child_image ID";
				echo "Image_Id   -";
				echo $child_image['ID'];   	//Show the $child_image ID.
				echo "<br>";
				
				$post_image_media = get_post_meta($child_image['ID'], '_wp_attached_file', true);
				echo "Media_file - $post_image_media <br>"; //image location 2015/08/11800415_396471520542665_8991308386259432158_n142.jpg
				
				
				
				
				
				
				$new_post = array(
					'post_status'    => 'publish',
					'menu_order'     => $old_post->menu_order,
					'post_type'      => 'ajde_events',
					'comment_status' => $old_post->comment_status,
					'ping_status'    => $old_post->ping_status,
					'pinged'         => $old_post->pinged,
					'post_author'    => $old_post->post_author,
					'post_category'  => $old_post->post_category,
					'post_content'   => $old_post->post_content,
					'post_excerpt'   => $old_post->post_excerpt,
					'post_name'      => $old_post->post_name,
					'post_parent'    => $old_post->post_parent,
					'post_password'  => $old_post->post_password,
					'post_title'     => $old_post->post_title,
					'tags_input'     => $old_post->tags_input,
					'to_ping'        => $old_post->to_ping,
					'tax_input'      => $old_post->tax_input,
				);
				
				$new_post_id = wp_insert_post( $new_post ); 
				/////////////////////////////////////////
				update_post_meta($new_post_id,'_thumbnail_id', $child_image['ID']);
				
				echo "New_Post_Id- $new_post_id<br>";
				echo "$new_post_id - _thumbnail_id - ";
				echo $child_image['ID'];
				echo "<br>";
				echo "______________________ <br><br>";
				
				$i++;
				/*
				update_post_meta($new_post_id,'evcal_event_color', 206177);
				update_post_meta($new_post_id,'evcal_location', $location);
				update_post_meta($new_post_id,'evcal_location_name', $venue_name);
				update_post_meta($new_post_id,'evcal_name_over_img', no);
				//	update_post_meta($new_post_id,'evcal_organizer', HHHEventOrganizerNameHHH);
				//	update_post_meta($new_post_id,'evcal_org_contact', $emailAddress);
				//	update_post_meta($new_post_id,'evcal_lmlink', JJJEventLinkJJJ);
				update_post_meta($new_post_id,'evcal_subtitle', $venue_desc);
				update_post_meta($new_post_id,'evcal_gmap_gen', yes);
				update_post_meta($new_post_id,'evcal_repeat', no);
				update_post_meta($new_post_id,'evcal_rep_freq', daily);
				update_post_meta($new_post_id,'evcal_rep_gap', 1);
				update_post_meta($new_post_id,'evcal_rep_num', 1);
				update_post_meta($new_post_id,'evp_repeat_rb', dom);
				update_post_meta($new_post_id,'evo_repeat_wom', none);
				update_post_meta($new_post_id,'_evcal_exlink_option', 1);
				update_post_meta($new_post_id,'evo_hide_endtime', no);
				update_post_meta($new_post_id,'evo_span_hidden_end', no);
				update_post_meta($new_post_id,'evo_year_long', no);
				update_post_meta($new_post_id,'event_year', $c_event_year);
				update_post_meta($new_post_id,'evo_evcrd_field_org', no);
				update_post_meta($new_post_id,'evo_exclude_ev', no);
				update_post_meta($new_post_id,'_cancel', no);
				update_post_meta($new_post_id,'evcal_lat', $lat);
				update_post_meta($new_post_id,'evcal_lon', $long);
				update_post_meta($new_post_id,'evcal_srow', $c_evcal_srow);
				update_post_meta($new_post_id,'evcal_erow', $c_evcal_erow);
				update_post_meta($new_post_id,'_evcal_ec_f1a1_cus', Link);
				update_post_meta($new_post_id,'_evcal_ec_f1a1_cusL', $fb_event_uri);
				update_post_meta($new_post_id,' _evcal_ec_f1_onw', yes);
				update_post_meta($new_post_id,'_evcal_ec_f2a1_cus', Buy);
				update_post_meta($new_post_id,'_evcal_ec_f2a1_cusL', $ticket_uri);
				update_post_meta($new_post_id,'_evcal_ec_f2_onw', yes);
				*/
				
				// Image
			
				
				


			
				
			}  


			$a ='';
			$c ='';
			$n ='';

			$error ='';
			if($u > 1){
				$c = $u;
				$a = $i-$u;
				$n = 'updated';
			}
			
			else
			
			{
			$c = $i;
			$n = 'imported';
			}

		} 
	
		catch(Exception $ex){

			$error  = $ex->getCode();
			$errorMsg  = $ex->getMessage();

			if($error == 100 ){
				echo '<div class="error" style="color:#222222; font-weight:700; font-size:1em; padding:10px">Error '.$error.': <a href="https://www.facebook.com/'.$facebook_page.'/events" target="_blank">'.$facebook_page.'</a>. <i> Country or age restricted material. Check your app settings.</i> </div>';
			}
			
			else if ($error == 102){	
				echo '<div class="error" style="color:#222222; font-weight:700; font-size:1em; padding:10px">Error '.$error.': Session key invalid or no longer valid.</div>';
			}
			
			else
				
			{
				echo '<div class="error" style="color:#222222; font-weight:700; font-size:1em; padding:10px">Error '.$error.'&nbsp;'.$errorMsg .'&nbsp;: Troubleshooting tip <a href="https://developers.facebook.com/docs/marketing-api/error-reference" target="_blank">View API Error Codes</a></div>';
			}

		}
		
		if($a >= 1){
			echo '<div class="updated" style="color:#222222; font-weight:700; font-size:1em; padding:10px">'.$a. ' events added</div>';
		}
		
		if($i > 1){
			echo '<div class="updated" style="color:#222222; font-weight:700; font-size:1em; padding:10px">'.$c . ' events '.$n.'</div>';
		}
		
		else if($i == 0){
			 if($error != 100){
			 echo '<div class="updated" style="color:#222222; font-weight:700; font-size:1em; padding:10px">There are <b>no upcoming</b> events to import at <a href="https://www.facebook.com/'.$facebook_page.'/events" target="_blank">'.$facebook_page.'</a></div>';
				}
		}
		
		else
		
		{
			echo '<div class="updated" style="color:#222222; font-weight:700; font-size:1em; padding:10px">'.$c . ' event '.$n.'</div>';
		}

	}


	function insert_image($eventImage,$post_id){
	 	$image = $eventImage;

			$media = media_sideload_image($image, $post_id);

			if(!empty($media) && !is_wp_error($media)){
			    $args = array(
			        'post_type' => 'attachment',
			        'posts_per_page' => -1,
			        'post_status' => 'any',
			        'post_parent' => $post_id
			    );

			    $attachments = get_posts($args);

			    if(isset($attachments) && is_array($attachments)){
			        foreach($attachments as $attachment){
			            $image = wp_get_attachment_image_src($attachment->ID, 'full');
			            if(strpos($media, $image[0]) !== false){
			                set_post_thumbnail($post_id, $attachment->ID);
			                break;
			            }
			        }
			    }
			}
		update_post_meta($post_id,'image_url',$eventImage);
		
	}

		
?>