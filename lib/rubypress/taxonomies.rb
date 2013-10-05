module Taxonomies

  def getTaxonomy(options = {})
    default_options = {
      :taxonomy => 'category'
    }.deep_merge!(options)
    execute('getTaxonomy', default_options)
  end

  def getTaxonomies(options = {})
    execute('getTaxonomies', options)
  end

  def getTerm(options = {})
    default_options = {
      :taxonomy => 'category',
      :term_id => nil
    }.deep_merge!(options)
    execute('getTerm', default_options)
  end

  def getTerms(options = {})
    default_options = {
      :taxonomy => 'category',
      :filter => {}
    }.deep_merge!(options)
    execute('getTerms', default_options)
  end

  def newTerm(options = {})
    default_options = {
      :content => {}
    }.deep_merge!(options)
    execute('newTerm', default_options)
  end

  def editTerm(options = {})
    default_options = {
      :term_id => nil,
      :content => {}
    }.deep_merge!(options)
    execute('editTerm', default_options)
  end

  def deleteTerm(options = {})
    default_options = {
      :taxonomy => nil,
      :term_id => nil
    }.deep_merge!(options)
    execute('deleteTerm', default_options)
  end

end