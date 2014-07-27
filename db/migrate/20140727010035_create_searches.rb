class CreateSearches < ActiveRecord::Migration
 def up
 		ActiveRecord::Base.connection.execute <<-SQL
		 	CREATE VIEW searches AS

		  SELECT
		    categories.id AS searchable_id,
		    'Category' AS searchable_type,
		    categories.name AS term
		  FROM categories

		  UNION

		  SELECT
		    diseases.id AS searchable_id,
		    'Disease' AS searchable_type,
		    diseases.name AS term
		  FROM diseases
		SQL

	end
end
