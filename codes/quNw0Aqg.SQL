BEGIN;
--
-- Create model DataSet
--
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NULL);
--
-- Create model Field
--
CREATE TABLE "data_field" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "num" integer NOT NULL, "dataset_id" integer NOT NULL REFERENCES "data_dataset" ("id"));
CREATE INDEX "data_field_dataset_id_f9f58395" ON "data_field" ("dataset_id");
COMMIT;
BEGIN;
--
-- Alter field lastupdate on dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("lastupdate" datetime NOT NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "origname" text NOT NULL, "engname" text NULL);
INSERT INTO "data_dataset" ("id", "origname", "engname", "lastupdate") SELECT "id", "origname", "engname", "lastupdate" FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
COMMIT;
BEGIN;
--
-- Create model DataSource
--
CREATE TABLE "data_datasource" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "url" varchar(200) NOT NULL);
COMMIT;
BEGIN;
--
-- Add field datasource to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NULL);
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id") SELECT "id", "lastupdate", "origname", "engname", 2 FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
--
-- Add field url to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NULL);
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id", "url") SELECT "id", "lastupdate", "origname", "engname", "datasource_id", NULL FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
--
-- Alter field engname on dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NULL, "engname" text NULL);
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "datasource_id", "url", "engname") SELECT "id", "lastupdate", "origname", "datasource_id", "url", "engname" FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
--
-- Alter field url on datasource
--
ALTER TABLE "data_datasource" RENAME TO "data_datasource__old";
CREATE TABLE "data_datasource" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "url" varchar(200) NULL);
INSERT INTO "data_datasource" ("id", "name", "url") SELECT "id", "name", "url" FROM "data_datasource__old";
DROP TABLE "data_datasource__old";
COMMIT;
BEGIN;
--
-- Create model ScienceField
--
CREATE TABLE "data_sciencefield" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "description" text NULL);
--
-- Add field sciencefield to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NULL, "sciencefield_id" integer NOT NULL REFERENCES "data_datasource" ("id"));
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id", "url", "sciencefield_id") SELECT "id", "lastupdate", "origname", "engname", "datasource_id", "url", 0 FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
COMMIT;
BEGIN;
--
-- Alter field url on datasource
--
ALTER TABLE "data_datasource" RENAME TO "data_datasource__old";
CREATE TABLE "data_datasource" ("url" varchar(200) NOT NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL);
INSERT INTO "data_datasource" ("id", "name", "url") SELECT "id", "name", coalesce("url", '0') FROM "data_datasource__old";
DROP TABLE "data_datasource__old";
COMMIT;
BEGIN;
--
-- Alter field engname on dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("engname" text NOT NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NULL, "sciencefield_id" integer NOT NULL REFERENCES "data_datasource" ("id"));
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "datasource_id", "url", "sciencefield_id", "engname") SELECT "id", "lastupdate", "origname", "datasource_id", "url", "sciencefield_id", coalesce("engname", '0') FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
--
-- Alter field url on dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "sciencefield_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NOT NULL);
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id", "sciencefield_id", "url") SELECT "id", "lastupdate", "origname", "engname", "datasource_id", "sciencefield_id", coalesce("url", '0') FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
--
-- Alter field description on sciencefield
--
ALTER TABLE "data_sciencefield" RENAME TO "data_sciencefield__old";
CREATE TABLE "data_sciencefield" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "description" text NOT NULL);
INSERT INTO "data_sciencefield" ("id", "name", "description") SELECT "id", "name", coalesce("description", '0') FROM "data_sciencefield__old";
DROP TABLE "data_sciencefield__old";
COMMIT;
BEGIN;
--
-- Add field description to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("description" text NOT NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NOT NULL, "sciencefield_id" integer NOT NULL REFERENCES "data_datasource" ("id"));
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id", "url", "sciencefield_id", "description") SELECT "id", "lastupdate", "origname", "engname", "datasource_id", "url", "sciencefield_id", '' FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
--
-- Add field metaid to sciencefield
--
ALTER TABLE "data_sciencefield" RENAME TO "data_sciencefield__old";
CREATE TABLE "data_sciencefield" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "description" text NOT NULL, "metaid" integer NOT NULL);
INSERT INTO "data_sciencefield" ("id", "name", "description", "metaid") SELECT "id", "name", "description", 1 FROM "data_sciencefield__old";
DROP TABLE "data_sciencefield__old";
COMMIT;
BEGIN;
--
-- Alter field metaid on sciencefield
--
ALTER TABLE "data_sciencefield" RENAME TO "data_sciencefield__old";
CREATE TABLE "data_sciencefield" ("metaid" integer NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "description" text NOT NULL);
INSERT INTO "data_sciencefield" ("id", "name", "description", "metaid") SELECT "id", "name", "description", "metaid" FROM "data_sciencefield__old";
DROP TABLE "data_sciencefield__old";
COMMIT;
BEGIN;
--
-- Add field size to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("size" integer NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NOT NULL, "sciencefield_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "description" text NOT NULL);
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id", "url", "sciencefield_id", "description", "size") SELECT "id", "lastupdate", "origname", "engname", "datasource_id", "url", "sciencefield_id", "description", NULL FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
--
-- Alter field sciencefield on dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NOT NULL, "description" text NOT NULL, "size" integer NULL, "sciencefield_id" integer NOT NULL REFERENCES "data_sciencefield" ("id"));
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id", "url", "description", "size", "sciencefield_id") SELECT "id", "lastupdate", "origname", "engname", "datasource_id", "url", "description", "size", "sciencefield_id" FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
COMMIT;
BEGIN;
--
-- Create model Author
--
CREATE TABLE "data_author" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "metaid" integer NULL);
--
-- Add field author to dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "lastupdate" datetime NOT NULL, "origname" text NOT NULL, "engname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NOT NULL, "sciencefield_id" integer NOT NULL REFERENCES "data_sciencefield" ("id"), "description" text NOT NULL, "size" integer NULL, "author_id" integer NOT NULL REFERENCES "data_author" ("id"));
INSERT INTO "data_dataset" ("id", "lastupdate", "origname", "engname", "datasource_id", "url", "sciencefield_id", "description", "size", "author_id") SELECT "id", "lastupdate", "origname", "engname", "datasource_id", "url", "sciencefield_id", "description", "size", 0 FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
CREATE INDEX "data_dataset_author_id_6b7b6b25" ON "data_dataset" ("author_id");
COMMIT;
BEGIN;
--
-- Alter field lastupdate on dataset
--
ALTER TABLE "data_dataset" RENAME TO "data_dataset__old";
CREATE TABLE "data_dataset" ("lastupdate" datetime NOT NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "origname" text NOT NULL, "engname" text NOT NULL, "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"), "url" varchar(200) NOT NULL, "sciencefield_id" integer NOT NULL REFERENCES "data_sciencefield" ("id"), "description" text NOT NULL, "size" integer NULL, "author_id" integer NOT NULL REFERENCES "data_author" ("id"));
INSERT INTO "data_dataset" ("id", "origname", "engname", "datasource_id", "url", "sciencefield_id", "description", "size", "author_id", "lastupdate") SELECT "id", "origname", "engname", "datasource_id", "url", "sciencefield_id", "description", "size", "author_id", "lastupdate" FROM "data_dataset__old";
DROP TABLE "data_dataset__old";
CREATE INDEX "data_dataset_datasource_id_d2e93328" ON "data_dataset" ("datasource_id");
CREATE INDEX "data_dataset_sciencefield_id_96434ee5" ON "data_dataset" ("sciencefield_id");
CREATE INDEX "data_dataset_author_id_6b7b6b25" ON "data_dataset" ("author_id");
COMMIT;
BEGIN;
--
-- Add field type to field
--
ALTER TABLE "data_field" RENAME TO "data_field__old";
CREATE TABLE "data_field" ("type" text NOT NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "num" integer NOT NULL, "dataset_id" integer NOT NULL REFERENCES "data_dataset" ("id"));
INSERT INTO "data_field" ("id", "name", "num", "dataset_id", "type") SELECT "id", "name", "num", "dataset_id", '0' FROM "data_field__old";
DROP TABLE "data_field__old";
CREATE INDEX "data_field_dataset_id_f9f58395" ON "data_field" ("dataset_id");
COMMIT;
BEGIN;
--
-- Add field contacts to author
--
ALTER TABLE "data_author" RENAME TO "data_author__old";
CREATE TABLE "data_author" ("contacts" text NULL, "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" text NOT NULL, "metaid" integer NULL);
INSERT INTO "data_author" ("id", "name", "metaid", "contacts") SELECT "id", "name", "metaid", NULL FROM "data_author__old";
DROP TABLE "data_author__old";
COMMIT;
BEGIN;
--
-- Add field sources to author
--
CREATE TABLE "data_author_sources" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "author_id" integer NOT NULL REFERENCES "data_author" ("id"), "datasource_id" integer NOT NULL REFERENCES "data_datasource" ("id"));
CREATE UNIQUE INDEX "data_author_sources_author_id_datasource_id_3f8a920a_uniq" ON "data_author_sources" ("author_id", "datasource_id");
CREATE INDEX "data_author_sources_author_id_d377c00e" ON "data_author_sources" ("author_id");
CREATE INDEX "data_author_sources_datasource_id_7267da24" ON "data_author_sources" ("datasource_id");
COMMIT;