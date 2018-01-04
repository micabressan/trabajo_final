BEGIN;
--
-- Create model Author
--
CREATE TABLE "data_author" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "contacts" text NULL, "metaid" integer NULL);
--
-- Create model DataSet
--
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "size" integer NULL, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "url" varchar(200) NOT NULL, "description" text NOT NULL, "author_id" integer NOT NULL REFERENCES "data_author" ("id"));
--
-- Create model DataSource
--
CREATE TABLE "data_datasource" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "url" varchar(200) NOT NULL);
--
-- Create model Field
--
CREATE TABLE "data_field" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "num" integer NOT NULL, "type" text NOT NULL, "dataset_id" integer NOT NULL REFERENCES "data_dataset" ("id"));
--
-- Create model ScienceField
--
CREATE TABLE "data_sciencefield" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "description" text NOT NULL, "metaid" integer NULL);
--
-- Add field datasource to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "size" integer NULL, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "url" varchar(200) NOT NULL, "description" text NOT NULL, "author_id" integer NOT NULL REFERENCES "data_author" ("id"), "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"));
INSERT INTO "data_dataset" ("id", "size", "lastupdate", "origname", "engname", "url", "description", "author_id", "datasource_id") SELECT "id", "size", "lastupdate", "origname", "engname", "url", "description", "author_id", NULL FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_field_dataset_id_f9f58395" ON "data_field" ("dataset_id");
CREATE INDEX "data_dataset_author_id_6b7b6b25" ON "data_dataset" ("author_id");
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
--
-- Add field sciencefield to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "size" integer NULL, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "url" varchar(200) NOT NULL, "description" text NOT NULL, "author_id" integer NOT NULL REFERENCES "data_author" ("id"), "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "sciencefield_id" integer NOT NULL REFERENCES "data_sciencefield" ("id"));
INSERT INTO "data_dataset" ("id", "size", "lastupdate", "origname", "engname", "url", "description", "author_id", "datasource_id", "sciencefield_id") SELECT "id", "size", "lastupdate", "origname", "engname", "url", "description", "author_id", "datasource_id", NULL FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_author_id_6b7b6b25" ON "data_dataset" ("author_id");
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
--
-- Add field sources to author
--
CREATE TABLE "data_author_sources" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "author_id" integer NOT NULL REFERENCES "data_author" ("id"), "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"));
CREATE UNIQUE INDEX "data_author_sources_author_id_datasource_id_3f8a920a_uniq" ON "data_author_sources" ("author_id", "datasource_id");
CREATE INDEX "data_author_sources_author_id_d377c00e" ON "data_author_sources" ("author_id");
CREATE INDEX "data_author_sources_datasource_id_7267da24" ON "data_author_sources" ("datasource_id");
COMMIT;