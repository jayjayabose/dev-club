# frozen_string_literal: true
# typed: strict

require 'sorbet-runtime'

# Interface defining the contract for task objects in the todo application.
# Any class that implements this interface must provide methods for managing
# a task's description, completion status, and history.
#
# @abstract Subclasses must implement all abstract methods
# @example
#   class Task
#     include TaskInterface
#     def description=(desc); @description = desc; end
#     def description; @description; end
#     # ... implement other methods
#   end
module TaskInterface
  extend T::Sig
  extend T::Helpers
  interface! # This is a marker to indicate that this module is an interface

  # Getters
  #------------------------------------------------------------------------

  # Gets the task's current description
  # @return [String] The task's description
  sig { abstract.returns(String) }
  def description(); end

  # Gets the task's completion status
  # @return [Boolean] Whether the task is completed
  sig { abstract.returns(T::Boolean) }
  def completed(); end

  # Gets the task's history of descriptions
  # @return [Array<String>] Array of previous descriptions
  sig { abstract.returns(T::Array[String]) }
  def history(); end

  # Setters
  #------------------------------------------------------------------------

  # Sets the task's description
  # @param description [String] The new description for the task
  # @return [void]
  sig { abstract.params(description: String).void }
  def description=(description); end

  # Sets the task's completion status
  # @param completed [Boolean] Whether the task is completed
  # @return [void]
  sig { abstract.params(completed: T::Boolean).void}
  def completed=(completed); end

  # Sets the task's history of descriptions
  # @param history [Array<String>] Array of previous descriptions
  # @return [void]
  sig { abstract.params(history: T::Array[String]).void}
  def history=(history); end
end