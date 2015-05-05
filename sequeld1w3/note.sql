SELECT
  all_countries.name, all_countries.continent
FROM
  countries AS all_countries
  INNER JOIN(
    SELECT
      continent, MAX(population) AS max_pop
    FROM
      countries
    GROUP BY
      continent
  ) AS most_dense_countries
    ON all_countries.continent = most_dense_countries.continent
  INNER JOIN(
    SELECT
      smaller_countries.continent, MAX(smaller_countries.population)
    FROM
     countries AS smaller_countries
     INNER JOIN
      (
        SELECT
          continent, MAX(population) AS max_pop
        FROM
          countries
        GROUP BY
          continent
      ) AS big_countries
      ON smaller_countries.continent = big_countries.continent
      WHERE
        smaller_countries.population < big_countries.max_pop
      GROUP BY
        smaller_countries.continent
  ) AS second_most_dense_countries
    ON all_countries.continent = second_most_dense_countries.continent
WHERE
  most_dense_countries.max_pop > second_most_dense_counties.max_pop * 3






SELECT
  continent, MAX(population) AS max_pop
FROM
  countries
GROUP BY
  continent




  SELECT
    smaller_countries.continent, MAX(smaller_countries.population)
  FROM
   countries AS smaller_countries
   INNER JOIN
    (
      SELECT
        continent, MAX(population) AS max_pop
      FROM
        countries
      GROUP BY
        continent
    ) AS big_countries
    ON smaller_countries.continent = big_countries.continent
    WHERE
      smaller_countries.population < big_countries.max_pop
    GROUP BY
      smaller_countries.continent
