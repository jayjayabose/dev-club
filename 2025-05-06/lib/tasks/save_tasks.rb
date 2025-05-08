# frozen_string_literal: true
# typed: true

require "sqlite3"


class SaveTasks
  extend T::Sig
  include Action
  sig { params(tasks: T::Array[Task], key: Integer).void }

  def initialize(tasks, key)
    @tasks = tasks
    @key = key
    @description = T.let('Save tasks', String)
    @db = SQLite3::Database.new "./db/tasks.db"
  end

  sig { override.returns(T::Array[Task]) }
  def do
    puts 'Saving tasks:'
    
    @tasks.each_with_index do |task, i|
      @db.execute "insert into task values (?, ?, ?)", [i, task.description, task.completed.to_s]
      task.history.each do |h|
        @db.execute "insert into history values (?, ?)", [i, h]
      end
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
