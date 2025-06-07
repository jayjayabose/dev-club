# frozen_string_literal: true
# typed: strict

require_relative 'task_interface'
require 'sorbet-runtime'

# An improved implementation of a task with additional formatting capabilities.
# This class provides a concrete implementation of the TaskInterface with
# enhanced display functionality.
#
# @see TaskInterface for the required interface methods
class TaskImproved
  extend T::Sig
  include TaskInterface

  # Creates a new task with the given attributes
  #
  # @param description [String] The initial description of the task
  # @param completed [Boolean] Whether the task is completed
  # @param history [Array<String>] The history of task descriptions
  sig { params(description: String, completed: T::Boolean, history: T::Array[String]).void }
  def initialize(description, completed, history)
    @description = description
    @completed = completed
    @history = history
  end

  #------------------------------------------------------------------------
  # Getters
  #------------------------------------------------------------------------

  # @return [String] The current description of the task
  sig { override.returns(String) }
  def description()
    @description
  end

  # @return [Boolean] Whether the task is completed
  sig { override.returns(T::Boolean) }
  def completed()
    @completed
  end

  # @return [Array<String>] The history of task descriptions
  sig { override.returns(T::Array[String]) }
  def history()
    @history
  end

  #------------------------------------------------------------------------
  # Setters
  #------------------------------------------------------------------------

  # Sets the task's description
  # @param description [String] The new description for the task
  sig { override.params(description: String).void }
  def description=(description)
    @description = description  
  end

  # Sets the task's completion status
  # @param completed [Boolean] Whether the task is completed
  sig { override.params(completed: T::Boolean).void}
  def completed=(completed)
    @completed = completed
  end

  # Sets the task's history of descriptions
  # @param history [Array<String>] Array of previous descriptions
  sig { override.params(history: T::Array[String]).void}
  def history=(history)
    @history = history
  end

  #------------------------------------------------------------------------
  # Additional Methods
  #------------------------------------------------------------------------

  # Prints the task in a formatted string with its index, completion status,
  # and description
  #
  # @param index [Integer] The 0-based index of the task in a list
  # @return [void]
  # @example
  #   task = TaskImproved.new("Buy milk", false, [])
  #   task.print(0) # => "1. [ ] Buy milk"
  sig { params(index: Integer).void }
  def print(index)
    status = completed ? '[x]' : '[ ]'
    puts "#{index + 1}. #{status} #{description}"
  end
end