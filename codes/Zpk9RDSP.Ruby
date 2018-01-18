class AbstractSiteSearch
  include ActiveModel::Model

  class << self
    # rubocop:disable LineLength
    def parsed_params(params)
      params.each do |field, type|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{field}                                                            # def q
            if defined?(@#{field})                                                #   if defined?(@q)
              @#{field}                                                           #     @q
            else                                                                  #   else
              @#{field} = ParamsParser.parse_#{type}(@params[:#{field}])          #    @q = ParamsParser.parse_string(@params[:q])
            end                                                                   #   end
          end                                                                     # end
        RUBY
      end
    end
    # rubocop:enable LineLength

    attr_writer :default_per_page

    def default_per_page
      @default_per_page || 10
    end
  end

  def initialize(params = {})
    @params = if params.respond_to?(:permit)
                params.permit(*self.class::PERMIT_FIELDS)
              else
                params
              end
  end

  delegate :collection, :relation, :aggregations, :total, to: :result

  # Hash-like access to available methods.
  def [](key)
    public_send(key)
  end

  # Query string is made from `params` param without tags.
  def query_string
    tags unless defined? @query_string
    @query_string
  end

  # Tags extracted from `raw_query_string` param.
  def tags
    @tags ||= begin
      @query_string = raw_query_string
      if @query_string
        @query_string = @query_string.dup
        Tag.extract_from_string!(@query_string)
      else
        []
      end
    end
  end

  # Requested page number.
  def page
    @page ||= begin
      val = ParamsParser.parse_int(@params[:page]) || 1
      if val > 0
        val
      else
        @per_page = 0
        0
      end
    end
  end

  # Requested per_page count.
  def per_page
    @per_page ||= [
      [
        (ParamsParser.parse_int(@params[:per_page]) || self.class.default_per_page),
        100,
      ].min,
      0,
    ].max
  end

  # for Kaminari
  alias_method :limit_value, :per_page
  alias_method :current_page, :page

  def total_pages
    (total.to_f / limit_value).ceil
  end
end


class Post
  # SiteSearch is used to process & validate user input into search form.
  # It builds ES query with SiteSearch::Request, passing filtered input to it,
  # and performs it.
  #
  # It also has attribute methods to populate search form inputs, paginator
  class SiteSearch < ::AbstractSiteSearch
    DEFAULT_SORT =  {published_at: :desc}
    PERMIT_FIELDS = [:s]

    parsed_params s: :string

    self.default_per_page = Post.default_per_page

    # Method to access Elastic's result object.
    def result
      @result ||= Post.search_elastics Request.new(self).as_json,
        scope: ->(scope) { scope.includes(:user) }
    end

    def sort
      @query_string.present? ? {_score: :desc} : DEFAULT_SORT
    end

    alias_method :raw_query_string, :s
  end
end

require_dependency 'post/site_search/request'