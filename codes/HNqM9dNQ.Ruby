def self.create_warnings
  three_days_after = Date.today + 3.days
  two_days_after = Date.today + 2.days
  Schedule.where(plan_expired_at: (two_days_after..three_days_after)).each do |schedule|
    Alert.create(user_id: schedule.user.id, alert_type: :warning, for_trial: schedule.trial, schedule_id: schedule.id)
  end
end