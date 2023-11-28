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
    ActiveRecord::Base.transaction do
      @report = current_user.reports.new(report_params)

      if @report.save
        @report.create_mentions
        redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
      else
        render :new, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("エラーが発生しました: #{e.message}")
    render :new, status: :unprocessable_entity
  end

  def update
    ActiveRecord::Base.transaction do
      if @report.update(report_params)
        Mention.where(mentioned_report_id: @report.id).find_each(&:destroy)
        @report.create_mentions
        redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
      else
        render :edit, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("エラーが発生しました: #{e.message}")
    flash[:alert] = t('views.common.error')
    render :edit, status: :unprocessable_entity
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
end
