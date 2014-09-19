class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :checkout_all]
  before_action :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy]
  autocomplete :event, :name, :extra_data => [:member_price, :non_member_price], :full => true

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def checkout_all
    @tickets = @event.tickets
    @tickets.each do |ticket|
      ticket.attendance = false
    end

    ActiveRecord::Base.transaction do 
      @save_results = @tickets.map &:save
      raise ActiveRecord::Rollback unless @save_results.all? 
    end

    respond_to do |format|
      if @save_results.all? 
        format.html { redirect_to @event, notice: "#{@tickets.count} #{"ticket".pluralize(@tickets.count)} successfully checked out." }
        format.js { flash[:notice] = "#{@tickets.count} #{"ticket".pluralize(@tickets.count)} successfully checked out." }
        format.json { render :show, status: :created, location: tickets_path }
      else
        format.html do
          flash[:alert] = "Error checking out tickets."
          render :new
        end
        format.js { flash[:notice] = "Error checking out tickets." }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :code, :member_price, :non_member_price, :starting_serial, :ending_serial)
    end
end
