class SectionsController < ApplicationController

  layout 'admin'

  def index
    @sections = Section.sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section_count = Section.count + 1
    @pages = Page.sorted
    @section = Section.new
  end

  def create
    @section_count = Section.count + 1
    @pages = Page.sorted
    @section = Section.new(section_params)
    if @section.save
      flash[:notice] = "Section created successfully."
      redirect_to(sections_path)
    else
      @section_count = Section.count + 1
      @pages = Page.sorted
      render('new')
    end
  end

  def edit
    @section_count = Section.count
    @pages = Page.sorted
    @section = Section.find(params[:id])
  end

  def update
    @section_count = Section.count + 1
    @pages = Page.sorted
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

  def section_params
    params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
  end

end
