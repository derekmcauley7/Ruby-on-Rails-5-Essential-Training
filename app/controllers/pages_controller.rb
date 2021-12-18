class PagesController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  before_action :set_subjects, :only => [:new, :create, :edit, :update]

  before_action :set_page_count, :only  => [:new, :create, :update, :edit]

  def index
    @pages = Page.sorted
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      flash[:notice] = "Page created successfully."
      redirect_to(pages_path)
    else
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page_count = Page.count +1
    if @page.update(page_params)
      flash[:notice] = "Page updated successfully."
      redirect_to(page_path(@page))
    else
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Page destroyed successfully."
    redirect_to(pages_path)
  end

  private

  def set_subjects
    @subjects = Subject.sorted
  end

  def page_params
    params.require(:page).permit(:subject_id, :name, :position, :visible, :permalink)
  end

  def set_page_count
    @page_count = Page.count
    if params[:action] == 'new' || params[:action] == 'create'
      @page_count + 1
    end
  end

end
