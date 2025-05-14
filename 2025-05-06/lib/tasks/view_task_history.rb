# frozen_string_literal: true
# typed: strict

require_relative './shared_behavior/task_index_getter'
require_relative './shared_behavior/print_tasks'

class ViewTaskHistory
  extend T::Sig
  include Action

  sig { override.returns(Integer) }
  def key
    @key
  end

  sig { override.returns(String) }
  def description
    @description
  end

  sig { params(tasks: T::Array[TaskInterface], key: Integer).void }
  def initialize(tasks, key)
    @tasks = tasks
    @key = key
    @description = T.let('View task history', String)
  end

  sig { override.returns(T::Array[TaskInterface]) }
  def do
    puts "@tasks: #{@tasks}"

    task_number = TaskIndexGetter.new(@tasks).index
    HistoryViewer.new(@tasks).view_task_history(task_number)
    PressToContinue.new.do
    @tasks
  end
end
