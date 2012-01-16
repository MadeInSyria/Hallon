# coding: utf-8
require 'timeout'

describe Hallon::AudioQueue do
  let(:queue) { Hallon::AudioQueue.new(4) }
  subject { queue }

  it "should conform to the example specification of its’ documentation" do
    queue.push([1, 2]).should eq 2
    queue.push([3]).should eq 1
    queue.push([4, 5, 6]).should eq 1
    queue.push([5, 6]).should eq 0
    queue.pop(1).should eq [1]
    queue.push([5, 6]).should eq 1
    queue.pop.should eq [2, 3, 4, 5]
  end

  describe "#pop" do
    it "should not block if the queue is not empty" do
      queue.push([1, 2])

      start = Time.now
      queue.pop.should eq [1, 2]
      (Time.now - start).should be_within(0.001).of(0)
    end

    it "should block if the queue is empty" do
      queue.size.should be_zero

      # I could mock out ConditionVariable and Mutex, but where’s the fun in that?
      start = Time.now
      Thread.start { sleep 0.2; queue.push([1]) }
      queue.pop.should eq [1]
      (Time.now - start).should be_within(0.08).of(0.2)
    end
  end

  describe "#clear" do
    it "should clear the queue" do
      queue.push([1, 2])
      queue.should_not be_empty
      queue.clear
      queue.should be_empty
    end
  end

  describe "#synchronize" do
    it "should be re-entrant" do
      expect { queue.synchronize { queue.synchronize {} } }.to_not raise_error
    end
  end

  describe "#new_cond" do
    it "should be bound to the queue" do
      condvar = queue.new_cond
      inside  = false

      thr = Thread.new(queue, condvar) do |q, c|
        q.synchronize do
          inside = true
          c.signal
        end
      end

      Timeout::timeout(1) do
        queue.synchronize do
          condvar.wait_until { inside }
        end
      end

      inside.should be_true
    end
  end
end