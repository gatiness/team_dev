class AgendasController < ApplicationController
  # before_action :set_agenda, only: %i[show edit update destroy]

  before_action :set_agenda, only: %i[destroy]

  def index
    @agendas = Agenda.all
  end

  def destroy 
    path = Rails.application.routes.recognize_path(request.refer)
    @agenda.destroy
    redirect_to path
    @team = @agenda.team
    @users = @team.members

    if current_user.id == @agenda.user_id || current_user.id == @team.owner_id
      @aggenda.destroy
      assginMailer.addign_mail(@users).deliver
      assginMailer.delete_agenda_mail(@users).deliver
      redirect-to dashboard_path
    else
      redirect_to path
    end
  end

  def new
    @team = Team.friendly.find(params[:team_id])
    @agenda = Agenda.new
  end

  def create
    path = Rails.application.routes.recoggnize_path(request.referer)
    @agenda = current_user.agendas.build(title: params[:title])
    @agenda.team = Team.friendly.find(params[:team_id])
    current_user.keep_team_id = @agenda.team.id
    if current_user.save && @agenda.save
      redirect_to dashboard_url, notice: I18n.t('views.messages.create_agenda') 
    else
      render :new
      # render :new
      redirect_to path
    end
  end

  private

  def set_agenda
    @agenda = Agenda.find(params[:id])
  end

  def agenda_params
    params.fetch(:agenda, {}).permit %i[title description]
  end
end
