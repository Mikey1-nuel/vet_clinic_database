/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Charmander', '2020-02-08', 0, false, -11.0);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Plantmon', '2021-11-15', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Angemon', '2005-06-12', 1, true, -45.0);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Blossom', '1998-10-13', 3, true, 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
    VALUES ('Ditto', '2022-05-14', 4, true, 22);

/*Owners Data*/

INSERT INTO owners (full_name, age)
    VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age)
    VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
    VALUES ('Bob', 45);
INSERT INTO owners (full_name, age)
    VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age)
    VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
    VALUES ('Jodie Whittaker', 38);

/*Species Data*/

INSERT INTO species (name)
    VALUES ('Pokemon');
INSERT INTO species (name)
    VALUES ('Digimon');

/*Update Animals Species_id*/
UPDATE animals
SET species_id = CASE
WHEN name LIKE '%mon' THEN (select id from species where name = 'Digimon')
ELSE (select id from species where name = 'Pokemon')
END;

/*Update Animals Owners_id*/

UPDATE animals
SET owner_id = CASE
WHEN name = 'Agumon' THEN (select id from owners where full_name = 'Sam Smith')
WHEN name IN ('Gabumon', 'Pikachu') THEN (select id from owners where full_name = 'Jennifer Orwell')
WHEN name IN ('Devimon', 'Plantmon') THEN (select id from owners where full_name = 'Bob')
WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (select id from owners where full_name = 'Melody Pond')
WHEN name IN ('Angemon', 'Boarmon') THEN (select id from owners where full_name = 'Dean Winchester')
ELSE NULL
END;

/*Insert the following data for vets*/

INSERT INTO vets (name, age, date_of_graduation)
    VALUES ('William Tatcher', 45, '2000-04-23');

INSERT INTO vets (name, age, date_of_graduation)
    VALUES ('Maisy Smith', 26, '2019-01-17');

INSERT INTO vets (name, age, date_of_graduation)
    VALUES ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO vets (name, age, date_of_graduation)
    VALUES ('Jack Harkness', 38, '2008-06-08');

/*Insertion for specializations*/

INSERT INTO specializations (specie_id, vet_id)
VALUES 
  ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
  ((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
  ((SELECT id FROM species WHERE name = 'Pokemon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
  ((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));

/*Insertion for visits*/

INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES 
  (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-05-24'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Agumon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-07-22'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Gabumon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-02'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-01-05'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-03-08'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Pikachu'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-05-14'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Devimon'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2021-05-04'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Charmander'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2021-02-24'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-12-21'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2020-08-10'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Plantmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2021-04-07'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Squirtle'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2019-09-29'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-10-03'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Angemon'),
    (SELECT id FROM vets WHERE name = 'Jack Harkness'),
    '2020-11-04'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-01-24'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2019-05-15'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-02-27'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Boarmon'),
    (SELECT id FROM vets WHERE name = 'Maisy Smith'),
    '2020-08-03'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'Stephanie Mendez'),
    '2020-05-24'
  ),
  (
    (SELECT id FROM animals WHERE name = 'Blossom'),
    (SELECT id FROM vets WHERE name = 'William Tatcher'),
    '2021-01-11'
  );
