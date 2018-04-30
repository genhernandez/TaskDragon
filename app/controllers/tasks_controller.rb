class TasksController < ApplicationController
    def index
        sort = params["sort_by"]
        if sort == nil || sort.empty?
            sort = "title"
        end
        @tasks = current_user.team.tasks.all.order("complete ASC, #{sort} ASC")
    end

    def show
        id = params[:id]
        @task = Task.find(id)
    end

    def new
        @task = current_user.team.tasks.build
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            redirect_to team_tasks_path(:id => current_team_id, :anchor => 'list')
        else
            redirect_to team_tasks_path(:id => current_team_id, :anchor => 'list')
            flash[:notice] = "Task can't be created without a title."
        end
    end

    def edit
        @task = Task.find params[:id]
    end

    def update
        @task = Task.find params[:id]
        if @task.update_attributes(task_params)
            redirect_to team_tasks_path(:id => current_team_id, :anchor => 'list')
        else
            redirect_to team_tasks_path(:id => current_team_id, :anchor => 'list')
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to team_tasks_path(:id => current_team_id, :anchor => 'list')
    end

    def complete
        @task = Task.find params[:id]
        completed = !@task.complete
        @task.update_attributes!(:complete => completed)
        dragon = current_user.team.dragon
        points = 10
        case @task.priority
        when 1
            points *= 5
        when 2
            points *= 4
        when 3
            points *= 3
        when 4
            points *= 2
        end
        if completed
            dragon.level_up(current_user, points, image_urls)
        else
            dragon.level_up(current_user, -points, image_urls)
        end
        redirect_to team_tasks_path(:id => current_team_id, :anchor => 'list')
    end

    private
    def task_params
        params.require(:task).permit(:title, :priority, :description, :due).merge(team: current_user.team)
    end
end
