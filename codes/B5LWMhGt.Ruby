# Ancestor must provide PERMIT_FIELDS constant to filter input params with
# strong attributes.
#
# See App::Search.
class AbstractSearch
  include ActiveModel::Model

  class << self
    # Defines accessors for fields from params, where params are parsed with
    # `ParamsParser.parse_:type`.
    def parsed_params(params)
      params.each do |field, type|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{field}
            if defined?(@#{field})
              @#{field}
            else
              @#{field} = ParamsParser.parse_#{type}(params[:#{field}])
            end
          end
        RUBY
      end
    end

    attr_writer :default_per_page

    def default_per_page
      @default_per_page || 10
    end

    # Class to call `search_elastics` on. Default to `parent`.
    def model_class
      @model_class || self.model_class = parent
    end

    # Sets `model_class` and updates `default_per_page`.
    def model_class=(klass)
      @model_class = klass
      new_default = klass.try(:default_per_page)
      self.default_per_page = new_default if new_default
    end

    def request_class
      @request_class ||= self::Request
    end

    attr_writer :request_class
  end

  attr_reader :params, :options

  # `params` is a hash to perform search with. `options` are bypassed to
  # `search_elastics` method.
  def initialize(params, **options)
    @options = options
    @params = if params.respond_to?(:permit)
                params.permit(*self.class::PERMIT_FIELDS)
              else
                params
              end
  end

  # Method to access Elastic's result object.
  def result
    @result ||= self.class.model_class.search_elastics(
      self.class.request_class.new(self).as_json,
      options
    )
  end

  delegate :ids, :collection, :relation, :aggregations, :total, to: :result

  # Hash-like access to available methods.
  def [](key)
    public_send(key)
  end

  # Requested page number.
  def page
    @page ||= begin
      val = ParamsParser.parse_int(params[:page]) || 1
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
        (ParamsParser.parse_int(params[:per_page]) || self.class.default_per_page),
        100,
      ].min,
      0,
    ].max
  end

  # Return filtered AREL-compatible hash to sort by.
  def sort
    @sort ||= begin
      val = SortScope.filter_param(params[:sort], params, self.class::ALLOWED_SORT)
      val || (query_string.present? ? {_score: :desc} : self.class::DEFAULT_SORT)
    end
  end

  # for Kaminari
  alias_method :limit_value, :per_page
  alias_method :current_page, :page

  def total_pages
    (total.to_f / limit_value).ceil
  end
end


class App
  # Search is used to process & validate user input into search form.
  # It builds ES query with Search::Request, passing filtered input to it,
  # and performs it.
  #
  # It also has attribute methods to populate search form inputs, paginator.
  class Search < ::AbstractSearch
    ALLOWED_SORT = %w(
      published_at
      updated_at
      rating
      downloads_count
      reviews_count
      grouping_rank
    )
    DEFAULT_SORT = {published_at: :desc}

    # Params that should be kept while navigating in search form.
    TRANSITIONAL_PARAMS = [
      :q,
      :sort,
      :sort_desc,
      :publisher_ids,
    ]

    PERMIT_FIELDS = [
      :q,
      :featured,
      :page,
      :per_page,
      :sort,
      :sort_desc,
      publisher_ids:  [],
      category_ids:   [],
      group_ids:      [],
    ]

    parsed_params(
      q:              :string,
      publisher_ids:  :int_array,
      category_ids:   :int_array,
      group_ids:      :int_array,
      featured:       :boolean,
    )

    class << self
      def sort_name(sort)
        t(".sort.#{sort}")
      end
    end

    attr_reader :user, :device

    def initialize(params, user_or_device = nil, **options)
      super(params, options)
      if user_or_device.is_a?(User)
        @user = user_or_device
        @device = nil
      elsif user_or_device
        @user = user_or_device.user
        @device = user_or_device
      end
      # Default sort order is DESC.
      self.params[:sort_desc] = true unless self.params.key?(:sort_desc)
    end

    delegate  :sdk_version,
              :screen_size,
              :feature_ids,
              :library_ids,
              :gl_texture_ids,
              :gl_es,
              to: :device, allow_nil: true

    # Return filtered AREL-compatible hash to sort by.
    # If no sort param given, it uses default values:
    #
    #   - `_score` if query string is requested,
    #   - `rank` if app group is requested.
    #   - DEFAULT_SORT otherwise.
    def sort
      @sort ||= begin
        val = SortScope.filter_param(params[:sort], params, ALLOWED_SORT)
        case
        when val then val
        when query_string.present? then {_score: :desc}
        when group_ids.present? then {'grouping_rank' => :asc}
        else DEFAULT_SORT
        end
      end
    end

    # List of attributes on which sort is allowed.
    def available_sort
      result = ALLOWED_SORT.dup
      result.unshift :_score if query_string.present?
      result.unshift :rank if group_ids.present?
      result
    end

    alias_method :query_string, :q
  end
end

require_dependency 'app/search/request'