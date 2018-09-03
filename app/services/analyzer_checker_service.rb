class AnalyzerCheckerService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    start_analyze until valid_analyzed_site?

    UserAnalyzedSite.find_or_create_by(user: @current_user, analyzed_site: analyzed_site)

    analyzed_site
  end

  private

  def valid_analyzed_site?
    analyzed_site && analyzed_site.hexdigest == hexdigest
  end

  def analyzed_site
    @analyzed_site ||= AnalyzedSite.find_by(url: @params[:url])
  end

  def hexdigest
    @hex ||= Digest::SHA1.hexdigest(@params[:source])
  end

  def start_analyze
    AnalyzerPreparerService.new(@params, analyzed_site, hexdigest).()
  end
end
