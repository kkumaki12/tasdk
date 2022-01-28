class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      render plain: 'ok'
    else
      render plain: 'bad'
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :content)
  end
end
