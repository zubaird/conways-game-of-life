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

		expected = ["#","#","#","#","#","#","#","#","#","#"]
		
		expect(game.array_columns).to eq(expected)
	end

	it "builds a graphical grid based on rows x columns"  do
		game = LifeBoard.new(10,10)

		expected = [
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
			["#","#","#","#","#","#","#","#","#","#"],
		]

		expect(game.build_array_for_grid).to eq(expected)
	end


end
