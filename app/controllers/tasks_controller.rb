# encoding: utf-8
class TasksController < ApplicationController
  def index
    @tasks = Task.all
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

  private

  def task_params
    params.require(:task).permit(:name, :content)
  end
end
