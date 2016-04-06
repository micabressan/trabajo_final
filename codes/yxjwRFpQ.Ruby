    def validate_initiate_clash
      active_clash = ClashGame.find_by_player current_player
      send_error :clash_active, clash_id: active_clash.id if active_clash

      if @params[:mission_id].present? && @params[:target].blank?
        unless current_mission.training?
          check_mission = ClashGame::Clash::FinishGameHandler::AgainstMission::CorruptionPassage.errors_with_pass_mission?(current_player, current_mission, current_deck) if clash_against_mission?
          send_error :failed_to_initiate_clash_against_mission, check_mission if check_mission
          send_error :unusable_deck unless current_deck.usable?
        end
      else
        check_result = CorruptionClash.new(current_player, target_player, check: true).pounce
        send_error :clash_failure, check_result if check_result.status == :failure
      end
    end