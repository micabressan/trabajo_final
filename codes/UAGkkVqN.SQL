$sql = "
UPDATE page
SET p_head = $this->headline,
p_content = $this->content,
p_createdate = $this->date
WHERE p_id = $this->pageId";