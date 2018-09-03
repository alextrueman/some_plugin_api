class Api::V1::AnalyzedSitesController < Api::ApplicationController
  def create
    render
      json: { status: AnalyzerCheckerService.new(analyzer_params, current_user).() },
      status: 200
  end

  def show
    if analyzed_site
      render json: { status: analyzed_site.status }, status: 200
    else
      render json: { status: 'Site was not analyzed' }, status: 200
    end
  end

  private

  def analyzer_params
    params.require(:site_params).permit(:url, :source)
  end

  def analyzed_site
    @_analyzed_site ||= AnalyzedSite.find_by(url: params[:url])
  end
end
