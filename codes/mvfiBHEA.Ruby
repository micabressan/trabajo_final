# Presence updates:
roster.add_presence_callback { |item,oldpres,pres|
  # Can't look for something that just does not exist...
  if pres.nil?
    # ...so create it:
    pres = Jabber::Presence.new
  end
  if oldpres.nil?
    # ...so create it:
    oldpres = Jabber::Presence.new
  end

  # Print name and jid:
  name = "#{pres.from}"
  if item.iname
    name = "#{item.iname} (#{pres.from})"
  end
  puts(name)

  # Print type changes:
  unless oldpres.type.nil? && pres.type.nil?
    puts("  Type: #{oldpres.type.inspect} -> #{pres.type.inspect}")
  end
  # Print show changes:
  unless oldpres.show.nil? && pres.show.nil?
    puts("  Show:     #{oldpres.show.to_s.inspect} -> #{pres.show.to_s.inspect}")
  end
  # Print status changes:
  unless oldpres.status.nil? && pres.status.nil?
    puts("  Status:   #{oldpres.status.to_s.inspect} -> #{pres.status.to_s.inspect}")
  end
  # Print priority changes:
  unless oldpres.priority.nil? && pres.priority.nil?
    puts("  Priority: #{oldpres.priority.inspect} -> #{pres.priority.inspect}")
  end

  # Note: presences with type='error' will reflect our own show/status/priority
  # as it is mostly just a reply from a server. This is *not* a bug.
}