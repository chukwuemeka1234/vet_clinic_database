/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Agumon', '2020-02-03',  10.23, true, 0);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Gabumon', '2018-11-15', 8.0, true, 2);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts)
VALUES ('Pikachu', '2021-01-07', 15.04, false, 1);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, 
escape_attempts)
VALUES ('Devimon', '2017-05-12', 11.00, true, 5);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Charmander', '2020-02-08', 0, false, -11.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Plantmon', '2021-11-15', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Angemon', '2005-06-12', 1, true, -45.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Boarmon', '2005-06-07', 7, true, 20.40);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Blossom', '1998-10-13', 3, true, 17.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Ditto', '2022-05-14', 4, true, 22.00);

--owners table data

INSERT INTO owners (full_name, age)
VALUES('Sam Smith', 34);

INSERT INTO owners (full_name, age)
VALUES('Jennifer Orwell', 19);

INSERT INTO owners (full_name, age)
VALUES('Bob', 45);

INSERT INTO owners (full_name, age)
VALUES('Melody Pond', 77);

INSERT INTO owners (full_name, age)
VALUES('Dean Winchester', 14);

INSERT INTO owners (full_name, age)
VALUES('Jodie Whittaker', 38);

-- species table data

INSERT INTO species (name)
VALUES('Pokemon');

INSERT INTO species (name)
VALUES('Digimon');

-- Modify your inserted animals so it includes the species_id value:

    -- If the name ends in "mon" it will be Digimon

    UPDATE animals 
    SET 
        species_id = 2
    WHERE
        name LIKE '%mon';

    -- All other animals are Pokemon

    UPDATE animals 
    SET 
        species_id = 1
    WHERE
        species_id IS NULL;

    -- Modify your inserted animals to include owner information (owner_id):

    -- Sam Smith owns Agumon.
    UPDATE animals 
    SET 
        owner_id = 1
    WHERE
        name='Agumon';

    -- Jennifer Orwell owns Gabumon and Pikachu.    
     UPDATE animals 
    SET 
        owner_id = 2
    WHERE
        name='Gabumon' OR name='Pikachu';

-- Bob owns Devimon and Plantmon.
     UPDATE animals 
    SET 
        owner_id = 3
    WHERE
        name='Devimon' OR name='Plantmon';
    
    -- Melody Pond owns Charmander, Squirtle, and Blossom.
     UPDATE animals 
    SET 
        owner_id = 4
    WHERE
        name='Charmander' OR name='Squirtle' OR name='Blossom';

    -- Dean Winchester owns Angemon and Boarmon.
     UPDATE animals 
    SET 
        owner_id = 5
    WHERE
        name='Angemon' OR name='Boarmon';