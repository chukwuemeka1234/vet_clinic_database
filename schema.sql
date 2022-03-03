/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal,
    species varchar(255)
);

ALTER TABLE animals
ADD species varchar(255);

--Create a table named owners with the following columns:
CREATE TABLE owners (
  id integer GENERATED ALWAYS AS IDENTITY,
  full_name varchar(100),
  age integer,
  PRIMARY KEY(id)
);

--Create a table named species with the following columns:
CREATE TABLE species (
  id integer GENERATED ALWAYS AS IDENTITY,
  name varchar(100),
  PRIMARY KEY(id)
);

--Modify animals table:

--Make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE animals
DROP COLUMN id;

ALTER TABLE animals
ADD COLUMN id integer GENERATED ALWAYS AS IDENTITY;

ALTER TABLE animals
ADD PRIMARY KEY(id);

--Remove column species
ALTER TABLE animals
DROP COLUMN species;

--Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id integer;

ALTER TABLE animals
ADD FOREIGN KEY (species_id) REFERENCES species;

--Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id integer;

ALTER TABLE animals
ADD FOREIGN KEY (owner_id) REFERENCES owners;

-- Vet clinic database: add "join table" for visits

CREATE TABLE vets (
    id integer GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    age integer,
    date_of_graduation date,
    PRIMARY KEY(id)
);

-- Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations (
	vet_id integer NOT NULL,
	species_id integer NOT NULL,
	FOREIGN KEY (vet_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY (vet_id, species_id)
);

-- Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits (
	animal_id integer NOT NULL,
	vets_id integer NOT NULL,
    date_of_visit date,
	FOREIGN KEY (animal_id) REFERENCES animals (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY (date_of_visit, animal_id, vets_id)
);
