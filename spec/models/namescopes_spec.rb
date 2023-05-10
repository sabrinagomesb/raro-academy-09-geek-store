# frozen_string_literal: true

RSpec.describe NameScopes do
  describe "Method name_contains" do
    let!(:state1) { FactoryBot.create(:state, name: "Minas Gerais") }
    let!(:state2) { FactoryBot.create(:state, name: "São Paulo") }

    it "should returns states that contain the given name" do
      result = State.name_contains("Minas")
      expect(result).to include(state1)
      expect(result).not_to include(state2)
    end

    it "should returns all states when no name is given" do
      result = State.name_contains(nil)
      expect(result).to include(state1, state2)
    end
  end

  describe "Method by_name" do
    let!(:state1) { FactoryBot.create(:state, name: "Minas Gerais") }
    let!(:state2) { FactoryBot.create(:state, name: "São Paulo") }

    it "should returns states that contain the given name" do
      result = State.by_name("Minas Gerais")
      expect(result).to include(state1)
      expect(result).not_to include(state2)
    end

    it "should returns a empty array when don't find a match " do
      result = State.by_name("Ceará")
      expect(result).to be_empty
    end
  end
end
