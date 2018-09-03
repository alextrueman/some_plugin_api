class Api::V1::AnalyzedSitesController < Api::ApplicationController
  def index
    render json: { analyzed_sites: current_user.analyzed_sites }, status: 200
  end

  def create
    render json: AnalyzerCheckerService.new(analyzer_params, current_user).(),
      status: 200
  end

  def show
    analyzed_site = AnalyzedSite.find(params[:id])
    render json: analyzed_site, status: 200
  end

  private

  def analyzer_params
    params.require(:site_params).permit(:id, :url, :source)
  end
end
