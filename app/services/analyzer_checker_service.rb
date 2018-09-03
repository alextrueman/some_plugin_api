class AnalyzerCheckerService
  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    if valid_analyzed_site?
      analyzed_site.status
    else
      start_analyze(params, analyzed_site)
    end
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
    AnalyzerPreparerService.new(params, analyzed_site, hexdigest).()
  end
end
