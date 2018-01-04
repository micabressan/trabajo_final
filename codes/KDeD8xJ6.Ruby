private
  def schedule_notification_full_spins_unsafe
    return if @player_wheel.spins_count >= Constants::WHEEL_SPINS_MAX
    return if @player_wheel.free_spin_time_start == Constants::DEFAULT_MINUS_ONE

    profile       = AppInfo.instance.manager_profiles.get_profile_for(self)
    player_device = profile.last_used_device

    diff = Constants::WHEEL_SPINS_MAX - @player_wheel.spins_count

    full_spins_duration = Constants::WHEEL_SECONDS_PER_FREE_SPIN * diff


    utc_offset = player_device.utc_offset

    timestamp                      = @player_wheel.free_spin_time_start + full_spins_duration
    timestamp_on_player_device     = timestamp + utc_offset.hours
    time_now = Time.now
    timestamp_19_30 = time_now - time_now.utc_offset - timestamp_on_player_device

    full_spins_shedule_time = timestamp_19_30 < 0 ? timestamp_on_player_device + 1.day +
        timestamp_19_30 : timestamp_19_30


    # todo: implement
    timezone                = utc_offset >= 0 ? "+#{utc_offset}" : utc_offset.to_s
    # now = DateTime.now
    # DateTime.new([year=-4712[, month=1[, mday=1[, hour=0[, minute=0[, second=0[, offset=0[, start=Date::ITALY]]]]]]]])    ->  datetime
    # full_spins_timestamp = convert_timestamp_to_player_7_30PM(full_spins_timestamp)

    manager_devices         = AppInfo.instance.manager_devices

    manager_devices.unschedule_notification(self.id, EDeviceNotification::EDN_FULL_SPINS)
    manager_devices.send_notification_to(profile.last_used_device, EDeviceNotification::EDN_FULL_SPINS, timestamp)

    nil
  end