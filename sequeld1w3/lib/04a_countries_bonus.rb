# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE gdp > (
      SELECT
        MAX(gdp)
      FROM
        countries
      WHERE
        continent = 'Europe'
    )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      coun.continent, coun.name, coun.area
    FROM
      countries AS coun INNER JOIN
      (
        SELECT
          continent, MAX(area) AS max
        FROM
          countries
        GROUP BY
          continent
      ) AS biggest_countries
      ON coun.continent = biggest_countries.continent
    WHERE
      coun.area = biggest_countries.max;
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      all_countries.name, all_countries.continent
    FROM
      countries AS all_countries
    INNER JOIN
      (
        SELECT
          continent, MAX(population) AS max_pop
        FROM
          countries
        GROUP BY
          continent
      ) AS most_dense_countries
    ON all_countries.continent = most_dense_countries.continent
    INNER JOIN
    (
      SELECT
        smaller_countries.continent, MAX(smaller_countries.population) AS max_pop
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
      most_dense_countries.max_pop > second_most_dense_countries.max_pop * 3
      AND
      all_countries.population = most_dense_countries.max_pop
  SQL
end
