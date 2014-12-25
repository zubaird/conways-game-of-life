require 'pry'

class LifeBoard

	attr_accessor :number_of_columns, :number_of_rows

	def initialize(number_of_rows = 3, number_of_columns = 3)
		@number_of_rows = number_of_rows
		@number_of_columns = number_of_columns
	end


	def array_columns
		build_columns = Array.new

		number_of_columns.times do 
			build_columns << "#"
		end
		build_columns
	end


	def build_array_for_grid
		array_grid = Array.new

		number_of_rows.times do 
			array_grid << array_columns
		end

		array_grid
	end


end
