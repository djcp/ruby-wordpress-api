module Comments
  
  def getCommentCount(options = {})
    default_options = {
      :post_id => nil
    }.deep_merge!(options)
    execute('getCommentCount', default_options)
  end

  def getComment(options = {})
    default_options = {
      :comment_id => nil
    }.deep_merge!(options)
    execute('getComment', default_options)
  end

  def getComments(options = {})
    default_options = {
      :filter => {}
    }.deep_merge!(options)
    execute('getComments', default_options)
  end

  def newComment(options = {})
    default_options = {
      :post_id => nil,
      :comment => {}
    }.deep_merge!(options)
    execute('newComment', default_options)
  end

  def editComment(options = {})
    default_options = {
      :comment_id => nil,
      :comment => {}
    }.deep_merge!(options)
    execute('editComment', default_options)
  end

  def deleteComment(options = {})
    default_options = {
      :comment_id => nil
    }.deep_merge!(options)
    execute('deleteComment', default_options)
  end

  def getCommentStatusList(options = {})
    execute('getCommentStatusList', options)
  end

end