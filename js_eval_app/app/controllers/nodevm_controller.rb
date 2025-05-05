class NodevmController < ApplicationController
  def index
  end

  def create
    code = params[:code]
    @result = NodeJsExecutorService.execute(code)

    respond_to do |format|
      format.turbo_stream # renders show.turbo_stream.erb
      format.json { render json: result_json }
      format.html { redirect_to node_vm_path, alert: "HTML submissions not supported directly" }
    end
  end

  private

  def result_json
    if @result.success?
      { status: @result.status, result: @result.result }
    else
      { status: @result.status, error: @result.error }
    end
  end
end
