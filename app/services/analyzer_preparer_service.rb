class AnalyzerPreparerService
  def initialize(params, hexdigest, analyzed_site)
    @params = params
    @hexdigest = hexdigest
    @analyzed_site = analyzed_site || create_analyzed_site
  end

  def call
    @analyzed_site.queue

    AnalyzerWorker.perform_async(@analyzed_site.id)

    analyzed_site.status
  end

  private

  def create_analyzed_site
    AnalyzedSite.create(url: @params[:url], hexdigest: @hexdigest, source: @params[:source])
  end
end
