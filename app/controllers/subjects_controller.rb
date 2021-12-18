class SubjectsController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in

  def index
    @subjects = Subject.sorted
    render("index")
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({ :name => "Default Name" })
    @subject_count = Subject.count + 1
  end

  def create
    @subject = Subject.new(subject_param)
    set_last_position
    if @subject.save
      flash[:notice] = "Subject created successfully."
      redirect_to(subjects_path)
    else
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    @subject = Subject.find(params[:id])
    set_last_position
    if @subject.update(subject_param)
      flash[:notice] = "Subject updated successfully."
      redirect_to(subject_path(@subject))
    else
      @subject_count = Subject.count + 1
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject #{@subject.name} destroyed successfully."
    redirect_to(subjects_path)
  end

  def subject_param
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  private

  def set_last_position
    if @subject.position.nil?
      @subject.position = Subject.sorted.last.position.to_int + 1
    end
  end

end
