# coding: utf-8

describe Hallon::User::Post do
  it { described_class.should include Hallon::Loadable }

  let(:tracks) do
    [].tap do |tracks|
      tracks << Hallon::Track.new(mock_track)
      tracks << Hallon::Track.new(mock_track_two)
    end
  end

  let(:post) do
    stub_session { Hallon::User::Post.create("burgestrand", "These be some tight tracks, yo!", tracks) }
  end

  describe ".new" do
    it "should be private" do
      Hallon::User::Post.should_not respond_to :new
    end
  end

  describe ".create" do
    it "should return nil if the inboxpost failed" do
      Spotify.should_receive(:inbox_post_tracks).and_return(null_pointer)
      post.should be_nil
    end
  end

  describe "#status" do
    it "should return the inbox post status" do
      post.status.should be :ok
    end
  end

  describe "#loaded?" do
    it "should return true only if the status is ok" do
      post.should_receive(:status).and_return(:is_loading)
      post.should_not be_loaded
    end

    it "should be true if the inbox post operation has completed" do
      post.should be_loaded
    end
  end

  describe "#message" do
    it "should return the message sent with the post" do
      post.message.should eq "These be some tight tracks, yo!"
    end
  end

  describe "#recipient" do
    it "should return the recipient" do
      post.recipient.should eq Hallon::User.new("burgestrand")
    end
  end

  describe "#recipient_name" do
    it "should return the username of the post recipient" do
      post.recipient_name.should eq "burgestrand"
    end
  end
end