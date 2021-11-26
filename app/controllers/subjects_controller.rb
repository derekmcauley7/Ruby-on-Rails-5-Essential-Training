class SubjectsController < ApplicationController

  def index
    @subjects = Subject.sorted
    render("index")
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({ :name => "Default Name" })
  end

  def create
    @subject = Subject.new(subject_param)
    if @subject.save
      redirect_to(subjects_path)
    else
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_param)
      redirect_to(subject_path(@subject))
    else
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
    @subject.destroy
    redirect_to(subjects_path)
  end

  def destroy

  end

  def subject_param
    params.require(:subject).permit(:name, :position, :visible)
  end

end
