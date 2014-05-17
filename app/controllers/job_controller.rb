class JobController < ApplicationController
  def index
  end

  def get_imdb_all
    Delayed::Job.enqueue ImdbGetAllJob.new
    flash[:notice] = "Job triggered"  
    redirect_to jobs_path
  end
end