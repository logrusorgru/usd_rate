class RatesController < ApplicationController
  before_action :set_rate, only: [:show, :edit, :update]

  # GET /
  # GET /.json
  def show
  end

  # GET /admin
  def edit
  end

  # PATCH/PUT /admin
  # PATCH/PUT /admin.json
  def update
    respond_to do |format|
      if @rate.overwrite_the_rate(rate_params)
        msg = 'Курс успешно изменён'
        if not @rate.overwritten? then
          msg = 'Курс успешно откачен обратно, к ЦБР-овскому'
        end
        format.html { redirect_to root_path, notice: msg }
        format.json { render :show, status: :ok, location: '/' }
      else
        format.html { render :edit }
        format.json { render json: @rate.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rate
      @rate = Rate.get_the_rate
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rate_params
      params.require(:rate).permit(:rate, :overwrite)
    end
end
