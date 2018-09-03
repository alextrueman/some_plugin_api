class AnalyzerWorker
  include Sidekiq::Worker

  def perform(analyzed_site_id)
    AnalyzerAlgorithmService.new(analyzed_site_id).()
  end
end
