module SearchBuilder
  def search_products
    if params["search_string"]
      hash = basic_query
      hash[:sort] = build_sort if params[:sort]
      hash[:aggs] = build_aggs if params[:page] == "1"
      response = Product.__elasticsearch__.search(hash)
      @aggs = build_aggs_result(response.aggregations)
      @products = response.page(params[:page]).records
    else
      hash = build_match_all
      response = Product.__elasticsearch__.search(hash)
      @aggs = build_aggs_result(response.aggregations) if hash[:aggs] && response
      @products = response.page(params[:page]).records
    end
    [@products, @aggs]
  end

  def basic_query
    hash = {query: {
                    query_string: {
                      default_field: "reference_name",
                      query: build_search_string(params)
                      }
                    }, size: 200
                  }
    hash
  end

  def build_sort
    args = params[:sort].split(", ")
    [{args[0] => args[1]}]
  end

  def build_match_all
    hash = {}
    hash[:query] = {match_all: {}}
    if params[:origin] == "app"
      params[:filters][:ub] = true
    end
    where_opts = convert_filters_to_hash(params[:filters])
    where_opts = where_opts.map {|key, v| {term: {key.to_sym => v}}}
    if params[:page] == "1"
      hash = no_search_aggs(where_opts)
    else
      hash[:filter] = { and: where_opts}
    end


    if params[:sort]
      args = params[:sort].split(", ")
      hash[:sort] = [{args[0] => args[1]}]
    end
    hash
  end

  def build_search_string(params)
    if params[:origin] == "app"
      params[:filters][:ub] = true
    end
    filters = params[:filters] ? convert_filters_to_hash(params[:filters]) : {}
    string = params[:search_string].try(:downcase).try(:strip) || '*'
    if filters["category_id"]
      curr_category = Category.find(filters["category_id"])
      string = string.remove(curr_category.name).remove(curr_category.name.singularize).strip
    end
    if string.strip == ""
      string = params[:search_string].downcase.strip
    end
    string = string.downcase.split(" ").join("^2 ") + '^2' + ' OR ' + string.downcase.split(" ").join("~1 ") + '~1'
    if !filters.empty?
      string = build_filters(string, filters)
    end
    string
  end

  def build_filters(string, filters)
    filters.each do |key, val|
      string += ' AND ' + key + ': ' + val.try(:to_s) if val
    end
    string
  end
end
