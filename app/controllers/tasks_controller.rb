class TasksController < ApplicationController
  def index
    if logged_in?
      @user = current_user
    end
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params) #Strong Parameterを使用
    
    if @task.save
      flash[:success] = "タスクが正常に登録されました"
      redirect_to @task
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
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "タスクは正常に削除されました"
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter (content以外のカラムをフィルダリング)
  def task_params
    params.require(:task).permit(:content, :status)
  end
end