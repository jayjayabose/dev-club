# frozen_string_literal: true
# typed: true

require "sqlite3"


class LoadTasks
  extend T::Sig
  include Action
  sig { params(tasks: T::Array[Task], key: Integer).void }

  def initialize(tasks, key)
    @tasks = tasks
    @key = key
    @description = T.let('Load tasks', String)
    @db = SQLite3::Database.new "./db/tasks.db"
  end

  sig { override.returns(T::Array[Task]) }
  def do
    puts 'Loaded tasks'
    @db.execute "select * from task;" do |row|
      history = []
      @db.execute "select * from history where task_id = ?", row[0] do |h_row|
        history << h_row[0]
      end
      completed = false
      if row[1] == 1
        completed = true
      end
      @tasks << Task.new(row[1], completed, history)
    end
    
    PressToContinue.new.do
    @tasks
  end

  sig { override.returns(String) }
  def description
    @description
  end
  sig { override.returns(Integer) }
  def key
    @key
  end
end
