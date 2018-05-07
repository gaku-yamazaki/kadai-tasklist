class TasksController < ApplicationController
  def index
    # 一覧表示するためのアクションを記入
    # 取得した情報はView側でも使用するため、インスタンス変数とする
    @tasks = Task.all
  end

  def show
    # 指定したidに対応する内容を取得
    @task = Task.find(params[:id])
  end

  def new
    # 新しいインスタンスを作成
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
  
  # Strong Parameter (content以外のカラムをフィルダリング)
  def task_params
    params.require(:task).permit(:content)
  end
end
