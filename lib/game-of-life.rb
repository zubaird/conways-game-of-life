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
			random_life = rand(0..100)
			build_columns << Cell.new(random_life)
			i += 1
		end
		build_columns
	end

	def build_array_for_grid
		array_columns
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

	attr_accessor :cell_address, :alive, :life

	def initialize(random_life, cell_address = [1,1])
		if random_life.even?
			alive
		else
			kill
		end
		@cell_address = cell_address
	end

	def run(array_grid)
		neighbours_in(array_grid)
		under_population(array_grid)
		over_population(array_grid)
		lives_on(array_grid)
		is_born(array_grid)
	end

	def current_cell_in(array_grid)
		column = @cell_address[0]
		row = @cell_address[1]
		current_cell = array_grid[column][row]
	end

	def is_not_alive?
		@dead == true
	end

	def is_alive?
		@dead == false
	end

	def icon
		if is_not_alive?
			"0"
		else
			"X"
		end
	end

	def alive
		@dead = false
		@life = true
	end

	def kill
		@dead = true
		@life = false
	end

	def cell_address=(value)
		@cell_address = value
	end


	def neighbours_in(array_grid)
		neighbour_group = []
		current_cell_address = current_cell_in(array_grid).cell_address
		column = @cell_address[0] + 1
		row = @cell_address[1] + 1

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

		neighbour_group.delete(current_cell_address)
		neighbour_group
	end

	def under_population(array_grid)
		
		alive_neighbours_count = 0

		neighbours_in(array_grid).each do |neighbouring_cell_address|
			column = neighbouring_cell_address[0]
			row = neighbouring_cell_address[1]

			alive_neighbours_count += 1 if array_grid[column][row].is_alive? == true
		end

		current_cell_in(array_grid).kill if alive_neighbours_count <= 1
	end


	def over_population(array_grid)
		
		alive_neighbours_count = 0
		
		neighbours_in(array_grid).each do |neighbouring_cell_address|
			column = neighbouring_cell_address[0]
			row = neighbouring_cell_address[1]

			alive_neighbours_count += 1 if array_grid[column][row].is_alive? == true
		end

		current_cell_in(array_grid).kill if alive_neighbours_count >= 4
	end


	def lives_on(array_grid)

		alive_neighbours_count = 0
		
		neighbours_in(array_grid).each do |neighbouring_cell_address|
			column = neighbouring_cell_address[0]
			row = neighbouring_cell_address[1]
			alive_neighbours_count += 1 if array_grid[column][row].is_alive? == true
		end

		if alive_neighbours_count == 2 && current_cell_in(array_grid).is_alive?
			current_cell_in(array_grid).alive
		else
			current_cell_in(array_grid).kill
		end
	end

	def is_born(array_grid)

		alive_neighbours_count = 0

		neighbours_in(array_grid).each do |neighbouring_cell_address|
			column = neighbouring_cell_address[0]
			row = neighbouring_cell_address[1]
			alive_neighbours_count += 1 if array_grid[column][row].is_alive? == true
		end

		current_cell_in(array_grid).alive if alive_neighbours_count == 3
	end
end



