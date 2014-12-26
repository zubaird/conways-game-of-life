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
		@game = LifeBoard.new(10,10)
		@cell = Cell.new
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
		expect(@cell.alive).to eq("#")
	end

	it "looks like '-' when it is #dead" do
		expect(@cell.dead).to eq("-")
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
			[5,5],
			[5,4],
			[4,6],
			[4,5],
			[4,4],
		]

		expect(neighbours).to eq(expected)
	end

	describe "#under_population" do 
		it 'cells die when it has 1 or less live neighbours' do

			die = @grid_rows[5][5].under_population(@grid_rows)

			expect(die).to eq("-")

		end
	end

	describe "#over_population" do 
		it 'cells die when it has 4 or more live neighbours'
	end
	
	describe "#lives_on" do 
		it 'cells live for another generation when it has 2 or 3 live neighbours'
	end


	describe "#is_born" do 
		it 'cell is born or continues to live if it has exactly 3 live neighbours'
	end

end