class AnalyzerAlgorithmService
  def initialize(analyzed_site_id)
    @analyzed_site = AnalyzedSite.find(analyzed_site_id)
  end

  def call
    sleep(60)
    @analyzed_site.source.length.even? ? @analyzed_site.approve : @analyzed_site.reject
  end
end
