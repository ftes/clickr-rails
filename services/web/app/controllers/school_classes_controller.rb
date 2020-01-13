class SchoolClassesController < ApplicationController
  before_action :set_school_class, only: %i[show edit update destroy]

  # GET /school_classes
  # GET /school_classes.json
  def index
    @school_classes = SchoolClass.all
  end

  # GET /school_classes/1
  # GET /school_classes/1.json
  def show; end

  # GET /school_classes/new
  def new
    @school_class = SchoolClass.new
  end

  # GET /school_classes/1/edit
  def edit; end

  # POST /school_classes
  # POST /school_classes.json
  def create
    @school_class = SchoolClass.new(school_class_params)

    respond_to do |format|
      if @school_class.save
        format.html { redirect_to @school_class, notice: t('.notice') }
        format.json { render :show, status: :created, location: @school_class }
      else
        format.html { render :new }
        format.json do
          render json: @school_class.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /school_classes/1
  # PATCH/PUT /school_classes/1.json
  def update
    respond_to do |format|
      if @school_class.update(school_class_params)
        format.html { redirect_to @school_class, notice: t('.notice') }
        format.json { render :show, status: :ok, location: @school_class }
      else
        format.html { render :edit }
        format.json do
          render json: @school_class.errors, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /school_classes/1
  # DELETE /school_classes/1.json
  def destroy
    @school_class.destroy
    respond_to do |format|
      format.html { redirect_to school_classes_url, notice: t('.notice') }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_school_class
    @school_class = SchoolClass.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_class_params
    params.require(:school_class).permit(:name)
  end
end
