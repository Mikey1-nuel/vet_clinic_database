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

--Who was the last animal seen by William Tatcher?

SELECT visits.id, animals.name, vets.name
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher' ORDER BY visits.id DESC LIMIT 1;

--How many different animals did Stephanie Mendez see?

SELECT COUNT(animals.id)
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

--List all vets and their specialties, including vets with no specialties.

SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations
ON specializations.vet_id = vets.id
LEFT JOIN species
ON specializations.specie_id = species.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.

SELECT visits.id, animals.name, vets.name, visits.date_of_visit
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

--What animal has the most visits to vets?

SELECT COUNT(visits.animal_id) AS visit_count, animals.name
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
GROUP BY visits.animal_id, animals.name ORDER BY visit_count DESC LIMIT 1;

--Who was Maisy Smith's first visit?

SELECT visits.id, animals.name, vets.name
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith' LIMIT 1;

--Details for most recent visit: animal information, vet information, and date of visit.

SELECT visits.id, animals.name, vets.name, visits.date_of_visit AS date
FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON visits.vet_id = vets.id
WHERE date_of_visit BETWEEN '2019-01-01' AND '2021-12-31' ORDER BY date DESC;

--How many visits were with a vet that did not specialize in that animal's species?

SELECT COUNT(*) AS number_of_visits FROM visits
JOIN animals ON animals.id = visits.animal_id
LEFT JOIN specializations ON animals.species_id = specializations.specie_id
AND specializations.vet_id = visits.vet_id
WHERE specializations.specie_id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.

SELECT name, COUNT(*) AS total
FROM (SELECT animals.species_id FROM (SELECT id FROM vets WHERE name = 'Maisy Smith') as vet
JOIN visits ON visits.vet_id = vet.id
JOIN animals ON animals.id = visits.animal_id) as all_visits
JOIN species ON all_visits.species_id = species.id
GROUP BY name 
ORDER BY total DESC LIMIT 1;
