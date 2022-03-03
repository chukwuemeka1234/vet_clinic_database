/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends with "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE date_of_birth <  '2019-01-01' AND date_of_birth > '2016-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT * FROM animals WHERE neutered=true AND escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

--Begin transaction
--First transaction
BEGIN TRANSACTION;

--update the animals table by setting the species column to unspecified
UPDATE animals
SET species = 'unspecified';

SELECT species from animals;

--roll back the change and verify that species columns went back to the state before transaction.
ROLLBACK TRANSACTION;

SELECT species from animals;

--SECOND TRANSACTION
BEGIN TRANSACTION;

--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon
UPDATE animals
SET
     species = 'digimon'
WHERE
     name LIKE '%mon';

--Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
UPDATE animals
SET
     species = 'pokemon'
WHERE
     species IS NULL;

     COMMIT;

SELECT species FROM animals;

-- Inside a transaction delete all records in the animals table
TRUNCATE TABLE animals;

SELECT * FROM animals;

--then roll back the transaction
ROLLBACK TRANSACTION;

SELECT * FROM animals;

--Inside a transaction Delete all animals born after Jan 1st, 2022
BEGIN TRANSACTION;

DELETE
     FROM
         animals
    WHERE
         date_of_birth > '2022-01-01';

--Create a savepoint for the transaction.
SAVEPOINT SP1;

--Update all animals' weight to be their weight multiplied by -1.
UPDATE animals
SET weight_kg = weight_kg * -1;

--Rollback to the savepoint
ROLLBACK TO SP1;

SELECT * FROM animals;

--Commit transaction
COMMIT;

--queries to answer the following questions:

--How many animals are there?
SELECT
COUNT(name)
FROM
animals;

--How many animals have never tried to escape?
SELECT
COUNT(escape_attempts)
FROM animals
WHERE escape_attempts=0;

--What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;

--Who escapes the most, neutered or not neutered animals?
SELECT neutered,
SUM(escape_attempts)
FROM animals
GROUP BY neutered;

--What is the minimum and maximum weight of each type of animal?
SELECT species,
MIN(weight_kg) as MINweight, MAX(weight_kg) as MAXweight
FROM animals
GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
AVG(escape_attempts)
FROM
     animals
WHERE
     date_of_birth < '2000-01-01' AND date_of_birth > '1990-01-01' 
GROUP BY species;

 -- What animals belong to Melody Pond?
    SELECT  name as animal, full_name as owner
    FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE full_name = 'Melody Pond';

    -- List of all animals that are pokemon (their type is Pokemon).
       SELECT  a.name as animal
    FROM animals a
    INNER JOIN species s
    ON s.id = a.species_id
    WHERE s.name = 'Pokemon';

    -- List all owners and their animals, remember to include those that don't own any animal.
     SELECT full_name as owner, name as animal
    FROM animals
    RIGHT JOIN owners
    ON owners.id = animals.owner_id;

    -- How many animals are there per species?
      SELECT  s.name as species, COUNT(a.name) as AnimalsperSpecies
    FROM animals a
    INNER JOIN species s
    ON s.id = a.species_id
    GROUP BY s.name;

    -- List all Digimon owned by Jennifer Orwell.
     SELECT  name as animal, full_name as owner
    FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE full_name = 'Jennifer Orwell' AND animals.species_id=2;

    -- List all animals owned by Dean Winchester that haven't tried to escape.
    SELECT  name as animals
    FROM animals
    INNER JOIN owners
    ON owners.id = animals.owner_id
    WHERE full_name = 'Dean Winchester' AND animals.escape_attempts=0;

    -- Who owns the most animals?
     SELECT owners.full_name, COUNT(animals.name) AS total 
     FROM owners 
     LEFT JOIN animals ON 
     animals.owner_id=owners.id 
    GROUP BY owners.full_name 
    ORDER BY total DESC LIMIT 1;
