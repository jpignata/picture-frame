class Body
  include EM::Deferrable

  def each(&block)
    @callback = block
  end

  def write(data)
    @callback.call(data)
  end
end
