module Rubypress

  module Posts

    def getPost(options = {})
      default_options = {
        :post_id => nil,
        :fields => self.default_post_fields
      }.deep_merge!(options)
      execute('getPost', default_options)
    end

    def getPosts(options = {})
      default_options = {
        :filter => {
          :post_type => 'post',
          :orderby => 'post_date',
          :order => 'asc',
          :fields => self.default_post_fields
        }
      }.deep_merge!(options)
      execute('getPosts', default_options)
    end

    def newPost(options = {})
      default_options = {
        :content => {}
      }.deep_merge!(options)
      execute('newPost', default_options)
    end

    def editPost(options = {})
       default_options = {
        :post_id => nil,
        :content => {}
      }.deep_merge!(options)
      execute('editPost', default_options)
    end

    def deletePost(options = {})
      default_options = {
        :post_id => nil
      }.deep_merge!(options)
      execute('deletePost', default_options)
    end

    def getPostType(options = {})
      default_options = {
        :post_type_name => nil,
        :fields => []
      }.deep_merge!(options)
      execute('getPostType', default_options)
    end

     def getPostTypes(options = {})
      default_options = {
        :filter => {},
        :fields => []
      }.deep_merge!(options)
      execute('getPostTypes', default_options)
    end

    def getPostFormats(options = {})
      default_options = {
        :filter => {}
      }.deep_merge!(options)
      execute('getPostFormats', default_options)
    end

    def getPostStatusList(options = {})
      execute('getPostStatusList', options)
    end

  end

end
