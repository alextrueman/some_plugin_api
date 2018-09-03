class AnalyzerPreparerService
  def initialize(params, analyzed_site, hexdigest)
    @params = params
    @hexdigest = hexdigest
    @analyzed_site =
      analyzed_site ? update_analyzed_site(analyzed_site) : create_analyzed_site
  end

  def call
    AnalyzerWorker.perform_async(@analyzed_site.id)
  end

  private

  def update_analyzed_site(analyzed_site)
    analyzed_site.update(url: analyzed_site.url, hexdigest: @hexdigest, source: @params[:source])
    analyzed_site.queue!
    analyzed_site
  end

  def create_analyzed_site
    AnalyzedSite.create(url: @params[:url], hexdigest: @hexdigest, source: @params[:source])
  end
end
