conn = PG.connect( dbname: 'Scraping', user: 'Taho', password: 'taho', host: 'localhost' )
Thread.new(links, sites) do |links, sites|
    while link = mutex.synchronize { links.pop }
      sleep(SLEEP_COUNTER)
      site = Homeaway.scrape
      mutex.synchronize { conn.exec("INSERT INTO listings(run_id, url, title, description, rating,
              region, properties, location, AdditionalCosts,
              cancellationPolicy, houseImages, owner, amenities,
              suitabilities, days) VALUES (1, '#{url}', '#{house[:Title]}',
              '#{conn.escape_string(house[:Description])}',
              '#{house[:Rating]}', '#{house[:Region]}',
              '#{house[:properties].to_json}',
              '#{house[:location].to_json}',
              '#{house[:AdditionalCosts].to_json}',
              'no cancellationPolicy',
              '#{house[:HouseImages].to_json}',
              '#{house[:Owner].to_json}',
              '#{house[:Amenities].to_json}',
              '#{house[:Suitabilities].to_json}',
              '#{house[:Days].to_json}')")
		}
    end
  end