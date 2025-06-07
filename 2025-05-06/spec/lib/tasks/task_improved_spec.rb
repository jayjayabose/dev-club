# frozen_string_literal: true


require_relative '../../../lib/tasks/task_improved'

RSpec.describe TaskImproved do
  let(:description) { "Buy milk" }
  let(:history) { ["Buy groceries", "Buy milk"] }
  let(:task) { described_class.new(description, false, history) }

  #------------------------------------------------------------------------
  # Getters
  #------------------------------------------------------------------------

  describe '#description' do
    it 'returns the task description' do
      expect(task.description).to eq(description)
    end
  end

  describe '#completed' do
    it 'returns the completion status' do
      expect(task.completed).to be false
    end
  end

  describe '#history' do
    it 'returns the task history' do
      expect(task.history).to eq(history)
    end
  end

  #------------------------------------------------------------------------
  # Setters
  #------------------------------------------------------------------------

  describe '#description=' do
    it 'updates the task description' do
      new_description = "Buy organic milk"
      task.description = new_description
      expect(task.description).to eq(new_description)
    end
  end

  describe '#completed=' do
    it 'updates the completion status' do
      task.completed = true
      expect(task.completed).to be true
    end
  end

  describe '#history=' do
    it 'updates the task history' do
      new_history = ["Buy groceries", "Buy milk", "Buy organic milk"]
      task.history = new_history
      expect(task.history).to eq(new_history)
    end
  end

  #------------------------------------------------------------------------
  # Additional Methods
  #------------------------------------------------------------------------

  describe '#print' do
    it 'prints the task with correct format for incomplete task' do
      expect { task.print(0) }.to output("1. [ ] Buy milk\n").to_stdout
    end

    it 'prints the task with correct format for completed task' do
      task.completed = true
      expect { task.print(0) }.to output("1. [x] Buy milk\n").to_stdout
    end

    it 'prints the task with correct index' do
      expect { task.print(2) }.to output("3. [ ] Buy milk\n").to_stdout
    end
  end

  #------------------------------------------------------------------------
  # Integration Tests
  #------------------------------------------------------------------------

  describe 'task lifecycle' do
    it 'maintains history when description changes' do
      original_description = task.description
      task.description = "Buy organic milk"
      expect(task.history).to eq(history)
      expect(task.description).to eq("Buy organic milk")
    end

    it 'can be marked as completed and incomplete' do
      expect(task.completed).to be false
      task.completed = true
      expect(task.completed).to be true
      task.completed = false
      expect(task.completed).to be false
    end
  end
end 