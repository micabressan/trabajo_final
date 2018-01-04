CREATE TABLE analytics_db.statevent (
  event_date Date DEFAULT CAST('1970-01-01' AS Date),
  created DateTime DEFAULT CAST('0000000000' AS DateTime),
  type FixedString(64) DEFAULT CAST('' AS FixedString(64)),
  value FixedString(512) DEFAULT CAST('' AS FixedString(512)),
  user_id UInt64 DEFAULT CAST(0 AS UInt64),
  customer_id FixedString(36) DEFAULT CAST('' AS FixedString(36)),
  anonymous_id FixedString(36) DEFAULT CAST('' AS FixedString(36)),
  reserve_id FixedString(36) DEFAULT CAST('' AS FixedString(36)),
  referer_host FixedString(256) DEFAULT CAST('' AS FixedString(256)),
  referer_url String DEFAULT '',
  utm_source FixedString(512) DEFAULT CAST('' AS FixedString(512)),
  utm_medium FixedString(512) DEFAULT CAST('' AS FixedString(512)),
  utm_term FixedString(512) DEFAULT CAST('' AS FixedString(512)),
  utm_content FixedString(512) DEFAULT CAST('' AS FixedString(512)),
  utm_campaign FixedString(512) DEFAULT CAST('' AS FixedString(512)),
  data_str String DEFAULT ''
) ENGINE = ReplacingMergeTree(
  event_date,
  (created, anonymous_id, type, value),
  8192
)