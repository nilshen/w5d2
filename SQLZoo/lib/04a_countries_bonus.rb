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

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
  SELECT
    name
  FROM
    countries
  WHERE
    gdp > (
      SELECT
        MAX(gdp)
      FROM
        countries
      WHERE
        continent = 'Europe'
    );
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
  SELECT
    table1.continent,
    table1.name,
    table1.area
  FROM
    countries AS table1
  WHERE
    table1.area = (
      SELECT
        MAX(table2.area)
      FROM
        countries AS table2
      WHERE
        table1.continent = table2.continent
    );
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
  SELECT
    table1.name,
    table1.continent
  FROM
    countries AS table1
  WHERE
    table1.population > 3 * (
      SELECT
        table2.population
      FROM
        countries AS table2
      WHERE
        table1.continent = table2.continent
      ORDER BY
        table2.population DESC
      LIMIT
        1
      OFFSET
        1
    );
  SQL
end
