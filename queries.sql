/*Queries that provide answers to the questions from all projects.*/

SELECT *
FROM animals WHERE name LIKE '%mon';

SELECT *
FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-01-01';

SELECT *
FROM animals WHERE neutered IS true and escape_attempts < 3;

SELECT date_of_birth
FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts
FROM animals WHERE weight_kg > 10.5;

SELECT *
FROM animals WHERE neutered IS true;

SELECT *
FROM animals WHERE name!= 'Gabumon';

SELECT *
FROM animals WHERE weight_kg >= 10.4 and weight_kg <= 17.3;

/*Transaction Queries*/

BEGIN;
update animals set species = 'unspecified';
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * from animals;
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * from animals;
COMMIT;
SELECT * from animals;

BEGIN;
DELETE FROM animals;
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

BEGIN;
DELETE FROM animals where date_of_birth > '2022-01-01';
SELECT * from animals;
ROLLBACK;
SAVEPOINT SP1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * from animals;
ROLLBACK to SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
SELECT * from animals;
COMMIT;
SELECT * from animals;

/*Aggregate Functions and GROUP BY Queries*/

SELECT COUNT(name) FROM animals;
SELECT COUNT(escape_attempts) FROM animals where escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals group by neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals group by species;
SELECT species, date_of_birth, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' and '2000-01-01' group by species, date_of_birth;

/*Multiple Tables*/

SELECT name, full_name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT animals.name, species.name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT full_name, name
FROM animals
RIGHT JOIN owners
ON animals.owner_id = owners.id;

SELECT species.name, COUNT(animals.species_id)
FROM animals
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

SELECT animals.name, species.name, owners.full_name
FROM animals
INNER JOIN species
ON animals.species_id = species.id
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

SELECT animals.name, animals.escape_attempts, owners.full_name
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name AS name, COUNT(animals.owner_id) AS animal_count
FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
GROUP BY owners.full_name ORDER BY animal_count DESC LIMIT 1;
