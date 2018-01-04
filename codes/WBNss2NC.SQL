CREATE TABLE meeting_templates (
  id SERIAL PRIMARY KEY
);
INSERT INTO meeting_templates (id) VALUES (1);
INSERT INTO meeting_templates (id) VALUES (2);

CREATE TABLE meeting_instances (
  id SERIAL PRIMARY KEY,
  template_id INT references meeting_templates(id)
);

INSERT INTO meeting_instances (template_id) VALUES (2);