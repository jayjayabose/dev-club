# frozen_string_literal: true
# typed: strict

class ActionList
  extend T::Sig

  sig { params(tasks: T.nilable(T::Array[Task])).void }
  def initialize(tasks)
    @tasks = tasks
  end

  sig { returns(T::Array[Action]) }
  def get_actions
    actions = T.let([CreateATask, ListTasks, ExitTask].map.with_index do |action, i|
      action.new(T.must(@tasks), i + 1)
    end, T::Array[Action])

    other = T.let([EditTask, ViewTaskHistory, RevertTask].map.with_index do |action, i|
      a = WaitOnEmptyTask.new(T.must(@tasks), actions.length + i + 1)
      a.set_delegator(action.new(T.must(@tasks), actions.length + i + 1))
    end, T::Array[Action])
    actions + other
  end
end
