class SectionsController < ApplicationController

  layout 'admin'

  before_action :get_pages, :only => [:new, :create, :edit, :update]
  before_action :get_session_count, :only => [:new, :update, :create, :edit]

  def index
    logger.debug("****** Testing the logger. ******")
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to(sections_path)
    else
      render('new')
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    if @section.update(section_params)
      flash[:notice] = "Section updated successfully."
      redirect_to(section_path(@section))
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section destroyed successfully."
    redirect_to(sections_path)
  end

  private

  def get_session_count
    @section_count = Section.count
    if params[:action] == 'new' || params[:action] == 'create' || params[:action] == 'update'
      @section_count + 1
    end
  end

  private

  def get_pages
    @pages = Page.sorted
  end

  private

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

end
