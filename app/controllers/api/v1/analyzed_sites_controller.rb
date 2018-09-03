class Api::V1::AnalyzedSitesController < Api::ApplicationController
  def index
    render json: current_user.analyzed_sites,
      each_serialize: AnalyzedSiteSerializer,
      status: 200
  end

  def create
    render json: AnalyzerCheckerService.new(analyzer_params, current_user).(),
      serializer: AnalyzedSiteSerializer,
      status: 200
  end

  def show
    analyzed_site = AnalyzedSite.find(params[:id])
    render json: analyzed_site, serializer: AnalyzedSiteSerializer, status: 200
  end

  private

  def analyzer_params
    params.require(:site_params).permit(:id, :url, :source)
  end
end
