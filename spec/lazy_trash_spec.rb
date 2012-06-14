require 'spec_helper'

describe Hashie::LazyTrash do
  class ExampleTrash < Hashie::LazyTrash
    User = ""
    property :name
    property :email, :transform_with => lambda { |val| val.downcase }
    property :created_at, :from => :time, :with => lambda { |t| Time.parse(t) }
    property :user, :lazy => lambda { User.find_by_name(name) }
  end

  it "accepts a name" do
    ExampleTrash.new(:name => 'Christoph').name.should == 'Christoph'
    ExampleTrash.new("name" => 'Christoph').name.should == 'Christoph'
  end

  it "accepts an email and downcases it" do
    ExampleTrash.new(:email => 'Christoph@Example.com').email.should == 'christoph@example.com'
  end

  it "accepts a Time string and parses it" do
    time = Time.now
    ExampleTrash.new(:time => time.iso8601).created_at.to_i.should == time.to_i
  end

  it "allows to set created_at directly" do
    time = Time.now
    ExampleTrash.new(:created_at => time).created_at.should == time
  end

  it "silently ignores undefined properties" do
    lazy_trash = ExampleTrash.new(:undefined => 'foo')
    expect { lazy_trash.undefined }.to raise_error(NoMethodError)
  end

  it "evaluates lazy attributes on first access and caches them" do
    ExampleTrash::User.should_receive(:find_by_name).with('Christoph').once.and_return('A User object')
    lazy_trash = ExampleTrash.new(:name => 'Christoph')
    lazy_trash.user.should == 'A User object'
    lazy_trash.user.should == 'A User object'
  end

  it "allows to set lazy attributes explicitly" do
    ExampleTrash::User.should_not_receive(:find_by_name)
    lazy_trash = ExampleTrash.new(:user => 'A user')
    lazy_trash.user.should == 'A user'
  end
end