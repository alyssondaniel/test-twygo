# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Movie do
  subject { described_class }

  let(:movie) { subject.new }

  before do
    movie.course = Course.new
    movie.url = 'http://localhost'
  end

  it { expect(movie).to be_valid }

  describe 'Associations' do
    it { expect(movie).to belong_to(:course).class_name('Course') }
  end

  describe 'Validations' do
    it { expect(movie).to validate_presence_of(:url) }
  end
end
