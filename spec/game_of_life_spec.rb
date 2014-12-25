require 'spec_helper'
require 'game-of-life'


describe LifeBoard do

	it "has a columns count" do 
		game = LifeBoard.new

		game.columns = 10

		expect(game.columns).to eq(10)
	end


	it "has a rows count" do
		game = LifeBoard.new

		game.rows = 10

		expect(game.rows).to eq(10)
	end

	it "is a size specified by the user" do
		game = LifeBoard.new(10,10)

		expect(game.rows).to eq(10)
		expect(game.columns).to eq(10)
	end


	it "it builds an array a graphical grid"  do
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
