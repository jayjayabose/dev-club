module TaskInterface
  extend T::Sig
  extend T::Helpers
  interface! # This is a marker to indicate that this module is an interface

  sig { abstract.params(description: String).void }
  def description=(description); end

  sig { abstract.params(completed: T::Boolean).void}
  def completed=(completed); end

  sig { abstract.params(history: T::Array[String]).void}
  def history=(history); end
  
  sig { abstract.returns(String) }
  def description(); end

  sig { abstract.returns(T::Boolean) }
  def completed(); end

  sig { abstract.returns(T::Array[String]) }
  def history(); end
end