class JobController < ApplicationController
  before_filter :require_login
  def index
  end

  def get_imdb_all
    Delayed::Job.enqueue ImdbGetAllJob.new
    redirect_to jobs_path, notice: "Job Triggered"
  end

  def get_imdb_posters
    #require "#{Rails.root}/lib/imdb_get_posters.rb"
    Delayed::Job.enqueue ImdbGetPosters.new
    redirect_to jobs_path, notice: "Job Triggered"
  end
end