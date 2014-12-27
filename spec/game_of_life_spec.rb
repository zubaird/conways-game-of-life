require 'spec_helper'
require 'game-of-life'


describe LifeBoard do

	it "has a columns count" do 
		game = LifeBoard.new

		game.number_of_columns = 10

		expect(game.number_of_columns).to eq(10)
	end

	it "has a rows count" do
		game = LifeBoard.new

		game.number_of_rows = 10

		expect(game.number_of_rows).to eq(10)
	end

	it "is a size specified by the user" do
		game = LifeBoard.new(10,10)

		expect(game.number_of_rows).to eq(10)
		expect(game.number_of_columns).to eq(10)
	end

	it "builds columns" do
		game = LifeBoard.new(10,10)

		expected = 10
		
		expect(game.array_columns.size).to eq(expected)
	end

	# xit "builds a graphical grid based on rows x columns"  do
	# 	game = LifeBoard.new(10,10)

	# 	expected = [
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 		["#","#","#","#","#","#","#","#","#","#"],
	# 	]

	# 	expect(game.make_all_alive).to eq(expected)
	# end

	it "sets the cell row address" do

		game = LifeBoard.new(10,10)

		grid_address = [0,0]
		first_cell_address = game.array_grid[0][0].cell_address

		expect(first_cell_address).to eq(grid_address)
	end

end




describe Cell do 

	before do
		random_life = rand(0..100)
		@game = LifeBoard.new(10,10)
		@cell = Cell.new(random_life)
		@grid_rows = @game.array_grid
	end

	def each_square_is_a_cell?
		

		is_a_single_cell = true

		@grid_rows.each do |row|
			row.each do |square|
				is_a_single_cell = false if square.class != Cell
			end
		end

		return is_a_single_cell
	end

	it "occupies a single square on the LifeBoard" do
		expect(each_square_is_a_cell?).to eq(true)
	end

	it "looks like '#' when it is #alive" do
		random_life = rand(0..100)
		alive_cell = Cell.new(random_life)

		alive_cell.alive

		expect(alive_cell.icon).to eq("X")
	end

	it "looks like ' ' when #kill" do
		random_life = rand(0..100)
		dead_cell = Cell.new(random_life)

		dead_cell.kill

		expect(dead_cell.icon).to eq(" ")
	end

	it "knows its cell_address" do
		last_cell = @grid_rows[9][9]
		
		expect(last_cell.cell_address).to eq([9,9])
	end

	it "knows its neighbours" do

		neighbours = @grid_rows[5][5].neighbours_in(@grid_rows)

		expected = [
			[6,6],
			[6,5],
			[6,4],
			[5,6],
			[5,4],
			[4,6],
			[4,5],
			[4,4],
		]

		expect(neighbours).to eq(expected)
	end

	describe "#under_population" do 
		it 'cell dies when it has 1 or less live neighbours' do

			cell = @grid_rows[5][5]

			cell.alive

			@grid_rows[4][4].kill
			@grid_rows[4][5].kill
			@grid_rows[4][6].kill
			@grid_rows[5][4].kill
			@grid_rows[5][6].kill
			@grid_rows[6][4].kill
			@grid_rows[6][5].kill
			@grid_rows[6][6].kill

			cell.under_population(@grid_rows)


			expect(cell.is_not_alive?).to eq(true)
		end
	end

	describe "#over_population" do 
		it 'cell dies when it has 4 or more live neighbours' do
			cell = @grid_rows[5][5]

			cell.alive

			@grid_rows[4][4].alive
			@grid_rows[4][5].alive
			@grid_rows[4][6].alive
			@grid_rows[5][4].alive
			@grid_rows[5][6].kill
			@grid_rows[6][4].kill
			@grid_rows[6][5].kill
			@grid_rows[6][6].kill

			cell.over_population(@grid_rows)

			expect(cell.is_not_alive?).to eq(true)
		end
	end
	

	describe "#lives_on" do 
		it 'cell lives for another generation when it has 2 or 3 live neighbours' do
			cell = @grid_rows[5][5]

			cell.alive

			live_neighbour = @grid_rows[4][4].alive
			live_neighbour = @grid_rows[4][5].alive
			dead_neighbour = @grid_rows[4][6].kill
			dead_neighbour = @grid_rows[5][4].kill
			dead_neighbour = @grid_rows[5][6].kill
			dead_neighbour = @grid_rows[6][4].kill
			dead_neighbour = @grid_rows[6][5].kill
			dead_neighbour = @grid_rows[6][6].kill


			cell.lives_on(@grid_rows)

			expect(cell.is_alive?).to eq(true)
		end

		it 'is not born with only 2 live neighbors' do
			cell = @grid_rows[5][5]

			cell.kill

			live_neighbour = @grid_rows[4][4].alive
			live_neighbour = @grid_rows[4][5].alive
			dead_neighbour = @grid_rows[4][6].kill
			dead_neighbour = @grid_rows[5][4].kill
			dead_neighbour = @grid_rows[5][6].kill
			dead_neighbour = @grid_rows[6][4].kill
			dead_neighbour = @grid_rows[6][5].kill
			dead_neighbour = @grid_rows[6][6].kill


			cell.lives_on(@grid_rows)

			expect(cell.is_not_alive?).to eq(true)
		end
	end


	describe "#is_born" do 
		it 'cell is born or continues to live if it has exactly 3 live neighbours' do
			cell = @grid_rows[5][5]

			cell.kill

			live_neighbour = @grid_rows[4][4].alive
			live_neighbour = @grid_rows[4][5].alive
			dead_neighbour = @grid_rows[4][6].alive
			dead_neighbour = @grid_rows[5][4].kill
			dead_neighbour = @grid_rows[5][6].kill
			dead_neighbour = @grid_rows[6][4].kill
			dead_neighbour = @grid_rows[6][5].kill
			dead_neighbour = @grid_rows[6][6].kill


			cell.is_born(@grid_rows)

			expect(cell.is_alive?).to eq(true)
		end
	end

		describe "at the edge of grid" do 
		it 'should still work' do

			cell = @grid_rows[0][0]

			cell.alive

			@grid_rows[-1][-1].alive
			@grid_rows[-1][0].alive
			@grid_rows[-1][1].kill
			@grid_rows[0][-1].kill
			@grid_rows[0][1].kill
			@grid_rows[1][-1].kill
			@grid_rows[1][0].kill
			@grid_rows[1][1].kill

			cell.lives_on(@grid_rows)

			expect(cell.is_alive?).to eq(true)
		end
	end

end