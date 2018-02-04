module SearchHelper
  FilterTags = %w[Citation/Author Institution Tag Title Translation User]

  def create_query(filter, language)
    filter.capitalize!
    language.capitalize!

    return [] unless (FilterTags.include? filter or filter == "Citation")
    return [] unless Language.exists?(:name => language) or language == "Any"
    query_method = {
        "Citation" => :citation_author_query,
        "Instutiton" => :institution_query,
        "Tag" => :tag_query,
        "Title" => :title_query,
        "Translation" => :translation_query,
        "User" => :user_query
    }[filter]

    SearchHelper.send(query_method, language)

  end
  
  def citation_author_query(language)
    [Example.first]
  end

  def institution_query(language)
    [Example.first]

  end

  def tag_query(language)
    [Example.first]

  end

  def title_query(language)
    [Example.first]

  end

  def translation_query(language)
    [Example.first]

  end

  def user_query(language)
    [Example.first]
  end
end