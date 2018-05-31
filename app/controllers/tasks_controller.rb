class TasksController < ApplicationController
before_action :require_user_logged_in
before_action :correct_user, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      @user = current_user
      @tasks = Task.all
    end
  end

  def show
    @user = current_user
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params) #Strong Parameterを使用

    if @task.save
      flash[:success] = "タスクが正常に登録されました"
      redirect_to root_url
    else
      flash[:danger] = "タスクの登録に失敗しました"
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "タスクは正常に更新されました"
      redirect_to @task
    else
      flash[:danger] = "タスクの更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @task.destroy
    flash[:success] = "タスクは正常に削除されました"
    redirect_back(fallback_location: root_path)
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
