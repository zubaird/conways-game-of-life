require 'pry'

class LifeBoard
	attr_accessor :number_of_columns, :number_of_rows, :array_grid

	def initialize(number_of_rows = 3, number_of_columns = 3)
		@number_of_rows = number_of_rows
		@number_of_columns = number_of_columns
		build_array_for_grid
		set_cells_row_address
	end

	def array_columns
		build_columns = Array.new
		i = 0
		while i < number_of_columns do 
			build_columns << Cell.new
			i += 1
		end
		build_columns
	end

	def build_array_for_grid
		@array_grid = Array.new

		number_of_rows.times do 
			@array_grid << array_columns
		end
		@array_grid
	end

	def set_cells_row_address
		i = 0
		j = 0
		while i < @array_grid.size do
			j = 0
			while j < @array_grid[i].size do 
				@array_grid[i][j].cell_address = [i,j]
				j += 1
			end	
			i += 1
		end

		@array_grid
	end
end

class Cell 

	attr_accessor :cell_address, :alive, :dead

	def initialize(cell_address = [1,1])
		alive
		@cell_address = cell_address
	end

	def current_cell_in(array_grid)
		column = @cell_address[0]
		row = @cell_address[1]
		current_cell = array_grid[row][column]
	end

	def alive
		alive = true
		dead = false
		"#"
	end

	def dead
		dead = true
		alive = false
		"-"
	end

	def cell_address=(value)
		@cell_address = value
	end


	def neighbours_in(array_grid)
		neighbour_group = []
		
		column = @cell_address[0] + 1
		row = @cell_address[1] + 1

		p column
		p row

		i = 0
		j = 0

		while i <= 2 do
			j = 0
			while j <= 2 do
				neighbour_group << array_grid[row - i][column - j].cell_address
				j += 1
			end
			i += 1
		end
		neighbour_group
	end

	def under_population(array_grid)
		
		alive_neighbours = 0
		

		neighbours_in(array_grid).each do |neighbouring_cell_address|
			column = neighbouring_cell_address[0]
			row = neighbouring_cell_address[1]
			alive_neighbours += 1 if array_grid[column][row].alive == true
		end

		current_cell_in(array_grid).dead if alive_neighbours <= 1
	end

end



