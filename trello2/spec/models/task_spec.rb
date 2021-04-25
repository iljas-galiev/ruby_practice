# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, :type => :model do
  subject {
    described_class.new(title: "Anything",
                        description: "Lorem ipsum",
                        created_at: DateTime.now.to_i)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "is valid without a description" do
    subject.description = nil
    expect(subject).to be_valid
  end
end