# encoding: utf-8
class TasksController < ApplicationController
  before_action :set_q, only: %i(index search)

  def index
    @tasks = case params[:sort]
             when "作成順"
               Task.all.recent.page(1)
             when "終了期限の近い順"
               Task.all.near_deadline.page(1)
             else
               Task.all.recent.page(1)
             end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "タスクを作成しました"
      redirect_to @task
    else
      flash.now[:alert] = "タスクの作成に失敗しました"
      render "tasks/new"
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    return unless @task.update(task_params)

    redirect_to @task, notice: "タスクを更新しました"
  end

  def edit
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      flash[:notice] = "タスクを削除しました"
      redirect_to root_path
    else
      flash.now[:alert] = "タスクの削除に失敗しました"
      redirect_to @task
    end
  end

  def search
    @tasks = @q.result(distinct: true).page(1)
  end

  private

  def task_params
    params.require(:task).permit(:name, :content, :expiration_deadline, :sort, :status)
  end

  def set_q
    @statuses = Task.statuses_i18n
    @q = Task.ransack(params[:q])
  end
end
