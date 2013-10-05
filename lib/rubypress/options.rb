module Options

  def getOptions(options = {})
    default_options = {
      :options => []
    }.deep_merge!(options)
    execute('getOptions', default_options)
  end

  def setOptions(options = {})
    default_options = {
      :options => []
    }.deep_merge!(options)
    execute('setOptions', default_options)
  end

end