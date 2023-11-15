# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      contents = @report.content.scan(%r{http://localhost:3000/reports/(\d{1,})})
      set_mention(contents)
      
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      mentions = Mention.where(mentioning_report_id: @report.id)
      mentions.each(&:destroy)

      contents = @report.content.scan(%r{http://localhost:3000/reports/(\d{1,})})
      set_mention(contents)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def set_mention(contents)
    unless contents.empty?
      contents.each do |content|
        mention = Mention.new
        mention.mentioning_report_id = @report.id
        mention.mentioned_report_id = content[0]
        mention.save
      end
    end
  end
end
