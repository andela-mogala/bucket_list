class ApiConstraintsService
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(request)
    @default || request.headers['Accept'].
                  include?("application/vnd.mybucket.v#{@version}")
  end
end