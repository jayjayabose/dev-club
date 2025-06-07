# frozen_string_literal: true

require 'sorbet-runtime'
require_relative '../../../lib/tasks/list_tasks_improved'
require_relative '../../../lib/tasks/task_improved'
require_relative '../../../lib/tasks/task_interface'

RSpec.describe ListTasksImproved do
  let(:tasks) { [] }
  let(:key) { 1 }
  let(:list_tasks) { described_class.new(tasks, key) }

  describe '#initialize' do
    it 'initializes with tasks and key' do
      expect(list_tasks.instance_variable_get(:@tasks)).to eq(tasks)
      expect(list_tasks.instance_variable_get(:@key)).to eq(key)
      expect(list_tasks.instance_variable_get(:@description)).to eq('List tasks')
    end
  end

  describe '#do' do
    it 'returns the tasks array' do
      expect(list_tasks.do).to eq(tasks)
    end

    context 'when tasks array is empty' do
      it 'displays "No tasks yet!" message' do
        expect { list_tasks.do }.to output("No tasks yet!\n").to_stdout
      end
    end

    context 'when tasks array has items' do
      let(:task1) { TaskImproved.new('Buy milk', false, []) }
      let(:task2) { TaskImproved.new('Walk dog', true, []) }
      let(:tasks) { [task1, task2] }

      it 'displays tasks in the correct format' do
        expected_output = <<~OUTPUT
          --- Your Todo List ---
          1. [ ] Buy milk
          2. [x] Walk dog
          -----------------------
        OUTPUT

        expect { list_tasks.do }.to output(expected_output).to_stdout
      end
    end

    context 'when tasks have history' do
      let(:task1) { TaskImproved.new('Buy milk', false, ['Get milk', 'Buy milk']) }
      let(:task2) { TaskImproved.new('Walk dog', true, ['Take dog out', 'Walk the dog', 'Walk dog']) }
      let(:tasks) { [task1, task2] }

      it 'displays tasks with current description only' do
        expected_output = <<~OUTPUT
          --- Your Todo List ---
          1. [ ] Buy milk
          2. [x] Walk dog
          -----------------------
        OUTPUT

        expect { list_tasks.do }.to output(expected_output).to_stdout
      end
    end
  end

  describe '#description' do
    it 'returns the description' do
      expect(list_tasks.description).to eq('List tasks')
    end
  end

  describe '#key' do
    it 'returns the key' do
      expect(list_tasks.key).to eq(key)
    end
  end


end
