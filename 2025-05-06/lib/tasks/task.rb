# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'
require_relative 'task_interface'
class Task
  extend T::Sig
  include TaskInterface

  sig { params(description: String, completed: T::Boolean, history: T::Array[String]).void }
  def initialize(description, completed, history)
    @description = description
    @completed = completed
    @history = history
  end

  sig { override.params(description: String).void }
  def description=(description)
    @description = description  
  end

  sig { override.params(completed: T::Boolean).void}
  def completed=(completed)
    @completed = completed
  end

  sig { override.params(history: T::Array[String]).void}
  def history=(history)
    @history = history
  end
  
  sig { override.returns(String) }
  def description()
    @description
  end

  sig { override.returns(T::Boolean) }
  def completed()
    @completed
  end

  sig { override.returns(T::Array[String]) }
  def history()
    @history
  end  
end