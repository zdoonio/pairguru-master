require "rails_helper"

describe titlebracketsvalidator do
  subject { validatable.new(title: title) }

  shared_examples "has valid title" do
    it "should be valid" do
      expect(subject).to be_valid
    end
  end

  shared_examples "has invalid title" do
    it "should not be valid" do
      expect(subject).not_to be_valid
    end
  end

  context "with curly brackets" do
    let(:title) { "the fellowship of the ring {peter jackson}" }
    it_behaves_like "has valid title"
  end

  context "with square brackets" do
    let(:title) { "the fellowship of the ring [lord of the rings]" }
    it_behaves_like "has valid title"
  end

  context "with not closed brackets" do
    let(:title) { "the fellowship of the ring (2001" }
    it_behaves_like "has invalid title"
  end

  context "with not opened brackets" do
    let(:title) { "the fellowship of the ring 2001)" }
    it_behaves_like "has invalid title"
  end

  context "with not too much closing brackets" do
    let(:title) { "the fellowship of the ring (2001) - 2003)" }
    it_behaves_like "has invalid title"
  end

  context "with not too much opening brackets" do
    let(:title) { "the fellowship of the ring (2001 - (2003)" }
    it_behaves_like "has invalid title"
  end

  context "with empty brackets" do
    let(:title) { "the fellowship of the ring ()" }
    it_behaves_like "has invalid title"
  end

  context "with brackets in wrong order" do
    let(:title) { "the fellowship of the )ring(" }
    it_behaves_like "has invalid title"
  end

  context "with matching brackets" do
    let(:title) { "the fellowship of the ring (2001)" }
    it_behaves_like "has valid title"
  end

  context "with multiple matching brackets" do
    let(:title) { "the fellowship of the ring [lord of the rings] (2001) {peter jackson}" }
    it_behaves_like "has valid title"
  end

  context "with nested matching brackets" do
    let(:title) { "the fellowship of the ring [lord of the rings {peter jackson}] (2012)" }
    it_behaves_like "has valid title"
  end

  context "with no brackets" do
    let(:title) { "lord of the rings" }
    it_behaves_like "has valid title"
  end
end

class validatable
  include activemodel::validations
  validates_with titlebracketsvalidator
  attr_accessor :title

  def initialize(title:)
    @title = title
  end
end
