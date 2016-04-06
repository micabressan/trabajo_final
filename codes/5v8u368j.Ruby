  def disabled_options
    return ['%mb_reference%', '%mb_entity%', '%credit_card_link%'] if account.current_mb_provider.blank?
    return ['%credit_card_link%'] if account.current_mb_provider.blank? or !account.current_mb_provider.provider.supports_credit_card?
    []
  end