module Users

  def getUsersBlogs
    self.connection.call('wp.getUsersBlogs', self.username, self.password)
  end

  def getUser(options = {})
    default_options = {
      :user_id => nil,
      :fields => []
    }.deep_merge!(options)
    execute('getUser', default_options)
  end

  def getUsers(options = {})
    default_options = {
      :filter => {}
    }.deep_merge!(options)
    execute('getUsers', default_options)
  end

  def getProfile(options = {})
    default_options = {
      :fields => []
    }.deep_merge!(options)
    execute('getProfile', default_options)
  end

  def editProfile(options = {})
    default_options = {
      :content => {}
    }.deep_merge!(options)
    execute('editProfile', default_options)
  end

  def getAuthors(options = {})
    execute('getAuthors', options)
  end

end