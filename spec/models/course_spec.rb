# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course do
  subject { described_class }

  let(:course) { subject.new }

  before do
    course.title = 'Title'
    course.description = 'description'
    course.end_on = Time.zone.today
  end

  it { expect(course).to be_valid }

  describe 'Validations' do
    %i[title description end_on].each do |field|
      it { expect(course).to validate_presence_of(field) }
    end
  end

  describe 'Associations' do
    it { expect(course).to have_many(:movies).class_name('Movie').dependent(:nullify) }
end
end
