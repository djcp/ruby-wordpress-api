module Media

  def getMediaItem(options = {})
    default_options = {
      :attachment_id => nil
    }.deep_merge!(options)
    execute('getMediaItem', default_options)
  end

  def getMediaLibrary(options = {})
    default_options = {
      :filter => {}
    }.deep_merge!(options)
    execute('getMediaLibrary', default_options)
  end

  def uploadFile(options = {})
    default_options = {
      :data => {}
    }.deep_merge!(options)
    execute('uploadFile', default_options)
  end

end