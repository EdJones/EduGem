class AssessmentsController < ApplicationController
  def index
    @assessments = Assessment.all
    @assessment  = Assessment.new
  end

  def show
    @assessment = Assessment.find(params[:id])
  end

  def new
    @assessment = Assessment.new
    3.times do  
     question = @assessment.questions.build  
     4.times { question.answers.build }  
    end      
  end

  def create
    @assessment = Assessment.new(params[:assessment])
    if @assessment.save
      redirect_to edit_assessment_path(@assessment), :notice => "Successfully created assessment."
    else
      render :action => 'new'
    end
  end

  def edit
    @assessment = Assessment.find(params[:id])
  end

  def update
    @assessment = Assessment.find(params[:id])
    if @assessment.update_attributes(params[:assessment])
      redirect_to @assessment, :notice  => "Successfully updated assessment."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @assessment = Assessment.find(params[:id])
    @assessment.destroy
    redirect_to assessments_url, :notice => "Successfully destroyed assessment."
  end
end
